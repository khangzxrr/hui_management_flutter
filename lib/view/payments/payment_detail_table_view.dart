import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hui_management/grid_datasource/custom_bill_datasource.dart';
import 'package:hui_management/helper/constants.dart';
import 'package:hui_management/helper/utils.dart';
import 'package:hui_management/model/fund_normal_session_detail_model.dart';
import 'package:hui_management/model/payment_fund_bill_model.dart';
import 'package:hui_management/model/payment_model.dart';
import 'package:hui_management/model/payment_transaction_model.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../model/custom_bill_model.dart';
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
              'createAt': PlutoCell(value: Utils.dateFormat.format(t.createAt.toLocal())),
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
      title: 'Mệnh giá',
      field: 'fundPrice',
      textAlign: PlutoColumnTextAlign.center,
      titleTextAlign: PlutoColumnTextAlign.center,
      type: PlutoColumnType.text(),
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
    PlutoColumn(
      title: 'Ngày kết thúc',
      field: 'fundEndDate',
      type: PlutoColumnType.text(),
      textAlign: PlutoColumnTextAlign.center,
      titleTextAlign: PlutoColumnTextAlign.center,
      width: 100,
    ),
  ];

  FundSessionDetailWidget({super.key, required this.fundBills});

  @override
  Widget build(BuildContext context) {
    List<PlutoRow> rows = fundBills.map((fb) {
      return PlutoRow(
        cells: {
          'fundName': PlutoCell(value: fb.fromFund.name),
          'fundPrice': PlutoCell(value: '${Utils.moneyFormat.format(fb.fromFund.fundPrice)} đ'),
          'sessionNumber': PlutoCell(value: '${fb.fromSession.sessionNumber}/${fb.fromFund.membersCount}'),
          'predictedPrice': PlutoCell(value: '${Utils.moneyFormat.format(fb.fromSessionDetail.predictedPrice)}đ'),
          'fundOpenText': PlutoCell(value: Utils.dateFormat.format(fb.fromSession.takenDate.toLocal())),
          'takeFromFundMemberPrice': PlutoCell(value: (fb.fromSessionDetail.type != NormalSessionDetailType.taken) ? '${Utils.moneyFormat.format(fb.fromSessionDetail.payCost)}đ' : ''),
          'takeFromOwnerPrice': PlutoCell(value: (fb.fromSessionDetail.type == NormalSessionDetailType.taken) ? '${Utils.moneyFormat.format(fb.fromSessionDetail.payCost)}đ' : ''),
          'fundOpenDate': PlutoCell(value: Utils.dateFormat.format(fb.fromFund.openDate.toLocal())),
          'fundEndDate': PlutoCell(value: Utils.dateFormat.format(fb.fromFund.endDate.toLocal())),
        },
      );
    }).toList();

    return PlutoGrid(mode: PlutoGridMode.readOnly, columns: columns, rows: rows);
  }
}

class CustomBillTableWidget extends StatelessWidget {
  final List<CustomBill> customBills;

  const CustomBillTableWidget({super.key, required this.customBills});

  @override
  Widget build(BuildContext context) {
    CustomBillDataSource customBillDataSource = CustomBillDataSource(customBills);

    return SfDataGrid(
      source: customBillDataSource,
      columns: buildColumns(),
      columnWidthMode: ColumnWidthMode.fill,
      allowMultiColumnSorting: true,
      gridLinesVisibility: GridLinesVisibility.both,
      headerGridLinesVisibility: GridLinesVisibility.both,
    );
  }

  List<GridColumn> buildColumns() {
    return [
      GridColumn(
        columnName: 'description',
        minimumWidth: 100,
        label: Container(
          padding: const EdgeInsets.all(5.0),
          alignment: Alignment.center,
          child: const Text('Mô tả'),
        ),
      ),
      GridColumn(
        columnName: 'type',
        minimumWidth: 100,
        label: Container(
          padding: const EdgeInsets.all(5.0),
          alignment: Alignment.center,
          child: const Text('Loại Bill'),
        ),
      ),
      GridColumn(
        columnName: 'payCost',
        minimumWidth: 100,
        label: Container(
          padding: const EdgeInsets.all(5.0),
          alignment: Alignment.center,
          child: const Text('Giá tiền'),
        ),
      ),
    ];
  }
}

@RoutePage()
class PaymentDetailScreen extends StatelessWidget {
  final PaymentModel payment;

  const PaymentDetailScreen({super.key, required this.payment});

  @override
  Widget build(BuildContext context) {
    final paymentProvider = Provider.of<PaymentProvider>(context, listen: false);

    final isSmallScreen = MediaQuery.of(context).size.width < Constants.smallScreenSize;

    return Scaffold(
      appBar: AppBar(
        title: isSmallScreen ? Text('Bill của ${paymentProvider.selectedUser.name}\nngày ${Utils.dateFormat.format(payment.createAt.toLocal())}') : Text('Bill của ${paymentProvider.selectedUser.name} ngày ${Utils.dateFormat.format(payment.createAt.toLocal())}'),
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
              payment.fundBills.isEmpty
                  ? const SizedBox(
                      height: 0,
                    )
                  : SizedBox(
                      height: 50.0 * (payment.fundBills.length + 1),
                      child: FundSessionDetailWidget(fundBills: payment.fundBills),
                    ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 60.0 * (payment.customBills.length + 1),
                child: CustomBillTableWidget(customBills: payment.customBills),
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
                      Text(payment.status == PaymentStatus.debting ? 'Nợ còn lại: ' : 'Tổng còn lại phải thanh toán: '),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '${Utils.moneyFormat.format(payment.totalOwnerMustTake)}đ',
                        textAlign: TextAlign.right,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '${Utils.moneyFormat.format(payment.totalOwnerMustPaid)}đ',
                        textAlign: TextAlign.right,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text('${Utils.moneyFormat.format(payment.totalTransactionCost)}đ',
                          textAlign: TextAlign.right,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          )),
                      Text(
                        '${Utils.moneyFormat.format(payment.remainPayCost)}đ',
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
                      text: (payment.ownerPaidTakeDiff > 0) ? 'chi tiền' : 'thu tiền',
                      style: const TextStyle(fontWeight: FontWeight.bold, backgroundColor: Colors.red, color: Colors.white),
                    ),
                    TextSpan(
                      text: (payment.ownerPaidTakeDiff > 0) ? ' cho ' : ' từ ',
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
                  onPressed: () => (payment.status == PaymentStatus.finish) ? {} : context.router.push(PaycheckRoute(payment: payment)),
                  child: Text(payment.status == PaymentStatus.finish ? 'Đã thanh toán thành công' : 'Thanh toán bill này'),
                ),
              )
            ],
          )),
    );
  }
}
