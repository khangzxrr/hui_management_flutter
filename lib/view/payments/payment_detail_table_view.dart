import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hui_management/helper/utils.dart';
import 'package:hui_management/model/payment_fund_bill_model.dart';
import 'package:hui_management/model/payment_model.dart';
import 'package:hui_management/model/payment_transaction_model.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:provider/provider.dart';

import '../../provider/payment_provider.dart';
import '../../routes/app_route.dart';

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
      title: 'Tên hụi',
      field: 'fundName',
      type: PlutoColumnType.text(),
      textAlign: PlutoColumnTextAlign.center,
      titleTextAlign: PlutoColumnTextAlign.center,
      width: 100,
    ),
    PlutoColumn(
      title: 'Kỳ',
      field: 'sessionNumber',
      type: PlutoColumnType.text(),
      textAlign: PlutoColumnTextAlign.center,
      titleTextAlign: PlutoColumnTextAlign.center,
      width: 100,
    ),
    PlutoColumn(
      title: 'Thăm kêu',
      field: 'predictedPrice',
      textAlign: PlutoColumnTextAlign.center,
      titleTextAlign: PlutoColumnTextAlign.center,
      type: PlutoColumnType.text(),
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
      title: 'Ngày khui',
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
    PlutoColumn(
      title: 'Ngày mở',
      field: 'fundOpenDate',
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
              'fundName': PlutoCell(value: e.fromFund.name),
              'predictedPrice': PlutoCell(value: (e.fromSessionDetail.type == 'Taken') ? '${Utils.moneyFormat.format(e.fromSessionDetail.predictedPrice)}đ' : ''),
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

@RoutePage()
class PaymentDetailScreen extends StatelessWidget {
  final PaymentModel payment;

  const PaymentDetailScreen({super.key, required this.payment});

  @override
  Widget build(BuildContext context) {
    final paymentProvider = Provider.of<PaymentProvider>(context, listen: false);

    double totalTaken = payment.fundBills.fold(0, (previousValue, element) => previousValue + ((element.fromSessionDetail.type == 'Taken') ? element.fromSessionDetail.payCost : 0));
    double totalAliveOrDead = payment.fundBills.fold(0, (previousValue, element) => previousValue + ((element.fromSessionDetail.type != 'Taken') ? element.fromSessionDetail.payCost : 0));

    double ratio = totalTaken - totalAliveOrDead;

    final isSmallScreen = MediaQuery.of(context).size.width < 600;

    return Scaffold(
      appBar: AppBar(
        title: isSmallScreen ? Text('Bill của ${paymentProvider.selectedUser.name}\nngày ${Utils.dateFormat.format(payment.createAt)}') : Text('Bill của ${paymentProvider.selectedUser.name} ngày ${Utils.dateFormat.format(payment.createAt)}'),
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
                    const TextSpan(
                      text: 'Tên hụi viên: ',
                    ),
                    TextSpan(text: '${paymentProvider.selectedUser.name}\n', style: const TextStyle(fontWeight: FontWeight.bold)),
                    const TextSpan(text: 'Tên ngân hàng: '),
                    TextSpan(text: '${paymentProvider.selectedUser.bankName}\n', style: const TextStyle(fontWeight: FontWeight.bold)),
                    const TextSpan(text: 'Số tài khoản: '),
                    TextSpan(text: '${paymentProvider.selectedUser.bankNumber}\n', style: const TextStyle(fontWeight: FontWeight.bold)),
                    const TextSpan(text: 'Số điện thoại: '),
                    TextSpan(text: '${paymentProvider.selectedUser.phoneNumber}\n', style: const TextStyle(fontWeight: FontWeight.bold)),
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
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Tổng tiền phải đóng:\t'),
                      const Text('Tổng tiền hốt:\t'),
                      const Text('Tổng tiền đã hoàn thành:\t'),
                      Text(payment.status == 'debting' ? 'Nợ còn lại: ' : 'Tổng còn lại phải thanh toán: '),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '${Utils.moneyFormat.format(totalAliveOrDead)}đ',
                        textAlign: TextAlign.right,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '${Utils.moneyFormat.format(totalTaken)}đ',
                        textAlign: TextAlign.right,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text('${Utils.moneyFormat.format(payment.totalTransactionCost)}đ',
                          textAlign: TextAlign.right,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          )),
                      Text(
                        '${Utils.moneyFormat.format(ratio.abs() - payment.totalTransactionCost)}đ',
                        textAlign: TextAlign.right,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: Theme.of(context).textTheme.titleLarge,
                  children: <TextSpan>[
                    const TextSpan(text: 'Chủ hụi phải '),
                    TextSpan(
                      text: (ratio > 0) ? 'chi tiền' : 'thu tiền',
                      style: const TextStyle(fontWeight: FontWeight.bold, backgroundColor: Colors.red, color: Colors.white),
                    ),
                    TextSpan(
                      text: (ratio > 0) ? ' cho ' : ' từ ',
                    ),
                    const TextSpan(text: 'hụi viên'),
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
