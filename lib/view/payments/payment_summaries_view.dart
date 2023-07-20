import 'package:flutter/material.dart';
import 'package:hui_management/helper/utils.dart';
import 'package:hui_management/model/payment_model.dart';
import 'package:hui_management/model/user_model.dart';
import 'package:hui_management/provider/payment_provider.dart';
import 'package:hui_management/view/payments/payment_detail_table_view.dart';
import 'package:provider/provider.dart';

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
              title: Text('Bill thanh toán ngày ${Utils.dateFormat.format(payment.createAt)}'),
              subtitle: Text('Loại: ${payment.totalCost < 0 ? 'Chủ hụi phải thanh toán' : 'Thành viên phải thanh toán'}\nTổng tiền thanh toán: ${Utils.moneyFormat.format(payment.totalCost.abs())}đ'),
            ),
          ],
        ),
        onTap: () => Navigator.of(context).push(
          //MaterialPageRoute(builder: (context) => PaymentDetailWidget(payment: payment)),
          MaterialPageRoute(builder: (context) => PaymentDetailTableViewWidget(payment: payment)),
        ),
      ),
    );
  }
}

class PaymentSummariesWidget extends StatelessWidget {
  static const routeName = "/payment-summaries";

  const PaymentSummariesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final user = ModalRoute.of(context)!.settings.arguments as UserModel?;

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
          title: Text('Bill của ${user!.name}'),
          bottom: const TabBar(tabs: [
            Tab(
              text: 'Bill đang xử lí',
            ),
            Tab(
              text: 'Bill đang nợ',
            ),
            Tab(
              text: 'Bill đã thành công',
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
