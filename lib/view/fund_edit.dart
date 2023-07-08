import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class FundEditWidget extends StatelessWidget {
  FundEditWidget({super.key});

  final _formKey = GlobalKey<FormBuilderState>();

  final _nameKey = GlobalKey<FormBuilderState>();
  final _openDateKey = GlobalKey<FormBuilderState>();
  final _costKey = GlobalKey<FormBuilderState>();
  final _openDateTextKey = GlobalKey<FormBuilderState>();
  final _openDateDurationKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quản lí thành viên'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: FormBuilder(
            key: _formKey,
            child: Column(
              children: [
                FormBuilderTextField(
                  key: _nameKey,
                  name: 'name',
                  decoration: const InputDecoration(labelText: 'Tên hụi'),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: FormBuilderValidators.compose(
                    [FormBuilderValidators.required()],
                  ),
                ),
                FormBuilderDateTimePicker(
                  key: _openDateKey,
                  name: 'openDate',
                  decoration: const InputDecoration(labelText: 'Ngày mở dây hụi'),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: FormBuilderValidators.compose(
                    [FormBuilderValidators.required()],
                  ),
                ),
                FormBuilderTextField(
                  key: _costKey,
                  name: 'cost',
                  decoration: const InputDecoration(labelText: 'Số tiền dây hụi '),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: FormBuilderValidators.compose(
                    [FormBuilderValidators.required(), FormBuilderValidators.numeric()],
                  ),
                ),
                FormBuilderTextField(
                  key: _openDateTextKey,
                  name: 'openDateText',
                  decoration: const InputDecoration(labelText: 'Ngày khui (ghi chú)'),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: FormBuilderValidators.compose(
                    [FormBuilderValidators.required()],
                  ),
                ),
                FormBuilderTextField(
                  key: _openDateDurationKey,
                  name: 'openDateDuration',
                  decoration: const InputDecoration(labelText: 'Tổng số ngày giữa 2 lần khui (dùng để nhắc khui)'),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: FormBuilderValidators.compose(
                    [FormBuilderValidators.required(), FormBuilderValidators.numeric()],
                  ),
                ),
                const SizedBox(height: 30.0),
                ElevatedButton(
                    onPressed: () async {
                      print('hi!');
                      print(_formKey.currentState?.isValid);
                    },
                    child: const Text('Tạo dây hụi mới'))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
