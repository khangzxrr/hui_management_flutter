import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_extra_fields/form_builder_extra_fields.dart';
import 'package:hui_management/helper/dialog.dart';
import 'package:hui_management/model/fund_normal_session_detail_model.dart';
import 'package:provider/provider.dart';

import '../../model/fund_member.dart';
import '../../provider/fund_provider.dart';

@RoutePage()
class FinalSettlementForDeadSessionScreen extends StatefulWidget {
  const FinalSettlementForDeadSessionScreen({super.key});

  @override
  State<FinalSettlementForDeadSessionScreen> createState() => _FinalSettlementForDeadSessionScreenState();
}

class _FinalSettlementForDeadSessionScreenState extends State<FinalSettlementForDeadSessionScreen> {
  FundMember? fundMember;

  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    final fundProvider = Provider.of<FundProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tất toán hụi chết'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: [
            FormBuilder(
              key: _formKey,
              child: FormBuilderSearchableDropdown<FundMember>(
                popupProps: const PopupProps.dialog(showSearchBox: true),
                name: 'searchable_dropdown_user',
                decoration: const InputDecoration(
                  labelText: 'Chọn hụi viên cần tất toán',
                ),
                itemAsString: (fundMember) => fundMember.nickName,
                compareFn: (fundMember1, fundMember2) => fundMember1.nickName != fundMember2.nickName,
                asyncItems: (filter) async {
                  final members = fundProvider.fund.members;
                  final sessions = fundProvider.fund.sessions;

                  return members.where((mem) {
                    final nameContain = mem.nickName.toLowerCase().contains(filter.toLowerCase());

                    final isExistTaken = sessions.any(
                      (session) => session.normalSessionDetails.where((d) => (d.type == NormalSessionDetailType.taken || d.type == NormalSessionDetailType.emergencyTaken) && d.fundMember.id == mem.id && !d.fundMember.hasFinalSettlementForDeadSessionBill).isNotEmpty,
                    );

                    return nameContain && isExistTaken;
                  }).toList();
                },
                onChanged: (mem) {
                  if (mem == null) {
                    return;
                  }

                  setState(() {
                    fundMember = mem;
                  });
                },
              ),
            ),
            Container(height: 10),
            const Text('Lưu ý: những hụi viên chưa hốt sẽ không được hiển thị trên danh sách'),
            Container(height: 10),
            ElevatedButton(
              onPressed: () async {
                if (fundMember == null) {
                  return;
                }

                final result = await fundProvider
                    .createFinalSettlementForDeadSession(fundProvider.fund.id, fundMember!.id)
                    .andThen(
                      () => fundProvider.getFund(fundProvider.fund.id),
                    )
                    .run();

                result.match((l) {
                  log(l);
                  DialogHelper.showSnackBar(context, 'Có lỗi xảy ra, vui lòng thử lại. ERROR CODE: $l');
                }, (r) {
                  DialogHelper.showSnackBar(context, 'Tất toán thành công!');
                  context.router.pop();
                });
              },
              child: const Text('Xác nhận tất toán'),
            )
          ],
        ),
      ),
    );
  }
}
