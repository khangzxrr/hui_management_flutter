import 'dart:async';

import 'package:after_layout/after_layout.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:provider/provider.dart';

import '../../provider/user_report_provider.dart';

@RoutePage()
class MemberReportScreen extends StatefulWidget {
  const MemberReportScreen({super.key});

  @override
  State<MemberReportScreen> createState() => _MemberReportScreenState();
}

class _MemberReportScreenState extends State<MemberReportScreen> with AfterLayoutMixin<MemberReportScreen> {
  String filterText = '';

  List<PlutoColumn> columns = [
    PlutoColumn(
      title: 'Tên hụi viên',
      field: 'name',
      type: PlutoColumnType.text(),
      readOnly: true,
      enableSorting: true,
      frozen: PlutoColumnFrozen.start,
    ),
    PlutoColumn(
      title: 'Biệt danh',
      field: 'nickName',
      type: PlutoColumnType.text(),
      enableEditingMode: false,
    ),
    PlutoColumn(
      title: 'Tiền đóng',
      field: 'totalProcessingAmount',
      type: PlutoColumnType.currency(
        name: 'VNĐ',
        decimalDigits: 0,
        format: '#,### đ',
      ),
      enableSorting: true,
      readOnly: true,
      footerRenderer: (rendererContext) {
        return PlutoAggregateColumnFooter(
          rendererContext: rendererContext,
          type: PlutoAggregateColumnType.sum,
          alignment: Alignment.centerLeft,
          titleSpanBuilder: (text) {
            return [
              const TextSpan(text: 'Tổng tiền đóng: '),
              TextSpan(
                text: text,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ];
          },
        );
      },
    ),
    PlutoColumn(
      title: 'Tiền nợ',
      field: 'totalDebtAmount',
      type: PlutoColumnType.currency(
        name: 'VNĐ',
        decimalDigits: 0,
        format: '#,### đ',
      ),
      enableSorting: true,
      readOnly: true,
      footerRenderer: (rendererContext) {
        return PlutoAggregateColumnFooter(
          rendererContext: rendererContext,
          type: PlutoAggregateColumnType.sum,
          alignment: Alignment.centerLeft,
          titleSpanBuilder: (text) {
            return [
              const TextSpan(text: 'Tổng tiền nợ: '),
              TextSpan(
                text: text,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ];
          },
        );
      },
    ),
    PlutoColumn(
      title: 'Tiền hụi sống',
      field: 'totalAliveAmount',
      enableSorting: true,
      readOnly: true,
      type: PlutoColumnType.currency(
        name: 'VNĐ',
        decimalDigits: 0,
        format: '#,### đ',
      ),
      footerRenderer: (rendererContext) {
        return PlutoAggregateColumnFooter(
          rendererContext: rendererContext,
          type: PlutoAggregateColumnType.sum,
          alignment: Alignment.centerLeft,
          titleSpanBuilder: (text) {
            return [
              const TextSpan(text: 'Tổng tiền hụi sống: '),
              TextSpan(
                text: text,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ];
          },
        );
      },
    ),
    PlutoColumn(
      title: 'Tổng tiền hụi chết',
      field: 'totalDeadAmount',
      enableSorting: true,
      readOnly: true,
      type: PlutoColumnType.currency(
        name: 'VNĐ',
        decimalDigits: 0,
        format: '#,### đ',
      ),
      footerRenderer: (rendererContext) {
        return PlutoAggregateColumnFooter(
          rendererContext: rendererContext,
          type: PlutoAggregateColumnType.sum,
          alignment: Alignment.centerLeft,
          titleSpanBuilder: (text) {
            return [
              const TextSpan(text: 'Tổng tiền hụi chết: '),
              TextSpan(
                text: text,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ];
          },
        );
      },
    ),
    PlutoColumn(
      title: 'Tiền hốt',
      field: 'totalTakenAmount',
      enableSorting: true,
      readOnly: true,
      type: PlutoColumnType.currency(
        name: 'VNĐ',
        decimalDigits: 0,
        format: '#,### đ',
      ),
      footerRenderer: (rendererContext) {
        return PlutoAggregateColumnFooter(
          rendererContext: rendererContext,
          type: PlutoAggregateColumnType.sum,
          alignment: Alignment.centerLeft,
          titleSpanBuilder: (text) {
            return [
              const TextSpan(text: 'Tổng tiền hốt: '),
              TextSpan(
                text: text,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ];
          },
        );
      },
    ),
    PlutoColumn(
      title: 'Âm/Dương',
      field: 'fundRatio',
      enableSorting: true,
      readOnly: true,
      type: PlutoColumnType.currency(
        name: 'VNĐ',
        decimalDigits: 0,
        format: '#,### đ',
      ),
      footerRenderer: (rendererContext) {
        return PlutoAggregateColumnFooter(
          rendererContext: rendererContext,
          type: PlutoAggregateColumnType.sum,
          alignment: Alignment.centerLeft,
          titleSpanBuilder: (text) {
            return [
              const TextSpan(text: 'Tổng Âm/Dương: '),
              TextSpan(
                text: text,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ];
          },
        );
      },
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final userReportProvider = Provider.of<UserReportProvider>(context, listen: true);

    List<PlutoRow> rows = userReportProvider.userReportModels
        .map((u) => PlutoRow(cells: {
              'name': PlutoCell(value: u.name),
              'nickName': PlutoCell(value: u.nickName),
              'totalAliveAmount': PlutoCell(value: u.totalAliveAmount),
              'totalDeadAmount': PlutoCell(value: u.totalDeadAmount),
              'totalTakenAmount': PlutoCell(value: u.totalTakenAmount),
              'totalProcessingAmount': PlutoCell(value: u.totalProcessingAmount),
              'totalDebtAmount': PlutoCell(value: u.totalDebtAmount),
              'fundRatio': PlutoCell(value: u.fundRatio),
            }))
        .toList();

    return userReportProvider.loading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : PlutoGrid(
            columns: columns,
            rows: rows,
            // configuration: PlutoGridConfiguration(
            //   columnSize: PlutoGridColumnSizeConfig(
            //     autoSizeMode: PlutoAutoSizeMode.scale,
            //   ),
            // ),
          );
  }

  @override
  FutureOr<void> afterFirstLayout(BuildContext context) async {
    print('call after layout');
    final userReportProvider = Provider.of<UserReportProvider>(context, listen: false);

    await userReportProvider.getAllReport().run();
  }
}
