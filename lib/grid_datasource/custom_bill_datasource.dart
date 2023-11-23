import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../helper/utils.dart';
import '../model/custom_bill_model.dart';

class CustomBillDataSource extends DataGridSource {
  List<DataGridRow> customBillRows = [];

  @override
  List<DataGridRow> get rows => customBillRows;

  CustomBillDataSource(List<CustomBill> customBills) {
    setCustomBillData(customBills);
  }

  //finish this
  void setCustomBillData(List<CustomBill> customBills) {
    customBillRows = customBills
        .map((b) => DataGridRow(
              cells: [
                DataGridCell(columnName: 'description', value: b.description),
                DataGridCell(columnName: 'type', value: b.type),
                DataGridCell(columnName: 'payCost', value: b.payCost),
              ],
            ))
        .toList();

    notifyListeners();
  }

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((cell) {
      String cellTextValue = cell.value.toString();

      if (cell.columnName == 'type') {
        cellTextValue = cell.value as CustomBillType == CustomBillType.ownerTake ? 'Chủ hụi thu' : 'Chủ hụi chi';
      } else if (cell.columnName == 'payCost') {
        cellTextValue = Utils.moneyFormat.format(cell.value);
      }

      return Container(
        padding: const EdgeInsets.all(16.0),
        child: Text(cellTextValue, textAlign: TextAlign.center),
      );
    }).toList());
  }
}
