import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hui_management/model/user_report_model.dart';
import 'package:pluto_grid/pluto_grid.dart';

import '../../helper/utils.dart';

@RoutePage()
class MemberReportScreen extends StatefulWidget {
  final List<UserReportModel> userReportModels;

  const MemberReportScreen({super.key, required this.userReportModels});

  @override
  State<MemberReportScreen> createState() => _MemberReportScreenState();
}

class _MemberReportScreenState extends State<MemberReportScreen> {
  String filterText = '';

  List<PlutoColumn> columns = [
    PlutoColumn(title: 'Tên hụi viên', field: 'name', type: PlutoColumnType.text(), readOnly: true, enableSorting: true, frozen: PlutoColumnFrozen.start),
    PlutoColumn(
      title: 'Biệt danh',
      field: 'nickName',
      type: PlutoColumnType.text(),
      enableEditingMode: false,
    ),
    PlutoColumn(
      title: 'Tổng tiền đóng',
      field: 'totalProcessingAmount',
      type: PlutoColumnType.text(),
      enableSorting: true,
      readOnly: true,
    ),
    PlutoColumn(
      title: 'Tổng tiền nợ',
      field: 'totalDebtAmount',
      type: PlutoColumnType.text(),
      enableSorting: true,
      readOnly: true,
    ),
    PlutoColumn(
      title: 'Tổng tiền hụi sống',
      field: 'totalAliveAmount',
      type: PlutoColumnType.text(),
      enableSorting: true,
      readOnly: true,
    ),
    PlutoColumn(
      title: 'Tổng tiền hụi chết',
      field: 'totalDeadAmount',
      type: PlutoColumnType.text(),
      enableSorting: true,
      readOnly: true,
    ),
    PlutoColumn(
      title: 'Tổng tiền hốt',
      field: 'totalTakenAmount',
      type: PlutoColumnType.text(),
      enableSorting: true,
      readOnly: true,
    ),
    PlutoColumn(
      title: 'Âm/Dương',
      field: 'fundRatio',
      type: PlutoColumnType.text(),
      readOnly: true,
      enableSorting: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    List<PlutoRow> rows = widget.userReportModels
        .map((u) => PlutoRow(cells: {
              'name': PlutoCell(value: u.name),
              'nickName': PlutoCell(value: u.nickName),
              'totalAliveAmount': PlutoCell(value: '${Utils.moneyFormat.format(u.totalAliveAmount)}đ'),
              'totalDeadAmount': PlutoCell(value: '${Utils.moneyFormat.format(u.totalDeadAmount)}đ'),
              'totalTakenAmount': PlutoCell(value: '${Utils.moneyFormat.format(u.totalTakenAmount)}đ'),
              'totalProcessingAmount': PlutoCell(value: '${Utils.moneyFormat.format(u.totalProcessingAmount)}đ'),
              'totalDebtAmount': PlutoCell(value: '${Utils.moneyFormat.format(u.totalDebtAmount)}đ'),
              'fundRatio': PlutoCell(value: '${Utils.moneyFormat.format(u.fundRatio)}đ'),
            }))
        .toList();

    return Scaffold(
        appBar: AppBar(
          title: const Text('Báo cáo thành viên'),
        ),
        body: PlutoGrid(
          columns: columns,
          rows: rows,
          // configuration: PlutoGridConfiguration(
          //   columnSize: PlutoGridColumnSizeConfig(autoSizeMode: PlutoAutoSizeMode.equal),
          // ),
        ));
  }
}
