import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:form_builder_extra_fields/form_builder_extra_fields.dart';
import 'package:fpdart/fpdart.dart';
import 'package:get_it/get_it.dart';
import 'package:hui_management/model/fund_member.dart';
import 'package:hui_management/model/fund_model.dart';
import 'package:hui_management/model/user_model.dart';
import 'package:hui_management/provider/fund_provider.dart';
import 'package:hui_management/service/fund_service.dart';
import 'package:hui_management/service/user_service.dart';
import 'package:provider/provider.dart';

class FundMemberWidget extends StatelessWidget {
  final FundMember fundMember;

  const FundMemberWidget({super.key, required this.fundMember});

  @override
  Widget build(BuildContext context) {
    final fundProvider = Provider.of<FundProvider>(context, listen: false);

    return Slidable(
      // The start action pane is the one at the left or the top side.
      startActionPane: ActionPane(
        // A motion is a widget used to control how the pane animates.
        motion: const ScrollMotion(),

        // All actions are defined in the children parameter.
        children: [
          // A SlidableAction can have an icon and/or a label.
          SlidableAction(
            onPressed: (context) async {
              fundProvider
                  .removeMember(fundMember.id)
                  .andThen(() => fundProvider.getFund(fundProvider.fund.id))
                  .match(
                    (l) => log(l),
                    (r) => log("OK"),
                  )
                  .run();
            },
            backgroundColor: Color(0xFFFE4A49),
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Xóa',
          ),
        ],
      ),

      // The child of the Slidable is what the user sees when the
      // component is not dragged.
      child: Card(
        child: Column(
          children: <Widget>[
            ListTile(
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(50.0),
                child: Image.network('https://flutter.github.io/assets-for-api-docs/assets/widgets/owl-2.jpg'),
              ),
              title: Text(fundMember.user.name),
              subtitle: Text('${fundMember.user.email}\n${fundMember.user.phonenumber}\n${fundMember.user.bankname} - ${fundMember.user.banknumber}\n${fundMember.user.address}\n${fundMember.user.additionalInfo}'),
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

  bool disableAddButton = true;

  @override
  Widget build(BuildContext context) {
    final fundProvider = Provider.of<FundProvider>(context, listen: false);

    return Row(
      children: [
        Expanded(
          flex: 7,
          child: FormBuilder(
            key: _formKey,
            child: FormBuilderSearchableDropdown<UserModel>(
              popupProps: const PopupProps.dialog(showSearchBox: true),
              name: 'searchable_dropdown_user',
              decoration: const InputDecoration(
                labelText: 'Searchable Dropdown Online',
              ),
              itemAsString: (user) => user.name,
              compareFn: (user1, user2) => user1.name != user2.name,
              asyncItems: (filter) async {
                final users = await GetIt.I<UserService>().getAll();

                return users!.where((user) => user.name.toLowerCase().contains(filter.toLowerCase())).toList();
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
              final user = _formKey.currentState!.fields['searchable_dropdown_user']?.value as UserModel?;

              if (user == null) {
                return;
              }

              fundProvider
                  .addMember(user.id)
                  .andThen(
                    () => fundProvider.getFund(fund.id),
                  )
                  .match(
                    (l) => log(l),
                    (r) => log("OK"),
                  )
                  .run();
            },
            child: const Padding(
              padding: EdgeInsets.symmetric(vertical: 18.0),
              child: Text('Thêm hụi viên mới'),
            ),
          ),
        )
      ],
    );
  }
}

class FundMembersWidget extends StatelessWidget {
  const FundMembersWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final fundProvider = Provider.of<FundProvider>(context);

    List<Widget> widgets = [AddMemberWidget(fund: fundProvider.fund)];
    final members = fundProvider.fund.members
        .map(
          (fundMember) => FundMemberWidget(fundMember: fundMember),
        )
        .toList();

    widgets.addAll(members);

    return Scaffold(
        appBar: AppBar(
          title: const Text('Quản lí thành viên'),
        ),
        body: Padding(
          padding: EdgeInsets.all(10),
          child: ListView(
            children: widgets,
          ),
        ));
  }
}
