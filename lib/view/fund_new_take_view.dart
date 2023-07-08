import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:hui_management/view/fund_detail.dart';

class FundNewTakeWidget extends StatelessWidget {
  FundNewTakeWidget({super.key});

  final _formKey = GlobalKey<FormBuilderState>();

  final _nameKey = GlobalKey<FormBuilderState>();
  final _predictPriceKey = GlobalKey<FormBuilderState>();
  final _fundPriceKey = GlobalKey<FormBuilderState>();
  final _ownerCostKey = GlobalKey<FormBuilderState>();
  final _remainCostKey = GlobalKey<FormBuilderState>();

  List<String> genderOptions = ['Male', 'Female', 'Other'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hốt hụi'),
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
                  decoration: const InputDecoration(labelText: 'Tên dây hụiii'),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: FormBuilderValidators.compose(
                    [FormBuilderValidators.required()],
                  ),
                ),
                FormBuilderTextField(
                  key: _predictPriceKey,
                  name: 'predictPrice',
                  decoration: const InputDecoration(labelText: 'Thăm kêu'),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: FormBuilderValidators.compose(
                    [FormBuilderValidators.required()],
                  ),
                ),
                FormBuilderTextField(
                  key: _fundPriceKey,
                  name: 'fundPrice',
                  decoration: const InputDecoration(labelText: 'Tiền hụi'),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: FormBuilderValidators.compose(
                    [FormBuilderValidators.required()],
                  ),
                ),
                FormBuilderTextField(
                  key: _ownerCostKey,
                  name: 'Hoa hồng',
                  decoration: const InputDecoration(labelText: 'Hoa hồng'),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: FormBuilderValidators.compose(
                    [FormBuilderValidators.required()],
                  ),
                ),
                FormBuilderTextField(
                  key: _remainCostKey,
                  name: 'remainCost',
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => FundDetailWidget()),
                      );
                    },
                    child: const Text('Hốt hụi'))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
