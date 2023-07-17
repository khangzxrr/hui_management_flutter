import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_extra_fields/form_builder_extra_fields.dart';
import 'package:hui_management/model/fund_member.dart';
import 'package:hui_management/provider/fund_provider.dart';
import 'package:hui_management/view/fund_session/session_create_enter_info.dart';
import 'package:provider/provider.dart';

class SessionCreateSelectMemberWidget extends StatefulWidget {
  const SessionCreateSelectMemberWidget({super.key});

  @override
  State<SessionCreateSelectMemberWidget> createState() => _SessionCreateSelectMemberWidgetState();
}

class _SessionCreateSelectMemberWidgetState extends State<SessionCreateSelectMemberWidget> {
  FundMember? fundMember;

  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    final fundProvider = Provider.of<FundProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Hốt hụi - chọn người cần hốt'),
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
                  labelText: 'Chọn hụi viên muốn hốt hụi',
                ),
                itemAsString: (fundMember) => fundMember.nickName,
                compareFn: (fundMember1, fundMember2) => fundMember1.nickName != fundMember2.nickName,
                asyncItems: (filter) async {
                  final members = fundProvider.fund.members;
                  final sessions = fundProvider.fund.sessions;

                  return members.where((mem) {
                    final nameContain = mem.nickName.toLowerCase().contains(filter.toLowerCase());

                    final isNotExistTaken = sessions.any(
                      (session) => session.normalSessionDetails.where((d) => d.type == "Taken" && d.fundMember.id == mem.id).isNotEmpty,
                    );

                    return nameContain && !isNotExistTaken;
                  }).toList();
                },
                onChanged: (mem) {
                  if (mem == null) {
                    return;
                  }

                  log('valid!');

                  setState(() {
                    fundMember = mem;
                  });
                },
              ),
            ),
            Container(height: 10),
            const Text('Lưu ý: những hụi viên đã hốt rồi sẽ không hiển thị trên danh sách'),
            Container(height: 10),
            ElevatedButton(
              onPressed: fundMember != null
                  ? () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (b) => SessionCreateEnterInfoWidget(fundMember: fundMember!)),
                      );
                    }
                  : null,
              style: ElevatedButton.styleFrom(disabledForegroundColor: Colors.blue),
              child: const Text('Hốt hụi'),
            )
          ],
        ),
      ),
    );
  }
}
