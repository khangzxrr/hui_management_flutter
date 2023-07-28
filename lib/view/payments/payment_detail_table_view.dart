import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hui_management/helper/utils.dart';
import 'package:hui_management/model/payment_fund_bill_model.dart';
import 'package:hui_management/model/payment_model.dart';
import 'package:hui_management/model/payment_transaction_model.dart';
import 'package:pluto_grid/pluto_grid.dart';

import '../../routes/app_route.dart';
import 'payment_paycheck_view.dart';

class TransactionListWidget extends StatelessWidget {
  final List<PaymentTransaction> transactions;

  TransactionListWidget({super.key, required this.transactions});

  final List<PlutoColumn> columns = [
    PlutoColumn(
      title: 'Số tiền',
      field: 'amount',
      type: PlutoColumnType.text(),
      textAlign: PlutoColumnTextAlign.right,
      titleTextAlign: PlutoColumnTextAlign.center,
      width: 100,
    ),
    PlutoColumn(
      title: 'Ghi chú',
      field: 'note',
      type: PlutoColumnType.text(),
      textAlign: PlutoColumnTextAlign.right,
      titleTextAlign: PlutoColumnTextAlign.center,
      width: 100,
    ),
    PlutoColumn(
      title: 'Phương thức',
      field: 'paymentMethod',
      type: PlutoColumnType.text(),
      textAlign: PlutoColumnTextAlign.right,
      titleTextAlign: PlutoColumnTextAlign.center,
      width: 100,
    ),
    PlutoColumn(
      title: 'Ngày thanh toán',
      field: 'createAt',
      type: PlutoColumnType.text(),
      textAlign: PlutoColumnTextAlign.right,
      titleTextAlign: PlutoColumnTextAlign.center,
      width: 130,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final List<PlutoRow> rows = transactions
        .map(
          (t) => PlutoRow(
            cells: {
              'amount': PlutoCell(value: '${Utils.moneyFormat.format(t.amount)}đ'),
              'note': PlutoCell(value: t.description),
              'paymentMethod': PlutoCell(value: t.method == 'ByCash' ? 'Tiền mặt' : 'Chuyển khoản'),
              'createAt': PlutoCell(value: Utils.dateFormat.format(t.createAt)),
            },
          ),
        )
        .toList();

    return PlutoGrid(mode: PlutoGridMode.readOnly, columns: columns, rows: rows);
  }
}

class FundSessionDetailWidget extends StatelessWidget {
  final List<FundBillModel> fundBills;

  final List<PlutoColumn> columns = [
    PlutoColumn(
      title: 'Kỳ',
      field: 'sessionNumber',
      type: PlutoColumnType.text(),
      textAlign: PlutoColumnTextAlign.center,
      titleTextAlign: PlutoColumnTextAlign.center,
      width: 100,
    ),
    PlutoColumn(
      title: 'Ngày mở',
      field: 'fundOpenDate',
      type: PlutoColumnType.text(),
      textAlign: PlutoColumnTextAlign.center,
      titleTextAlign: PlutoColumnTextAlign.center,
      width: 100,
    ),
    PlutoColumn(
      title: 'Mệnh giá',
      field: 'fundPrice',
      textAlign: PlutoColumnTextAlign.center,
      titleTextAlign: PlutoColumnTextAlign.center,
      type: PlutoColumnType.text(),
      width: 100,
    ),
    PlutoColumn(
      title: 'Khui',
      field: 'fundOpenText',
      type: PlutoColumnType.text(),
      textAlign: PlutoColumnTextAlign.center,
      titleTextAlign: PlutoColumnTextAlign.center,
      width: 100,
    ),
    PlutoColumn(
      title: 'Tiền đóng',
      field: 'takeFromFundMemberPrice',
      type: PlutoColumnType.text(),
      textAlign: PlutoColumnTextAlign.center,
      titleTextAlign: PlutoColumnTextAlign.center,
      width: 100,
    ),
    PlutoColumn(
      title: 'Tiền hốt',
      field: 'takeFromOwnerPrice',
      type: PlutoColumnType.text(),
      textAlign: PlutoColumnTextAlign.center,
      titleTextAlign: PlutoColumnTextAlign.center,
      width: 100,
    ),
  ];

  FundSessionDetailWidget({super.key, required this.fundBills});

