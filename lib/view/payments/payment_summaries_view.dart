import 'package:flutter/material.dart';
import 'package:hui_management/helper/utils.dart';
import 'package:hui_management/model/payment_model.dart';
import 'package:hui_management/model/user_model.dart';
import 'package:hui_management/provider/payment_provider.dart';
import 'package:hui_management/view/payments/payment_detail_table_view.dart';
import 'package:hui_management/view/payments/payment_detail_view.dart';
import 'package:provider/provider.dart';

class PaymentWidget extends StatelessWidget {
  final PaymentModel payment;

  const PaymentWidget({super.key, required this.payment});

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          leading: const Icon(Icons.request_quote),
          title: Text('Bill thanh toán ngày ${Utils.dateFormat.format(payment.createAt)}'),
          subtitle: Text('Loại: ${payment.totalCost < 0 ? 'Chủ hụi phải thanh toán' : 'Thành viên phải thanh toán'}\nTổng tiền thanh toán: ${Utils.moneyFormat.format(payment.totalCost.abs())}đ'),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
                onPressed: () => Navigator.of(context).push(
                      //MaterialPageRoute(builder: (context) => PaymentDetailWidget(payment: payment)),
                      MaterialPageRoute(builder: (context) => PaymentDetailTableViewWidget(payment: payment)),
                    ),
                child: const Text('Xử lí bill này')),
            const SizedBox(width: 8),
          ],
        )
      ],
    ));
  }
}

class PaymentSummariesWidget extends StatelessWidget {
  final UserModel user;

  const PaymentSummariesWidget({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final paymentProvider = Provider.of<PaymentProvider>(context);

    final List<Widget> paymentWidgets = paymentProvider.payments
        .map(
          (payment) => PaymentWidget(payment: payment),
        )
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Bill của ${user.name}'),
      ),
      body: ListView(
        children: paymentWidgets,
      ),
    );
  }
}
