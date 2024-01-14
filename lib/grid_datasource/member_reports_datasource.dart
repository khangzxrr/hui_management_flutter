import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hui_management/filters/subuser_filter.dart';
import 'package:hui_management/helper/utils.dart';
import 'package:hui_management/service/user_service.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:collection/collection.dart';
import '../model/sub_user_with_payment_report.dart';
import 'dart:developer' as developer;

class MemberReportsDataSource extends DataGridSource {
  List<DataGridRow> reportRows = [];

  Set<String> numberFormatColumnNames = {
    'totalProcessingAmount',
    'totalDebtAmount',
    'totalAliveAmount',
    'totalDeadAmount',
    'totalUnfinishedTakenAmount',
    'fundRatio',
  };
  void clearData() {
    reportRows.clear();
  }

  @override
  List<DataGridRow> get rows => reportRows;

  @override
  Future<void> handleRefresh() async {
    try {
      final reports = await GetIt.I<UserService>().getAllWithPaymentReport(
          0,
          0,
          SubUserFilter(
            atLeastOnePayment: true,
          ));
      setReportsData(reports);
    } catch (e) {
      developer.log('error getAllWithPaymentReport', error: e);
    }

    notifyListeners();
  }

  void setReportsData(List<SubUserWithPaymentReport> reports) {
    reportRows = reports
        .map<DataGridRow>(
          (r) => DataGridRow(
            cells: [
              DataGridCell(columnName: 'name', value: r.name),
              DataGridCell(columnName: 'nickName', value: r.nickName),
              DataGridCell(columnName: 'totalProcessingAmount', value: r.totalProcessingAmount),
              DataGridCell(columnName: 'totalDebtAmount', value: r.totalDebtAmount),
              DataGridCell(columnName: 'totalAliveAmount', value: r.totalAliveAmount),
              DataGridCell(columnName: 'totalDeadAmount', value: r.totalDeadAmount),
              DataGridCell(columnName: 'totalUnfinishedTakenAmount', value: r.totalUnfinishedTakenAmount),
              DataGridCell(columnName: 'fundRatio', value: r.fundRatio),
            ],
          ),
        )
        .toList();
    notifyListeners();
  }

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>(
      (dataGridCell) {
        late String cellTextValue;

        if (numberFormatColumnNames.contains(dataGridCell.columnName)) {
          cellTextValue = Utils.moneyFormat.format(dataGridCell.value);
        } else {
          cellTextValue = dataGridCell.value.toString();
        }

        return Container(
          padding: const EdgeInsets.all(16.0),
          child: Text(cellTextValue),
        );
      },
    ).toList());
  }

  @override
  Widget? buildTableSummaryCellWidget(GridTableSummaryRow summaryRow, GridSummaryColumn? summaryColumn, RowColumnIndex rowColumnIndex, String summaryValue) {
    if (summaryColumn == null || summaryValue.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(8.0),
        alignment: Alignment.centerLeft,
        child: Text(summaryValue, overflow: TextOverflow.ellipsis),
      );
    }

    String formatedSummaryValue = summaryValue;

    if (numberFormatColumnNames.contains(summaryColumn.columnName)) {
      formatedSummaryValue = Utils.moneyFormat.format(double.parse(summaryValue));
    } else {
      formatedSummaryValue = summaryValue;
    }

    return Container(
      padding: const EdgeInsets.all(8.0),
      alignment: Alignment.centerLeft,
      child: Text(formatedSummaryValue, overflow: TextOverflow.ellipsis),
    );
  }

  @override
  int compare(DataGridRow? a, DataGridRow? b, SortColumnDetails sortColumn) {
    if (sortColumn.name == 'name') {
      final String? rowAValue = a?.getCells().firstWhereOrNull((r) => r.columnName == sortColumn.name)?.value?.toString();
      final String? rowBValue = b?.getCells().firstWhereOrNull((r) => r.columnName == sortColumn.name)?.value?.toString();

      if (rowAValue == null || rowBValue == null) {
        return 0;
      }

      bool ascendingColumnSortDirection = sortColumn.sortDirection == DataGridSortDirection.ascending;

      int compareRowAStartCharWithRowBStartChar = rowAValue.trim().split(' ').last.codeUnitAt(0).compareTo(rowBValue.trim().split(' ').last.codeUnitAt(0));

      if (compareRowAStartCharWithRowBStartChar > 0) {
        return ascendingColumnSortDirection ? 1 : -1;
      } else if (compareRowAStartCharWithRowBStartChar == -1) {
        return ascendingColumnSortDirection ? -1 : 1;
      }

      return 0;
    }

    return super.compare(a, b, sortColumn);
  }
}
