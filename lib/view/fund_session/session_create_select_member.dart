import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_extra_fields/form_builder_extra_fields.dart';
import 'package:hui_management/model/fund_member.dart';
import 'package:hui_management/model/fund_normal_session_detail_model.dart';
import 'package:hui_management/provider/fund_provider.dart';
import 'package:provider/provider.dart';

import '../../routes/app_route.dart';

@RoutePage()
class CreateSessionSelectMemberScreen extends StatefulWidget {
  const CreateSessionSelectMemberScreen({super.key});

  @override
  State<CreateSessionSelectMemberScreen> createState() => _CreateSessionSelectMemberScreenState();
}

class _CreateSessionSelectMemberScreenState extends State<CreateSessionSelectMemberScreen> {
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
                      (session) => session.normalSessionDetails.where((d) => (d.type == NormalSessionDetailType.taken || d.type == NormalSessionDetailType.fakeTaken) && d.fundMember.id == mem.id).isNotEmpty,
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
                  ? () => context.router.push(
                        CreateSessionEnterInfoRoute(
                          fundMember: fundMember!,
                        ),
                      )
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
