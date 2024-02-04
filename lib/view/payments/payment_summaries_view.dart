import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hui_management/helper/utils.dart';
import 'package:hui_management/model/payment_model.dart';
import 'package:hui_management/model/sub_user_with_payment_report.dart';
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
              subtitle: Text('Loại: ${payment.totalCost < 0 ? 'Chủ hụi phải thanh toán' : 'Thành viên phải thanh toán'}\nTổng tiền thanh toán còn lại: ${Utils.moneyFormat.format(payment.remainPayCost.abs())}đ'),
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
  final SubUserWithPaymentReport user;
  const PaymentListOfUserScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final paymentProvider = Provider.of<PaymentProvider>(context);

    final List<Widget> processingBillsWidget = paymentProvider.payments
        .where((p) => p.status == PaymentStatus.processing)
        .map(
          (payment) => PaymentWidget(payment: payment),
        )
        .toList();

    final List<Widget> debtingBillsWidget = paymentProvider.payments
        .where((p) => p.status == PaymentStatus.debting)
        .map(
          (payment) => PaymentWidget(payment: payment),
        )
        .toList();

    final List<Widget> finishedBillsWidget = paymentProvider.payments
        .where((p) => p.status == PaymentStatus.finish)
        .map(
          (payment) => PaymentWidget(payment: payment),
        )
        .toList();

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Bill của ${user.name}'),
          bottom: TabBar(tabs: [
            Tab(
              text: '${processingBillsWidget.length} Bill đang xử lí',
            ),
            Tab(
              text: '${debtingBillsWidget.length} Bill nợ',
            ),
            Tab(
              text: '${finishedBillsWidget.length} Bill thành công',
            )
          ]),
        ),
        // ListView(
        //   children: paymentWidgets,
        // ),
        body: TabBarView(children: [
          ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () => context.pushRoute(
                    AddCustomBillRoute(subuser: user),
                  ),
                  child: const Text('Thêm bill mới'),
                ),
              ),
              ...processingBillsWidget,
            ],
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
