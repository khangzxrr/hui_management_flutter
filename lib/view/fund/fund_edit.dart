import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get_it/get_it.dart';
import 'package:hui_management/helper/dialog.dart';
import 'package:hui_management/helper/utils.dart';
import 'package:hui_management/model/general_fund_model.dart';
import 'package:hui_management/provider/general_fund_provider.dart';
import 'package:hui_management/service/fund_service.dart';
import 'package:number_to_vietnamese_words/number_to_vietnamese_words.dart';
import 'package:provider/provider.dart';

@RoutePage()
class FundEditScreen extends StatefulWidget {
  final bool isNew;
  final GeneralFundModel? fund;

  const FundEditScreen({super.key, required this.isNew, required this.fund});

  @override
  State<FundEditScreen> createState() => _FundEditScreenState();
}

class _FundEditScreenState extends State<FundEditScreen> {
  final _formKey = GlobalKey<FormBuilderState>();

  final _nameKey = GlobalKey<FormBuilderFieldState>();

  final _openDateKey = GlobalKey<FormBuilderFieldState>();

  final _costKey = GlobalKey<FormBuilderFieldState>();

  final _ownerCostKey = GlobalKey<FormBuilderFieldState>();

  final _newSessionDurationDayCountKey = GlobalKey<FormBuilderFieldState>();

  final _takenSessionDeliveryDayCountKey = GlobalKey<FormBuilderFieldState>();

  int cost = 0;
  int ownerCost = 0;

  @override
  void initState() {
    if (!widget.isNew) {
      cost = widget.fund!.fundPrice.toInt();
      ownerCost = widget.fund!.serviceCost.toInt();
    }
    super.initState();
  }

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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FormBuilderDateRangePicker(
                  name: 'newSessionDateRange',
                  firstDate: DateTime.now(),
                  lastDate: DateTime.now().add(const Duration(days: 365)),
                ),
                FormBuilderTextField(
                  key: _nameKey,
                  name: 'name',
                  decoration: const InputDecoration(labelText: 'Tên hụi'),
                  initialValue: widget.isNew ? "" : widget.fund!.name,
                  autovalidateMode: widget.isNew ? AutovalidateMode.onUserInteraction : AutovalidateMode.always,
                  validator: FormBuilderValidators.compose(
                    [FormBuilderValidators.required()],
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Text('Số tiền dây hụi (thành chữ): ${cost.toVietnameseWords()} đồng'),
                FormBuilderTextField(
                  key: _costKey,
                  name: 'cost',
                  decoration: const InputDecoration(labelText: 'Số tiền dây hụi '),
                  initialValue: widget.isNew ? "" : widget.fund!.fundPrice.toString(),
                  autovalidateMode: widget.isNew ? AutovalidateMode.onUserInteraction : AutovalidateMode.always,
                  onChanged: (costValue) {
                    setState(() {
                      cost = int.tryParse(costValue!) ?? 0;
                    });
                  },
                  validator: FormBuilderValidators.compose(
                    [FormBuilderValidators.required(), FormBuilderValidators.numeric()],
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Text('Số tiền hoa hồng (thành chữ): ${ownerCost.toVietnameseWords()} đồng'),
                FormBuilderTextField(
                  key: _ownerCostKey,
                  name: 'ownerCost',
                  decoration: const InputDecoration(labelText: 'Số tiền hoa hồng '),
                  initialValue: widget.isNew ? "" : widget.fund!.serviceCost.toString(),
                  autovalidateMode: widget.isNew ? AutovalidateMode.onUserInteraction : AutovalidateMode.always,
                  validator: FormBuilderValidators.compose(
                    [FormBuilderValidators.required(), FormBuilderValidators.numeric()],
                  ),
                  onChanged: (ownerCostValue) {
                    setState(() {
                      ownerCost = int.tryParse(ownerCostValue!) ?? 0;
                    });
                  },
                ),
                FormBuilderTextField(
                  key: _newSessionDurationDayCountKey,
                  name: 'newSesionDurationDayCount',
                  decoration: const InputDecoration(labelText: 'SỐ ngày khui đếm từ ngày mở dây hụi (1,2,3...)'),
                  initialValue: widget.isNew ? "" : widget.fund!.newSessionDurationDayCount.toString(),
                  autovalidateMode: widget.isNew ? AutovalidateMode.onUserInteraction : AutovalidateMode.always,
                  validator: FormBuilderValidators.compose(
                    [FormBuilderValidators.required(), FormBuilderValidators.numeric()],
                  ),
                ),
                FormBuilderTextField(
                  key: _takenSessionDeliveryDayCountKey,
                  name: 'takenSessionDeliveryDayCount',
                  decoration: const InputDecoration(labelText: 'SỐ ngày giao đếm từ ngày mở dây hụi (1,2,3...)'),
                  initialValue: widget.isNew ? "" : widget.fund!.takenSessionDeliveryDayCount.toString(),
                  autovalidateMode: widget.isNew ? AutovalidateMode.onUserInteraction : AutovalidateMode.always,
                  validator: FormBuilderValidators.compose(
                    [FormBuilderValidators.required(), FormBuilderValidators.numeric()],
                  ),
                ),
                FormBuilderDateTimePicker(
                  key: _openDateKey,
                  name: 'openDate',
                  decoration: const InputDecoration(labelText: 'Ngày mở dây hụi'),
                  initialValue: widget.isNew ? DateTime.now() : widget.fund!.openDate,
                  format: Utils.dateFormat,
                  autovalidateMode: widget.isNew ? AutovalidateMode.onUserInteraction : AutovalidateMode.always,
                  validator: FormBuilderValidators.compose(
                    [FormBuilderValidators.required()],
                  ),
                ),
                const SizedBox(height: 30.0),
                ElevatedButton(
                    onPressed: () {
                      _formKey.currentState?.saveAndValidate();
                      if (!_formKey.currentState!.isValid) {
                        return;
                      }

                      final newFund = GeneralFundModel(
                        id: widget.fund == null ? -1 : widget.fund!.id,
                        fundPrice: double.parse(_costKey.currentState!.value),
                        name: _nameKey.currentState!.value,
                        openDate: _openDateKey.currentState!.value,
                        serviceCost: double.parse(_ownerCostKey.currentState!.value),
                        newSessionDurationDayCount: int.parse(_newSessionDurationDayCountKey.currentState!.value),
                        nextSessionDurationDate: DateTime.now(),
                        takenSessionDeliveryDayCount: int.parse(_takenSessionDeliveryDayCountKey.currentState!.value),
                        nextTakenSessionDeliveryDate: DateTime.now(),
                        currentSessionDurationDate: DateTime.now(),
                        currentTakenSessionDeliveryDate: DateTime.now(),
                        endDate: DateTime.now(),
                        lastSessionFundPrice: 0,
                        membersCount: 0,
                        sessionsCount: 0,
                      );

                      if (widget.isNew) {
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
                            DialogHelper.showSnackBar(context, 'Cập nhật dây hụi thành công');
                            fundProvider.updateFund(updatedFund);
                            navigator.pop();
                          },
                        ).run();
                      }
                    },
                    child: Text((widget.isNew) ? 'Tạo dây hụi mới' : 'Cập nhật dây hụi'))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
