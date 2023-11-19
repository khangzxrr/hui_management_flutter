import 'dart:async';

import 'package:after_layout/after_layout.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hui_management/helper/constants.dart';
import 'package:hui_management/helper/dialog.dart';
import 'package:hui_management/pluto_grid_extentions/pluto_types/pluto_grid_name_field.dart';
import 'package:hui_management/provider/sub_users_provider.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../grid_datasource/member_reports_datasource.dart';
import '../../pluto_grid_extentions/pluto_configurations/pluto_language_vietnamese.dart';

@RoutePage()
class MemberReportScreen extends StatefulWidget {
  const MemberReportScreen({super.key});

  @override
  State<MemberReportScreen> createState() => _MemberReportScreenState();
}

class _MemberReportScreenState extends State<MemberReportScreen> {
  late MemberReportsDataSource dataSource;

  @override
  void initState() {
    super.initState();

    dataSource = MemberReportsDataSource();
  }

  @override
  Widget build(BuildContext context) {
    final userWithPaymentReports = Provider.of<SubUsersProvider>(context, listen: true).subUsersWithPaymentReport;
    dataSource.setReportsData(userWithPaymentReports);

    dataSource.sortedColumns.clear();
    dataSource.sortedColumns.add(const SortColumnDetails(name: 'name', sortDirection: DataGridSortDirection.ascending));
    dataSource.sort();

    bool isMobile = MediaQuery.of(context).size.width < Constants.smallScreenSize;

    return SfDataGrid(
      frozenColumnsCount: 1,
      allowPullToRefresh: false,
      allowMultiColumnSorting: true,
      columnWidthMode: isMobile ? ColumnWidthMode.fitByCellValue : ColumnWidthMode.fill,
      source: dataSource,
      gridLinesVisibility: GridLinesVisibility.both,
      headerGridLinesVisibility: GridLinesVisibility.both,
      allowSorting: true,
      showSortNumbers: true,
      allowColumnsResizing: false,
      columnResizeMode: ColumnResizeMode.onResize,
      columns: buildColumns(),
      tableSummaryRows: buildTableSummaryRows(),
      columnWidthCalculationRange: ColumnWidthCalculationRange.allRows,
    );
  }

  List<GridTableSummaryRow> buildTableSummaryRows() {
    return <GridTableSummaryRow>[
      GridTableSummaryRow(
        title: 'Tổng số thành viên: {totalMemberCount}',
        columns: <GridSummaryColumn>[
          const GridSummaryColumn(
            name: 'totalMemberCount',
            columnName: 'name',
            summaryType: GridSummaryType.count,
          ),
        ],
        position: GridTableSummaryRowPosition.top,
      ),
      GridTableSummaryRow(
        showSummaryInRow: false,
        columns: <GridSummaryColumn>[
          const GridSummaryColumn(
            name: 'sumTotalProcessingAmount',
            columnName: 'totalProcessingAmount',
            summaryType: GridSummaryType.sum,
          ),
          const GridSummaryColumn(
            name: 'sumTotalDebtAmount',
            columnName: 'totalDebtAmount',
            summaryType: GridSummaryType.sum,
          ),
          const GridSummaryColumn(
            name: 'sumTotalAliveAmount',
            columnName: 'totalAliveAmount',
            summaryType: GridSummaryType.sum,
          ),
          const GridSummaryColumn(
            name: 'sumTotalDeadAmount',
            columnName: 'totalDeadAmount',
            summaryType: GridSummaryType.sum,
          ),
          const GridSummaryColumn(
            name: 'sumTotalTakenAmount',
            columnName: 'totalTakenAmount',
            summaryType: GridSummaryType.sum,
          ),
          const GridSummaryColumn(
            name: 'sumFundRatio',
            columnName: 'fundRatio',
            summaryType: GridSummaryType.sum,
          ),
        ],
        position: GridTableSummaryRowPosition.bottom,
      ),
    ];
  }

  List<GridColumn> buildColumns() {
    return [
      GridColumn(
        columnName: 'name',
        minimumWidth: 100,
        label: Container(
          padding: const EdgeInsets.all(5.0),
          alignment: Alignment.center,
          child: const Text('Tên hụi viên'),
        ),
      ),
      GridColumn(
        columnName: 'nickName',
        minimumWidth: 100,
        label: Container(
          padding: const EdgeInsets.all(5.0),
          alignment: Alignment.center,
          child: const Text('Biệt danh'),
        ),
      ),
      GridColumn(
        columnName: 'totalProcessingAmount',
        minimumWidth: 100,
        label: Container(
          padding: const EdgeInsets.all(5.0),
          alignment: Alignment.center,
          child: const Text('Tiền đóng'),
        ),
      ),
      GridColumn(
        columnName: 'totalDebtAmount',
        minimumWidth: 100,
        label: Container(
          padding: const EdgeInsets.all(5.0),
          alignment: Alignment.center,
          child: const Text('Tiền nợ'),
        ),
      ),
      GridColumn(
        columnName: 'totalAliveAmount',
        minimumWidth: 100,
        label: Container(
          padding: const EdgeInsets.all(5.0),
          alignment: Alignment.center,
          child: const Text('Tiền hụi sống'),
        ),
      ),
      GridColumn(
        columnName: 'totalDeadAmount',
        minimumWidth: 100,
        label: Container(
          padding: const EdgeInsets.all(5.0),
          alignment: Alignment.center,
          child: const Text('Tổng tiền hụi chết'),
        ),
      ),
      GridColumn(
        columnName: 'totalTakenAmount',
        minimumWidth: 100,
        label: Container(
          padding: const EdgeInsets.all(5.0),
          alignment: Alignment.center,
          child: const Text('Tổng tiền hốt'),
        ),
      ),
      GridColumn(
        columnName: 'fundRatio',
        minimumWidth: 100,
        label: Container(
          padding: const EdgeInsets.all(5.0),
          alignment: Alignment.center,
          child: const Text('Âm/Dương'),
        ),
      ),
    ];
  }
}
