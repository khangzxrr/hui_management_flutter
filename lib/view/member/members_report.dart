import 'dart:async';

import 'package:after_layout/after_layout.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hui_management/filters/subuser_filter.dart';
import 'package:hui_management/helper/constants.dart';
import 'package:hui_management/helper/dialog.dart';
import 'package:hui_management/model/sub_user_with_payment_report.dart';
import 'package:hui_management/service/user_service.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../grid_datasource/member_reports_datasource.dart';

@RoutePage()
class MemberReportScreen extends StatefulWidget {
  final List<SubUserWithPaymentReport> reports = [];

  MemberReportScreen({super.key});

  @override
  State<MemberReportScreen> createState() => _MemberReportScreenState();
}

class _MemberReportScreenState extends State<MemberReportScreen> with AfterLayoutMixin<MemberReportScreen> {
  late MemberReportsDataSource dataSource;

  @override
  void initState() {
    super.initState();

    dataSource = MemberReportsDataSource();
  }

  @override
  Widget build(BuildContext context) {
    dataSource.clearData();

    dataSource.setReportsData(widget.reports);

    dataSource.sortedColumns.clear();
    dataSource.sortedColumns.add(const SortColumnDetails(name: 'name', sortDirection: DataGridSortDirection.ascending));
    dataSource.sort();

    bool isMobile = MediaQuery.of(context).size.width < Constants.smallScreenSize;

    if (widget.reports.isEmpty) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return SfDataGrid(
      allowPullToRefresh: true,
      frozenColumnsCount: 1,
      allowMultiColumnSorting: true,
      columnWidthMode: isMobile ? ColumnWidthMode.fitByCellValue : ColumnWidthMode.fill,
      source: dataSource,
      gridLinesVisibility: GridLinesVisibility.both,
      headerGridLinesVisibility: GridLinesVisibility.both,
      allowSorting: true,
      showSortNumbers: true,
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
            name: 'sumTotalUnfinishedTakenAmount',
            columnName: 'totalUnfinishedTakenAmount',
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
        columnName: 'nickName',
        minimumWidth: 100,
        columnWidthMode: ColumnWidthMode.fitByCellValue,
        label: Container(
          padding: const EdgeInsets.all(5.0),
          alignment: Alignment.center,
          child: const Text('Biệt danh'),
        ),
      ),
      GridColumn(
        columnName: 'name',
        minimumWidth: 100,
        columnWidthMode: ColumnWidthMode.fitByCellValue,
        label: Container(
          padding: const EdgeInsets.all(5.0),
          alignment: Alignment.center,
          child: const Text('Tên hụi viên'),
        ),
      ),
      GridColumn(
        columnName: 'totalProcessingAmount',
        minimumWidth: 100,
        columnWidthMode: ColumnWidthMode.fitByCellValue,
        label: Container(
          padding: const EdgeInsets.all(5.0),
          alignment: Alignment.center,
          child: const Text('Tiền đóng'),
        ),
      ),
      GridColumn(
        columnName: 'totalDebtAmount',
        minimumWidth: 100,
        columnWidthMode: ColumnWidthMode.fitByCellValue,
        label: Container(
          padding: const EdgeInsets.all(5.0),
          alignment: Alignment.center,
          child: const Text('Tiền nợ'),
        ),
      ),
      GridColumn(
        columnName: 'totalAliveAmount',
        minimumWidth: 100,
        columnWidthMode: ColumnWidthMode.fitByCellValue,
        label: Container(
          padding: const EdgeInsets.all(5.0),
          alignment: Alignment.center,
          child: const Text('Tiền hụi sống'),
        ),
      ),
      GridColumn(
        columnName: 'totalDeadAmount',
        minimumWidth: 100,
        columnWidthMode: ColumnWidthMode.fitByCellValue,
        label: Container(
          padding: const EdgeInsets.all(5.0),
          alignment: Alignment.center,
          child: const Text('Tổng tiền hụi chết'),
        ),
      ),
      GridColumn(
        columnName: 'totalUnfinishedTakenAmount',
        minimumWidth: 100,
        columnWidthMode: ColumnWidthMode.fitByCellValue,
        label: Container(
          padding: const EdgeInsets.all(5.0),
          alignment: Alignment.center,
          child: const Text('Tổng tiền hốt'),
        ),
      ),
      GridColumn(
        columnName: 'fundRatio',
        minimumWidth: 100,
        columnWidthMode: ColumnWidthMode.fitByCellValue,
        label: Container(
          padding: const EdgeInsets.all(5.0),
          alignment: Alignment.center,
          child: const Text('Âm/Dương'),
        ),
      ),
    ];
  }

  @override
  FutureOr<void> afterFirstLayout(BuildContext context) async {
    try {
      final fetchedReports = await GetIt.I<UserService>().getAllWithPaymentReport(
          0,
          0,
          SubUserFilter(
            atLeastOnePayment: true,
          ));
      setState(() {
        widget.reports.clear();
        widget.reports.addAll(fetchedReports);
      });
    } catch (e) {
      DialogHelper.showSnackBar(context, 'Lỗi khi lấy dữ liệu, vui lòng liên hệ admin');
    }
  }
}
