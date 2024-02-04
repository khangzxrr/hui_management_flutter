import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:hui_management/helper/dialog.dart';
import 'package:hui_management/model/payment_model.dart';
import 'package:hui_management/model/sub_user_model.dart';
import 'package:hui_management/provider/payment_provider.dart';
import 'package:hui_management/provider/sub_users_with_payment_report_provider.dart';
import 'package:number_to_vietnamese_words/number_to_vietnamese_words.dart';
import 'package:provider/provider.dart';

import '../../helper/utils.dart';
import '../../routes/app_route.dart';

@RoutePage()
class AddCustomBillScreen extends StatefulWidget {
  final SubUserModel subuser;

  AddCustomBillScreen({super.key, required this.subuser});

  @override
  State<AddCustomBillScreen> createState() => _AddCustomBillScreenState();
}

class _AddCustomBillScreenState extends State<AddCustomBillScreen> {
  final formKey = GlobalKey<FormBuilderState>();

  double amount = 0;

  @override
  Widget build(BuildContext context) {
    final paymentProvider = Provider.of<PaymentProvider>(context, listen: false);
    final subuserWithPaymentReportProvider = Provider.of<SubUserWithPaymentReportProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text('Thêm bill mới cho ${widget.subuser.name}'),
      ),
      body: Container(
        padding: const EdgeInsets.all(14),
        child: FormBuilder(
          key: formKey,
          child: ListView(
            children: [
              FormBuilderRadioGroup(
                wrapAlignment: WrapAlignment.spaceAround,
                name: 'customBillType',
                initialValue: 'OutsideDebt',
                decoration: const InputDecoration(labelText: 'Loại bill'),
                options: const [
                  FormBuilderFieldOption(value: 'OutsideDebt', child: Text('Bill nợ phải thu khác')),
                ],
                validator: FormBuilderValidators.required(),
              ),
              const SizedBox(height: 15),
              Text('Tiền thăm kêu (bằng chữ): ${amount.toInt().toVietnameseWords()} đồng'),
              FormBuilderTextField(
                name: 'amount',
                decoration: const InputDecoration(labelText: 'Số tiền thanh toán'),
                initialValue: "0",
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                  FormBuilderValidators.numeric(),
                ]),
                onChanged: (value) {
                  if (value == null) {
                    return;
                  }

                  double? parsedAmount = double.tryParse(value);

                  if (parsedAmount == null) {
                    return;
                  }

                  setState(() {
                    amount = parsedAmount;
                  });
                },
              ),
              FormBuilderTextField(
                name: 'description',
                initialValue: '',
                decoration: const InputDecoration(labelText: 'Ghi chú'),
              ),
              const SizedBox(
                height: 14,
              ),
              FilledButton(
                onPressed: () async {
                  var parsedAmount = double.tryParse(formKey.currentState!.fields['amount']!.value.toString());

                  if (parsedAmount == null) {
                    formKey.currentState?.fields['amount']?.invalidate('Vui lòng nhập đúng số');
                    return;
                  }

                  if (parsedAmount <= 0) {
                    formKey.currentState?.fields['amount']?.invalidate('Giá tiền không thể bé hơn hoặc bằng 0');
                    return;
                  }

                  if (formKey.currentState!.fields['description']!.value.toString().isEmpty) {
                    formKey.currentState!.fields['description']!.invalidate('Vui lòng nhập ghi chú');
                    return;
                  }

                  await paymentProvider
                      .addCustomBill(
                        subuserId: widget.subuser.id,
                        amount: parsedAmount,
                        customBillType: formKey.currentState!.fields['customBillType']!.value,
                        description: formKey.currentState!.fields['description']!.value.toString(),
                      )
                      .andThen(() => paymentProvider.getPayments(widget.subuser.id))
                      .andThen(
                        () => subuserWithPaymentReportProvider.refreshSingleItem(widget.subuser.id),
                      )
                      .match(
                    (l) {
                      log(l);
                      DialogHelper.showSnackBar(context, 'Có lỗi xảy ra: $l');
                    },
                    (r) {
                      log('OK');
                      DialogHelper.showSnackBar(context, 'Thêm bill mới thành công');

                      context.popRoute();
                    },
                  ).run();
                },
                child: const Text('Lưu thông tin xử lí'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
