import 'package:flutter/material.dart';
import 'package:hui_management/helper/utils.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:collection/collection.dart';
import '../model/user_with_payment_report.dart';

class MemberReportsDataSource extends DataGridSource {
  List<DataGridRow> reportRows = [];

  @override
  List<DataGridRow> get rows => reportRows;

  void setReportsData(List<UserWithPaymentReport> reports) {
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
              DataGridCell(columnName: 'totalTakenAmount', value: r.totalTakenAmount),
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

        if (dataGridCell.columnName == 'totalProcessingAmount' || dataGridCell.columnName == 'totalDebtAmount' || dataGridCell.columnName == 'totalAliveAmount' || dataGridCell.columnName == 'totalDeadAmount' || dataGridCell.columnName == 'totalTakenAmount' || dataGridCell.columnName == 'fundRatio') {
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

    if (summaryColumn.columnName == 'totalProcessingAmount' || summaryColumn.columnName == 'totalDebtAmount' || summaryColumn.columnName == 'totalAliveAmount' || summaryColumn.columnName == 'totalDeadAmount' || summaryColumn.columnName == 'totalTakenAmount' || summaryColumn.columnName == 'fundRatio') {
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

      int compareRowAStartCharWithRowBStartChar = rowAValue.split(' ').last.codeUnitAt(0).compareTo(rowBValue.split(' ').last.codeUnitAt(0));

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
