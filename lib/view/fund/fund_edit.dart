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
import 'package:intl/intl.dart';
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

  final _fundTypeKey = GlobalKey<FormBuilderFieldState>();

  final _newSessionDurationCountKey = GlobalKey<FormBuilderFieldState>();

  final _newSessionCreateDayOfMonthKey = GlobalKey<FormBuilderFieldState>();

  final _newSessionCreateHourOfDayKey = GlobalKey<FormBuilderFieldState>();

  int cost = 0;
  int ownerCost = 0;

  FundType fundType = FundType.dayFund;

  @override
  void initState() {
    if (!widget.isNew) {
      cost = widget.fund!.fundPrice.toInt();
      ownerCost = widget.fund!.serviceCost.toInt();
      fundType = widget.fund!.fundType;
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
          padding: const EdgeInsets.all(8.0),
          child: FormBuilder(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FormBuilderRadioGroup(
                  key: _fundTypeKey,
                  wrapAlignment: WrapAlignment.spaceAround,
                  name: 'fundType',
                  initialValue: widget.isNew ? 'DayFund' : widget.fund!.fundType,
                  decoration: const InputDecoration(labelText: 'Loại hụi'),
                  options: const [
                    FormBuilderFieldOption(value: FundType.dayFund, child: Text('Hụi ngày')),
                    FormBuilderFieldOption(value: FundType.monthFund, child: Text('Hụi tháng')),
                  ],
                  validator: FormBuilderValidators.required(),
                  onChanged: (fundTypeValue) => setState(() {
                    if (fundTypeValue == null) return;

                    fundType = fundTypeValue as FundType;
                  }),
                ),
                SizedBox(height: 15),
                Row(
                  children: [
                    Text((fundType == FundType.dayFund) ? 'Khui vào mỗi ' : 'Khui vào ngày '),
                    SizedBox(
                      width: 70,
                      child: FormBuilderTextField(
                        key: _newSessionDurationCountKey,
                        name: 'newSessionDurationCount',
                        textAlign: TextAlign.center,
                        decoration: const InputDecoration(labelText: '(số ngày)', floatingLabelAlignment: FloatingLabelAlignment.center),
                        initialValue: widget.isNew ? "" : widget.fund!.newSessionDurationCount.toString(),
                        autovalidateMode: widget.isNew ? AutovalidateMode.onUserInteraction : AutovalidateMode.always,
                        validator: FormBuilderValidators.compose(
                          [FormBuilderValidators.required(), FormBuilderValidators.numeric()],
                        ),
                      ),
                    ),
                    Text((fundType == FundType.dayFund) ? 'ngày ' : 'ngày mỗi '),
                    (fundType == FundType.monthFund)
                        ? SizedBox(
                            width: 80,
                            child: FormBuilderTextField(
                              key: _newSessionCreateDayOfMonthKey,
                              name: 'newSessionCreateDayOfMonth',
                              textAlign: TextAlign.center,
                              decoration: const InputDecoration(labelText: '(số tháng)', floatingLabelAlignment: FloatingLabelAlignment.center),
                              initialValue: widget.isNew ? "" : widget.fund!.newSessionCreateDayOfMonth.toString(),
                              autovalidateMode: widget.isNew ? AutovalidateMode.onUserInteraction : AutovalidateMode.always,
                              validator: FormBuilderValidators.compose(
                                [FormBuilderValidators.required(), FormBuilderValidators.numeric()],
                              ),
                            ),
                          )
                        : SizedBox(),
                    Text((fundType == FundType.monthFund) ? 'tháng' : ''),
                  ],
                ),
                const SizedBox(height: 15),
                FormBuilderDateTimePicker(
                  key: _newSessionCreateHourOfDayKey,
                  name: 'newSessionCreateHourOfDay',
                  decoration: const InputDecoration(labelText: 'Khui vào lúc'),
                  inputType: InputType.time,
                  format: DateFormat('HH:mm'),
                  initialValue: widget.isNew ? DateTime.now() : widget.fund!.newSessionCreateHourOfDay.toLocal(),
                ),
                SizedBox(
                  height: 15,
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
                FormBuilderDateTimePicker(
                  key: _openDateKey,
                  name: 'openDate',
                  decoration: const InputDecoration(labelText: 'Ngày mở dây hụi'),
                  initialValue: widget.isNew ? DateTime.now() : widget.fund!.openDate,
                  inputType: InputType.date,
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
                        fundType: _fundTypeKey.currentState!.value,
                        openDate: (_openDateKey.currentState!.value as DateTime).toLocal(),
                        endDate: DateTime.now(),
                        serviceCost: double.parse(_ownerCostKey.currentState!.value),
                        newSessionDurationCount: int.parse(_newSessionDurationCountKey.currentState!.value),
                        newSessionCreateDayOfMonth: fundType == FundType.dayFund ? 0 : int.parse(_newSessionCreateDayOfMonthKey.currentState!.value),
                        newSessionCreateHourOfDay: (_newSessionCreateHourOfDayKey.currentState!.value as DateTime).toLocal(),
                        takenSessionDeliveryCount: int.parse(_newSessionDurationCountKey.currentState!.value),
                        membersCount: 0,
                        sessionsCount: 0,
                        newSessionCreateDates: [],
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
