import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_extra_fields/form_builder_extra_fields.dart';
import 'package:hui_management/helper/dialog.dart';
import 'package:hui_management/helper/translate_exception.dart';
import 'package:hui_management/model/fund_member.dart';
import 'package:provider/provider.dart';

import '../../provider/fund_provider.dart';
import '../../provider/general_fund_provider.dart';
import '../../routes/app_route.dart';

@RoutePage()
class EmergencySessionCreateSelectMemberScreen extends StatefulWidget {
  const EmergencySessionCreateSelectMemberScreen({super.key});

  @override
  State<EmergencySessionCreateSelectMemberScreen> createState() => _EmergencySessionCreateSelectMemberScreenState();
}

class _EmergencySessionCreateSelectMemberScreenState extends State<EmergencySessionCreateSelectMemberScreen> {
  final Set<FundMember> selectedMembers = {};

  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    final fundProvider = Provider.of<FundProvider>(context, listen: true);
    final genalFundProvider = Provider.of<GeneralFundProvider>(context, listen: true);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Hốt giao trước - chọn người cần hốt'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: [
            //decor this  shit
            ...selectedMembers
                .map(
                  (m) => ListTile(
                    title: Text(m.nickName),
                    trailing: IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => setState(() {
                        selectedMembers.remove(m);
                      }),
                    ),
                  ),
                )
                .toList(),
            FormBuilder(
              key: _formKey,
              child: FormBuilderSearchableDropdown<FundMember>(
                popupProps: const PopupProps.dialog(showSearchBox: true),
                name: 'searchable_dropdown_user',
                decoration: const InputDecoration(
                  labelText: 'Chọn hụi viên muốn hốt hụi',
                ),
                itemAsString: (fundMember) => fundMember.nickName,
                compareFn: (fundMember1, fundMember2) => fundMember1.nickName != fundMember2.nickName,
                asyncItems: (filter) async {
                  final notTakenMembers = fundProvider.getNotTakenFundMember(includeEmergencyTaken: true);

                  return notTakenMembers.where((mem) {
                    final nameContain = mem.nickName.toLowerCase().contains(filter.toLowerCase());

                    return nameContain;
                  }).toList();
                },
                onChanged: (mem) {
                  if (mem == null) {
                    return;
                  }

                  setState(() {
                    selectedMembers.add(mem);
                  });
                  _formKey.currentState?.reset();
                },
              ),
            ),
            Container(height: 10),
            const Text('Lưu ý: những hụi viên đã hốt rồi sẽ không hiển thị trên danh sách'),
            Container(height: 10),
            ElevatedButton(
              onPressed: () async => selectedMembers.isEmpty
                  ? null
                  : await fundProvider
                      .addEmergencySession(
                        fundProvider.fund.id,
                        selectedMembers.map((m) => m.id).toList(),
                      )
                      .andThen(() => fundProvider.getFund(fundProvider.fund.id))
                      .match(
                      (l) {
                        log(l);
                        DialogHelper.showSnackBar(context, TranslateException.translate(l));
                      },
                      (r) {
                        DialogHelper.showSnackBar(context, 'Đã hốt trước cho ${selectedMembers.length} hụi viên thành công! Vui lòng kiểm tra và thanh toán hóa đơn');
                        context.router.pushAndPopUntil(const FundSessionListRoute(), predicate: (route) => route.settings.name == FundDetailRoute.name);
                      },
                    ).run(),
              style: ElevatedButton.styleFrom(disabledForegroundColor: Colors.blue),
              child: const Text('Hốt giao trước'),
            )
          ],
        ),
      ),
    );
  }
}
