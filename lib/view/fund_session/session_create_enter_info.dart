import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:hui_management/model/fund_member.dart';
import 'package:hui_management/provider/fund_provider.dart';
import 'package:provider/provider.dart';

class SessionCreateEnterInfoWidget extends StatefulWidget {
  final FundMember fundMember;

  const SessionCreateEnterInfoWidget({super.key, required this.fundMember});

  @override
  State<SessionCreateEnterInfoWidget> createState() => _SessionCreateEnterInfoWidget();
}

class _SessionCreateEnterInfoWidget extends State<SessionCreateEnterInfoWidget> {
  bool isValid = false;

  final _formKey = GlobalKey<FormBuilderState>();

  double predictPrice = 0;
  double totalFundPrice = 0;
  double serviceCost = 0;
  double remainPrice = 0;

  void setData({required double predictPrice, required double totalFundPrice, required double serviceCost, required remainPrice}) {
    setState(() {
      this.predictPrice = predictPrice;
      this.totalFundPrice = totalFundPrice;
      this.serviceCost = serviceCost;
      this.remainPrice = remainPrice;

      this.isValid = true;

      _formKey.currentState?.patchValue(
        {
          'fundAmount': totalFundPrice.toString(),
          'serviceCost': serviceCost.toString(),
          'remainPrice': remainPrice.toString(),
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final fundProvider = Provider.of<FundProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Hốt hụi - tính toán thăm kêu'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: [
            Card(
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                  widget.fundMember.nickName,
                  style: TextStyle(fontSize: 26),
                ),
              ),
            ),
            FormBuilder(
              key: _formKey,
              child: Column(
                children: [
                  FormBuilderTextField(
                    name: 'predictedPrice',
                    decoration: const InputDecoration(labelText: 'Thăm kêu'),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: FormBuilderValidators.compose(
                      [FormBuilderValidators.required(), FormBuilderValidators.numeric()],
                    ),
                    onChanged: (predictedPriceStr) {
                      setState(() {
                        isValid = false;
                      });

                      if (predictedPriceStr == null) {
                        return;
                      }

                      double? predictedPrice = double.tryParse(predictedPriceStr);

                      if (predictedPrice == null) {
                        return;
                      }

                      double totalFund = (fundProvider.fund.membersCount - 1) * (fundProvider.fund.fundPrice - predictedPrice);

                      if (predictedPrice > totalFund) {
                        _formKey.currentState?.fields['predictedPrice']?.invalidate('Thăm kêu không được lớn hơn tiền hụi');

                        return;
                      }

                      _formKey.currentState?.fields['predictedPrice']?.validate();

                      setData(
                        predictPrice: predictedPrice,
                        totalFundPrice: totalFund,
                        serviceCost: fundProvider.fund.serviceCost,
                        remainPrice: totalFund - fundProvider.fund.serviceCost,
                      );
                    },
                  ),
                  FormBuilderTextField(
                    name: 'fundAmount',
                    decoration: const InputDecoration(labelText: 'Tiền hụi'),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: FormBuilderValidators.compose(
                      [FormBuilderValidators.required(), FormBuilderValidators.numeric()],
                    ),
                    readOnly: true,
                  ),
                  FormBuilderTextField(
                    name: 'serviceCost',
                    decoration: const InputDecoration(labelText: 'Trừ tiền thảo'),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: FormBuilderValidators.compose(
                      [FormBuilderValidators.required(), FormBuilderValidators.numeric()],
                    ),
                    readOnly: true,
                  ),
                  FormBuilderTextField(
                    name: 'remainPrice',
                    decoration: const InputDecoration(labelText: 'Tổng tiền còn lại'),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: FormBuilderValidators.compose(
                      [FormBuilderValidators.required(), FormBuilderValidators.numeric()],
                    ),
                    readOnly: true,
                  ),
                ],
              ),
            ),
            Container(height: 10),
            const Text('Lưu ý: những hụi viên đã hốt rồi sẽ không hiển thị trên danh sách'),
            Container(height: 10),
            ElevatedButton(
              onPressed: isValid
                  ? () {
                      fundProvider
                          .addSession(widget.fundMember.id, predictPrice)
                          .andThen(
                            () => fundProvider.getFund(fundProvider.fund.id),
                          )
                          .match((l) => log(l), (r) => log('OK'))
                          .run();
                    }
                  : null,
              child: const Text('Hốt hụi'),
              style: ElevatedButton.styleFrom(disabledForegroundColor: Colors.blue),
            )
          ],
        ),
      ),
    );
  }
}
