import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:form_builder_extra_fields/form_builder_extra_fields.dart';
import 'package:get_it/get_it.dart';
import 'package:hui_management/filters/subuser_filter.dart';
import 'package:hui_management/helper/dialog.dart';
import 'package:hui_management/model/fund_member.dart';
import 'package:hui_management/model/fund_model.dart';
import 'package:hui_management/model/sub_user_model.dart';
import 'package:hui_management/provider/fund_provider.dart';
import 'package:hui_management/provider/general_fund_provider.dart';
import 'package:hui_management/service/user_service.dart';
import 'package:hui_management/view/member/simple_member_widget.dart';
import 'package:provider/provider.dart';

class FundMemberWidget extends StatelessWidget {
  final FundMember fundMember;

  const FundMemberWidget({super.key, required this.fundMember});

  @override
  Widget build(BuildContext context) {
    final fundProvider = Provider.of<FundProvider>(context, listen: false);
    final generalFundProvider = Provider.of<GeneralFundProvider>(context, listen: false);

    return Slidable(
      // The start action pane is the one at the left or the top side.
      startActionPane: ActionPane(
        // A motion is a widget used to control how the pane animates.
        motion: const ScrollMotion(),

        // All actions are defined in the children parameter.
        children: (fundProvider.fund.sessionsCount != 0)
            ? []
            : [
                // A SlidableAction can have an icon and/or a label.
                SlidableAction(
                  onPressed: (context) async {
                    fundProvider.removeMember(fundMember.id).andThen(() => fundProvider.getFund(fundProvider.fund.id)).match(
                      (l) {
                        log(l);
                        DialogHelper.showSnackBar(context, 'Có lỗi khi xóa thành viên');
                      },
                      (r) {
                        generalFundProvider.updateGeneralFundMemberCount(fundProvider.fund.id, -1);
                        log("OK");
                        DialogHelper.showSnackBar(context, 'Xóa thành viên thành công');
                      },
                    ).run();
                  },
                  backgroundColor: const Color(0xFFFE4A49),
                  foregroundColor: Colors.white,
                  icon: Icons.delete,
                  label: 'Xóa',
                ),
              ],
      ),

      // The child of the Slidable is what the user sees when the
      // component is not dragged.
      child: Card(
        shape: RoundedRectangleBorder(
          side: BorderSide(color: fundMember.hasFinalSettlementForDeadSessionBill ? Colors.blue : Colors.white, width: 2.0),
          borderRadius: BorderRadius.circular(4.0),
        ),
        child: Column(
          children: <Widget>[
            ListTile(
              leading: CachedNetworkImage(
                imageUrl: fundMember.subUser.imageUrl,
                imageBuilder: (context, imageProvider) => Container(
                  width: 80.0,
                  height: 80.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(image: imageProvider, fit: BoxFit.scaleDown),
                  ),
                ),
                placeholder: (context, url) => const CircularProgressIndicator(),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
              title: Text(fundMember.nickName),
              subtitle: Text('${fundMember.subUser.identity}\n${fundMember.subUser.phoneNumber}\n${fundMember.subUser.bankName} - ${fundMember.subUser.bankNumber}\n${fundMember.subUser.address}\n${fundMember.subUser.additionalInfo}\n${fundMember.hasFinalSettlementForDeadSessionBill ? '⭐ Đã tất toán hụi chết ' : ''} '),
            )
          ],
        ),
      ),
    );
  }
}

class AddMemberWidget extends StatelessWidget {
  final Fund fund;

  AddMemberWidget({super.key, required this.fund});

  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    final fundProvider = Provider.of<FundProvider>(context, listen: false);
    final generalFundProvider = Provider.of<GeneralFundProvider>(context, listen: false);

    return Column(
      children: [
        Text('Tổng số thành viên ${fund.membersCount}'),
        Row(
          children: [
            Expanded(
              flex: 7,
              child: FormBuilder(
                key: _formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: FormBuilderSearchableDropdown<SubUserModel>(
                  popupProps: PopupProps.dialog(showSearchBox: true, isFilterOnline: true, itemBuilder: (context, item, isSelected) => SimpleMemberWidget(subuser: item)),
                  name: 'searchable_dropdown_user',
                  decoration: const InputDecoration(
                    labelText: 'Chọn người dùng',
                  ),
                  compareFn: (user1, user2) => user1.name != user2.name,
                  dropdownBuilder: (context, selectedItem) => selectedItem == null ? const Text('Chưa chọn thành viên mới') : SimpleMemberWidget(subuser: selectedItem),
                  asyncItems: (filter) async {
                    //0 will be infinite fetch
                    final users = await GetIt.I<UserService>().getAll(0, 0, SubUserFilter(searchTerm: filter));
                    return users;
                  },
                ),
              ),
            ),
            Container(
              width: 15.0,
            ),
            Expanded(
              flex: 3,
              child: ElevatedButton(
                onPressed: () {
                  final user = _formKey.currentState!.fields['searchable_dropdown_user']?.value as SubUserModel?;

                  if (user == null) {
                    return;
                  }

                  fundProvider
                      .addMember(user.id)
                      .andThen(
                        () => fundProvider.getFund(fund.id),
                      )
                      .match(
                    (l) {
                      log(l);
                      DialogHelper.showSnackBar(context, 'Có lỗi khi thêm thành viên mới');
                    },
                    (r) {
                      generalFundProvider.updateGeneralFundMemberCount(fund.id, 1);
                      DialogHelper.showSnackBar(context, 'Thêm thành viên mới thành công');
                    },
                  ).run();
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 18.0),
                  child: Text('Thêm hụi viên mới'),
                ),
              ),
            )
          ],
        ),
      ],
    );
  }
}

@RoutePage()
class FundMembersScreen extends StatelessWidget {
  const FundMembersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final fundProvider = Provider.of<FundProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Quản lí thành viên'),
        automaticallyImplyLeading: false,
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.router.pop(),
        heroTag: null,
        label: const Text('Xong'),
        icon: const Icon(Icons.check),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: [
            fundProvider.fund.sessions.isEmpty ? AddMemberWidget(fund: fundProvider.fund) : const SizedBox(height: 10),
            Text(fundProvider.fund.sessions.isNotEmpty ? '*Bạn sẽ không thể xóa sửa thành viên nếu đã có những KÌ HỤI' : ''),
            ...fundProvider.fund.members.map((fundMember) => FundMemberWidget(fundMember: fundMember)).toList(),
          ],
        ),
      ),
    );
  }
}
