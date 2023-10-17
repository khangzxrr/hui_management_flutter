import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hui_management/helper/utils.dart';
import 'package:hui_management/model/payment_model.dart';
import 'package:hui_management/model/user_with_payment_report.dart';
import 'package:hui_management/provider/payment_provider.dart';
import 'package:provider/provider.dart';

import '../../routes/app_route.dart';

class PaymentWidget extends StatelessWidget {
  final PaymentModel payment;

  const PaymentWidget({super.key, required this.payment});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.request_quote),
              title: Text('Bill thanh toán ngày ${Utils.dateFormat.format(payment.createAt.toLocal())}'),
              subtitle: Text('Loại: ${payment.totalCost < 0 ? 'Chủ hụi phải thanh toán' : 'Thành viên phải thanh toán'}\nTổng tiền thanh toán: ${Utils.moneyFormat.format(payment.totalCost.abs())}đ'),
            ),
          ],
        ),
        onTap: () => context.router.push(PaymentDetailRoute(payment: payment)),
      ),
    );
  }
}

@RoutePage()
class PaymentListOfUserScreen extends StatelessWidget {
  final UserWithPaymentReport user;
  const PaymentListOfUserScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final paymentProvider = Provider.of<PaymentProvider>(context);

    final List<Widget> processingBillsWidget = paymentProvider.payments
        .where((p) => p.status == 'Processing')
        .map(
          (payment) => PaymentWidget(payment: payment),
        )
        .toList();

    final List<Widget> debtingBillsWidget = paymentProvider.payments
        .where((p) => p.status == 'Debting')
        .map(
          (payment) => PaymentWidget(payment: payment),
        )
        .toList();

    final List<Widget> finishedBillsWidget = paymentProvider.payments
        .where((p) => p.status == 'Finish')
        .map(
          (payment) => PaymentWidget(payment: payment),
        )
        .toList();

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Bill của ${user.name}'),
          bottom: const TabBar(tabs: [
            Tab(
              text: 'Bill đang xử lí',
            ),
            Tab(
              text: 'Bill nợ',
            ),
            Tab(
              text: 'Bill thành công',
            )
          ]),
        ),
        // ListView(
        //   children: paymentWidgets,
        // ),
        body: TabBarView(children: [
          ListView(
            children: processingBillsWidget,
          ),
          ListView(
            children: debtingBillsWidget,
          ),
          ListView(
            children: finishedBillsWidget,
          ),
        ]),
      ),
    );
  }
}