  @override
  Widget build(BuildContext context) {
    List<PlutoRow> rows = fundBills
        .map(
          (e) => PlutoRow(
            cells: {
              'fundOpenDate': PlutoCell(value: Utils.dateFormat.format(e.fromFund.openDate)),
              'fundPrice': PlutoCell(value: '${Utils.moneyFormat.format(e.fromFund.fundPrice)}đ'),
              'fundOpenText': PlutoCell(value: e.fromFund.openDateText),
              'sessionNumber': PlutoCell(value: '${e.fromSession.sessionNumber}/${e.fromFund.membersCount}'),
              'takeFromOwnerPrice': PlutoCell(value: (e.fromSessionDetail.type == 'Taken') ? '${Utils.moneyFormat.format(e.fromSessionDetail.payCost)}đ' : ''),
              'takeFromFundMemberPrice': PlutoCell(value: (e.fromSessionDetail.type != 'Taken') ? '${Utils.moneyFormat.format(e.fromSessionDetail.payCost)}đ' : ''),
            },
          ),
        )
        .toList();

    return PlutoGrid(mode: PlutoGridMode.readOnly, columns: columns, rows: rows);
  }
}

class PaymentDetailTableViewWidget extends StatelessWidget {
  final PaymentModel payment;

  const PaymentDetailTableViewWidget({super.key, required this.payment});

  @override
  Widget build(BuildContext context) {
    double totalTaken = payment.fundBills.fold(0, (previousValue, element) => previousValue + ((element.fromSessionDetail.type == 'Taken') ? element.fromSessionDetail.payCost : 0));
    double totalAliveOrDead = payment.fundBills.fold(0, (previousValue, element) => previousValue + ((element.fromSessionDetail.type != 'Taken') ? element.fromSessionDetail.payCost : 0));

    double ratio = totalTaken - totalAliveOrDead;

    final isSmallScreen = MediaQuery.of(context).size.width < 600;

    return Scaffold(
      appBar: AppBar(
        title: isSmallScreen ? Text('Bill của ${payment.owner.name}\nngày ${Utils.dateFormat.format(payment.createAt)}') : Text('Bill của ${payment.owner.name} ngày ${Utils.dateFormat.format(payment.createAt)}'),
      ),
      body: Container(
          padding: const EdgeInsets.all(14),
          child: ListView(
            children: [
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: Theme.of(context).textTheme.titleLarge,
                  children: <TextSpan>[
                    const TextSpan(text: 'Tên hụi viên: '),
                    TextSpan(text: '${payment.owner.name}\n', style: const TextStyle(fontWeight: FontWeight.bold)),
                    const TextSpan(text: 'Tên ngân hàng: '),
                    TextSpan(text: '${payment.owner.bankname}\n', style: const TextStyle(fontWeight: FontWeight.bold)),
                    const TextSpan(text: 'Số tài khoản: '),
                    TextSpan(text: '${payment.owner.banknumber}\n', style: const TextStyle(fontWeight: FontWeight.bold)),
                    const TextSpan(text: 'Số điện thoại: '),
                    TextSpan(text: '${payment.owner.phonenumber}\n', style: const TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              const SizedBox(
                height: 4,
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 50.0 * (payment.fundBills.length + 1),
                child: FundSessionDetailWidget(fundBills: payment.fundBills),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  const Column(
                    children: [
                      Text('Tổng tiền phải đóng:  \nTổng tiền hốt:  \nTổng còn lại phải thanh toán:  \nTổng tiền đã hoàn thành:  ', textAlign: TextAlign.right),
                    ],
                  ),
                  Column(
                    children: [
                      Text('${Utils.moneyFormat.format(totalAliveOrDead)}đ\n${Utils.moneyFormat.format(totalTaken)}đ\n${Utils.moneyFormat.format(ratio.abs())}đ\n${Utils.moneyFormat.format(payment.totalTransactionCost)}đ', textAlign: TextAlign.right, style: const TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                ],
              ),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: Theme.of(context).textTheme.titleLarge,
                  children: <TextSpan>[
                    TextSpan(
                      text: (ratio > 0) ? 'Chủ hụi phải chi tiền cho hụi viên' : 'Chủ hụi phải thu tiền từ hụi viên',
                      style: TextStyle(fontWeight: FontWeight.bold, backgroundColor: ratio > 0 ? Colors.green : Colors.blue),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 50.0 * (payment.paymentTransactions.length + 1),
                child: TransactionListWidget(transactions: payment.paymentTransactions),
              ),
              const SizedBox(
                height: 4,
              ),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: () => (payment.status == 'Finish') ? {} : context.router.push(PaycheckRoute(payment: payment)),
                  child: Text(payment.status == 'Finish' ? 'Đã thanh toán thành công' : 'Thanh toán bill này'),
                ),
              )
            ],
          )),
    );
  }
}
