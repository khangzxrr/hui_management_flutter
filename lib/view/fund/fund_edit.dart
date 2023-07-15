import 'dart:developer';

import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:fpdart/fpdart.dart';
import 'package:get_it/get_it.dart';
import 'package:hui_management/helper/utils.dart';
import 'package:hui_management/model/fund_model.dart';
import 'package:hui_management/model/general_fund_model.dart';
import 'package:hui_management/provider/general_fund_provider.dart';
import 'package:hui_management/service/fund_service.dart';
import 'package:provider/provider.dart';

class FundEditWidget extends StatelessWidget {
  final bool isNew;
  final GeneralFundModel? fund;

  FundEditWidget({super.key, required this.isNew, required this.fund});

  final _formKey = GlobalKey<FormBuilderState>();

  final _nameKey = GlobalKey<FormBuilderFieldState>();
  final _openDateKey = GlobalKey<FormBuilderFieldState>();
  final _costKey = GlobalKey<FormBuilderFieldState>();
  final _ownerCostKey = GlobalKey<FormBuilderFieldState>();
  final _openDateTextKey = GlobalKey<FormBuilderFieldState>();

  @override
  Widget build(BuildContext context) {
    final fundProvider = Provider.of<GeneralFundProvider>(context, listen: false);
    final navigator = Navigator.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Quản lí dây hụi'),
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
                  initialValue: isNew ? "" : fund!.name,
                  autovalidateMode: isNew ? AutovalidateMode.onUserInteraction : AutovalidateMode.always,
                  validator: FormBuilderValidators.compose(
                    [FormBuilderValidators.required()],
                  ),
                ),
                FormBuilderTextField(
                  key: _costKey,
                  name: 'cost',
                  decoration: const InputDecoration(labelText: 'Số tiền dây hụi '),
                  initialValue: isNew ? "" : fund!.fundPrice.toString(),
                  autovalidateMode: isNew ? AutovalidateMode.onUserInteraction : AutovalidateMode.always,
                  validator: FormBuilderValidators.compose(
                    [FormBuilderValidators.required(), FormBuilderValidators.numeric()],
                  ),
                ),
                FormBuilderTextField(
                  key: _ownerCostKey,
                  name: 'ownerCost',
                  decoration: const InputDecoration(labelText: 'Số tiền hoa hồng '),
                  initialValue: isNew ? "" : fund!.serviceCost.toString(),
                  autovalidateMode: isNew ? AutovalidateMode.onUserInteraction : AutovalidateMode.always,
                  validator: FormBuilderValidators.compose(
                    [FormBuilderValidators.required(), FormBuilderValidators.numeric()],
                  ),
                ),
                FormBuilderTextField(
                  key: _openDateTextKey,
                  name: 'openDateText',
                  decoration: const InputDecoration(labelText: 'Ngày khui (ghi chú)'),
                  initialValue: isNew ? "" : fund!.openDateText,
                  autovalidateMode: isNew ? AutovalidateMode.onUserInteraction : AutovalidateMode.always,
                  validator: FormBuilderValidators.compose(
                    [FormBuilderValidators.required()],
                  ),
                ),
                FormBuilderDateTimePicker(
                  key: _openDateKey,
                  name: 'openDate',
                  decoration: const InputDecoration(labelText: 'Ngày mở dây hụi'),
                  initialValue: isNew ? DateTime.now() : fund!.openDate,
                  autovalidateMode: isNew ? AutovalidateMode.onUserInteraction : AutovalidateMode.always,
                  validator: FormBuilderValidators.compose(
                    [FormBuilderValidators.required()],
                  ),
                ),
                const SizedBox(height: 30.0),
                ElevatedButton(
                    onPressed: () {
                      if (!_formKey.currentState!.isValid) {
                        return;
                      }

                      final newFund = GeneralFundModel(
                        id: fund == null ? -1 : fund!.id,
                        fundPrice: double.parse(_costKey.currentState!.value),
                        name: _nameKey.currentState!.value,
                        openDate: _openDateKey.currentState!.value,
                        serviceCost: double.parse(_ownerCostKey.currentState!.value),
                        openDateText: _openDateTextKey.currentState!.value,
                        membersCount: 0,
                        sessionsCount: 0,
                      );

                      if (isNew) {
                        final createdFundEither = GetIt.I<FundService>().create(newFund);

                        createdFundEither.match(
                          (l) => log(l),
                          (createdFund) {
                            fundProvider.addFund(createdFund);
                            navigator.pop();
                          },
                        ).run();
                      } else {
                        final updatedFundEither = GetIt.I<FundService>().update(newFund);

                        updatedFundEither.match(
                          (l) => log(l),
                          (updatedFund) {
                            fundProvider.updateFund(updatedFund);
                            navigator.pop();
                          },
                        ).run();
                      }
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
