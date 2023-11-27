import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:hui_management/helper/dialog.dart';
import 'package:hui_management/model/payment_model.dart';
import 'package:hui_management/provider/payment_provider.dart';
import 'package:hui_management/provider/sub_users_provider.dart';
import 'package:provider/provider.dart';

import '../../helper/utils.dart';
import '../../routes/app_route.dart';

@RoutePage()
class PaycheckScreen extends StatelessWidget {
  final PaymentModel payment;

  final formKey = GlobalKey<FormBuilderState>();

  PaycheckScreen({super.key, required this.payment});

  @override
  Widget build(BuildContext context) {
    final paymentProvider = Provider.of<PaymentProvider>(context, listen: false);
    final subUserProvider = Provider.of<SubUsersProvider>(context, listen: false);

    double remainCost = payment.totalCost.abs() - payment.totalTransactionCost;
    return Scaffold(
      appBar: AppBar(
        title: Text('Xử lí Bill của ${payment.owner.name} ngày ${Utils.dateFormat.format(payment.createAt.toLocal())}'),
      ),
      body: Container(
        padding: const EdgeInsets.all(14),
        child: FormBuilder(
          key: formKey,
          child: ListView(
            children: [
              FormBuilderRadioGroup(
                wrapAlignment: WrapAlignment.spaceAround,
                name: 'transactionMethod',
                initialValue: 'byCash',
                decoration: const InputDecoration(labelText: 'Phương thức thanh toán'),
                options: const [
                  FormBuilderFieldOption(value: 'ByCash', child: Text('Tiền mặt')),
                  FormBuilderFieldOption(value: 'ByBanking', child: Text('Chuyển khoản')),
                ],
                validator: FormBuilderValidators.required(),
              ),
              FormBuilderTextField(
                name: 'transactionAmount',
                decoration: const InputDecoration(labelText: 'Số tiền thanh toán'),
                initialValue: remainCost.toString(),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                  FormBuilderValidators.numeric(),
                ]),
              ),
              FormBuilderTextField(
                name: 'transactionNote',
                initialValue: '',
                decoration: const InputDecoration(labelText: 'Ghi chú'),
              ),
              const SizedBox(
                height: 14,
              ),
              FilledButton(
                onPressed: () {
                  double transactionAmount = double.parse(formKey.currentState!.fields['transactionAmount']!.value.toString());

                  if (transactionAmount < 0) {
                    formKey.currentState?.fields['transactionAmount']?.invalidate('Giá tiền không thể bé hơn 0');
                    return;
                  }

                  if (transactionAmount > remainCost) {
                    formKey.currentState?.fields['transactionAmount']?.invalidate('Giá tiền không thể lớn hơn số tiền còn lại (${Utils.moneyFormat.format(remainCost)}đ)');
                    return;
                  }

                  paymentProvider
                      .addTransaction(
                        payment,
                        formKey.currentState!.fields['transactionMethod']!.value,
                        double.parse(formKey.currentState!.fields['transactionAmount']!.value.toString()),
                        formKey.currentState!.fields['transactionNote']!.value,
                      )
                      .andThen(() => paymentProvider.getPayments(payment.owner.id))
                      .andThen(
                        () => subUserProvider.getAllWithPaymentReport(filters: {SubUserFilter.filterByAnyPayment}, usingLoadingIdicator: true),
                      )
                      .match(
                    (l) {
                      log(l);
                      DialogHelper.showSnackBar(context, 'Có lỗi xảy ra: $l');
                    },
                    (r) {
                      log('OK');
                      DialogHelper.showSnackBar(context, 'Thanh toán bill thành công');

                      //Navigator.popUntil(context, ModalRoute.withName(PaymentListOfUserScreen.routeName));
                      final updatedPayment = paymentProvider.payments.firstWhere((p) => p.id == payment.id);

                      context.router.pushAndPopUntil(PaymentDetailRoute(payment: updatedPayment), predicate: (route) => route.settings.name == PaymentListOfUserRoute.name);
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
