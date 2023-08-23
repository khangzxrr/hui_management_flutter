import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:hui_management/model/fund_member.dart';
import 'package:hui_management/provider/fund_provider.dart';
import 'package:number_to_vietnamese_words/number_to_vietnamese_words.dart';
import 'package:provider/provider.dart';

import '../../helper/dialog.dart';
import '../../routes/app_route.dart';

@RoutePage()
class CreateSessionEnterInfoScreen extends StatefulWidget {
  final FundMember fundMember;

  const CreateSessionEnterInfoScreen({super.key, required this.fundMember});

  @override
  State<CreateSessionEnterInfoScreen> createState() => _SessionCreateEnterInfoWidget();
}

class _SessionCreateEnterInfoWidget extends State<CreateSessionEnterInfoScreen> {
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

      isValid = true;

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
                padding: const EdgeInsets.all(10),
                child: Text(
                  widget.fundMember.nickName,
                  style: const TextStyle(fontSize: 26),
                ),
              ),
            ),
            FormBuilder(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Tiền thăm kêu (bằng chữ): ${predictPrice.toInt().toVietnameseWords()} đồng'),
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

                      double totalDeadFund = fundProvider.fund.sessions.length * fundProvider.fund.fundPrice;
                      double totalAliveFund = (fundProvider.fund.membersCount - fundProvider.fund.sessions.length - 1) * (fundProvider.fund.fundPrice - predictedPrice);

                      double totalFund = totalDeadFund + totalAliveFund;

                      if (predictedPrice > totalFund) {
                        _formKey.currentState?.fields['predictedPrice']?.invalidate('Thăm kêu không được lớn hơn tiền hụi');

                        return;
                      }

                      if (totalFund - fundProvider.fund.serviceCost < 0) {
                        _formKey.currentState?.fields['predictedPrice']?.invalidate('Tổng tiền còn lại không thể âm');

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
                  const SizedBox(height: 15),
                  Text('Tổng tiền còn lại (bằng chữ): ${remainPrice.toInt().toVietnameseWords()} đồng'),
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
                          .match((l) {
                        log(l);
                        DialogHelper.showSnackBar(context, 'Có lỗi xảy ra khi tạo kì hụi mới');
                      }, (r) {
                        DialogHelper.showSnackBar(context, 'Tạo kì hụi mới thành công');
                        context.router.pushAndPopUntil(const FundSessionListRoute(), predicate: (route) => route.settings.name == FundDetailRoute.name);
                      }).run();
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
