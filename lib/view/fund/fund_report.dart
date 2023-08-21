import 'dart:async';

import 'package:after_layout/after_layout.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:hui_management/helper/utils.dart';
import 'package:hui_management/provider/authentication_provider.dart';
import 'package:hui_management/routes/app_route.dart';
import 'package:hui_management/view_models/fund_report_to_pdf_vm.dart';
import 'package:hui_management/view_models/taken_member_report_vm.dart';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:provider/provider.dart';

import '../../provider/fund_provider.dart';

@RoutePage()
class FundReportScreen extends StatefulWidget {
  const FundReportScreen({super.key});

  @override
  State<FundReportScreen> createState() => _FundReportScreenState();
}

class GridItem extends StatelessWidget {
  final Widget child;
  const GridItem({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(border: Border.all(color: Colors.black, width: 0.2)),
      padding: const EdgeInsets.all(8),
      child: child,
    );
  }
}

class _FundReportScreenState extends State<FundReportScreen> with AfterLayoutMixin<FundReportScreen> {
  Map<String, String> replacebleText = {
    'takenSessionText': '',
    'newSessionText': '',
    'newSessionMethodText': '',
    'warningText': '',
  };

  List<TakenMemberReportViewModel> takenMemberReportViewModels = [];

  @override
  FutureOr<void> afterFirstLayout(BuildContext context) {
    final fundProvider = Provider.of<FundProvider>(context, listen: false);

    setState(() {
      replacebleText['takenSessionText'] = 'Giao vào mỗi ngày 0 kể từ lúc bắt đầu';
      replacebleText['newSessionText'] = 'Khui vào mỗi ngày 0 kể từ lúc bắt đầu';
      replacebleText['newSessionMethodText'] = 'Mở thăm trực tiếp hoặc online';
      replacebleText['warningText'] = '1. Hụi viên đóng hụi ngày 05 & 06, không đóng trễ nhiều lần.\n2. Nếu hụi sống muống ngưng ngang hoặc đóng trễ quá 5 ngày sẽ được thói hụi sau khi trừ lời hụi và hoa hồng.\n3. Nếu hụi chết đóng trễ quá 7 ngày sẽ được công khai hụi trễ lên các group hụi & tính lãi suất bằng ngân hàng.\n4. Nếu có tình hình dịch hay lí do gì về kinh tế cả nước nên hụi viên muốn ngưng hụi thì phải theo biểu quyết của các hụi viên còn sống\n5.Hụi viên có số âm hụi nhiều thì chủ hụi được quyền yêu cầu đóng mãn dây khi hốt.\n6.Không so sánh lịch giao hụi với nơi khác!';

      takenMemberReportViewModels = fundProvider.fund.sessions.asMap().entries.map((s) {
        final takenSession = s.value.normalSessionDetails.where((nsd) => nsd.type == 'Taken').first;
        final takenMemberReportVM = TakenMemberReportViewModel(
          index: s.key + 1,
          name: takenSession.fundMember.subUser.nickName,
          note: '',
          takenDate: s.value.takenDate,
        );

        return takenMemberReportVM;
      }).toList();
    });
  }

  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    final fundProvider = Provider.of<FundProvider>(context, listen: false);
    final authenticationProvider = Provider.of<AuthenticationProvider>(context, listen: false);

    final fund = fundProvider.fund;

    final authenticationModel = authenticationProvider.model!;

    final takenSessionColumns = [
      PlutoColumn(title: 'STT', field: 'index', type: PlutoColumnType.text(), enableEditingMode: false, minWidth: 50, width: 60),
      PlutoColumn(title: 'Ngày khui hụi', field: 'takenDate', type: PlutoColumnType.text(), enableEditingMode: false, width: 100),
      PlutoColumn(title: 'Tên hụi viên', field: 'takenBy', type: PlutoColumnType.text(), enableEditingMode: false, width: 100),
      PlutoColumn(title: 'Ghi chú', field: 'note', type: PlutoColumnType.text(), enableEditingMode: true),
    ];

    final takenSessionMemberRows = fundProvider.fund.sessions.asMap().entries.map((s) {
      final takenSession = s.value.normalSessionDetails.where((nsd) => nsd.type == 'Taken').first;

      return PlutoRow(
        cells: {
          'index': PlutoCell(value: s.key + 1),
          'takenDate': PlutoCell(value: Utils.dateFormat.format(s.value.takenDate)),
          'takenBy': PlutoCell(value: takenSession.fundMember.nickName),
          'note': PlutoCell(value: ''),
        },
      );
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Giấy hụi'),
      ),
      body: FormBuilder(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FormBuilderTextField(
                    name: 'fundOwnerName',
                    decoration: const InputDecoration(labelText: 'Tên chủ hụi'),
                    initialValue: authenticationModel.subUser.name,
                    readOnly: true,
                  ),
                  FormBuilderTextField(
                    name: 'fundOwnerAddress',
                    decoration: const InputDecoration(labelText: 'Địa chỉ'),
                    initialValue: authenticationModel.subUser.address,
                    readOnly: true,
                  ),
                  FormBuilderTextField(
                    name: 'fundOwnerPhoneNumber',
                    decoration: const InputDecoration(labelText: 'SĐT'),
                    initialValue: authenticationModel.subUser.phoneNumber,
                    readOnly: true,
                  ),
                  FormBuilderTextField(
                    name: 'fundOwnerBankName',
                    decoration: const InputDecoration(labelText: 'Ngân hàng'),
                    initialValue: authenticationModel.subUser.bankName,
                    readOnly: true,
                  ),
                  FormBuilderTextField(
                    name: 'fundOwnerBankAccountNumber',
                    decoration: const InputDecoration(labelText: 'Số tài khoản'),
                    initialValue: authenticationModel.subUser.bankNumber,
                    readOnly: true,
                  ),
                  FormBuilderTextField(
                    name: 'fundName',
                    decoration: const InputDecoration(labelText: 'Tên hụi'),
                    initialValue: fund.name,
                    readOnly: true,
                  ),
                  FormBuilderTextField(
                    name: 'fundStartDate',
                    decoration: const InputDecoration(labelText: 'Ngày bắt đầu'),
                    initialValue: Utils.dateFormat.format(fund.openDate),
                    readOnly: true,
                  ),
                  FormBuilderTextField(
                    name: 'fundEndDate',
                    decoration: const InputDecoration(labelText: 'Ngày kết thúc'),
                    initialValue: '0',
                    readOnly: true,
                  ),
                  FormBuilderTextField(
                    name: 'fundTotalMemberCount',
                    decoration: const InputDecoration(labelText: 'Tổng phần'),
                    initialValue: fund.membersCount.toString(),
                    readOnly: true,
                  ),
                  FormBuilderTextField(
                    name: 'fundServiceCost',
                    decoration: const InputDecoration(labelText: 'Hoa hồng'),
                    initialValue: Utils.moneyFormat.format(fund.serviceCost),
                    readOnly: true,
                  ),
                  FormBuilderTextField(
                    name: 'fundLastTakenAmount',
                    decoration: const InputDecoration(labelText: 'Hốt chót'),
                    initialValue: '0',
                    readOnly: true,
                  ),
                  FormBuilderTextField(
                    name: 'fundNextTakenSessionDateText',
                    decoration: const InputDecoration(labelText: '*Giờ khui hụi'),
                    initialValue: replacebleText['newSessionText']!,
                    onChanged: (value) => setState(() {
                      replacebleText['newSessionText'] = value!;
                    }),
                  ),
                  FormBuilderTextField(
                    name: 'fundNextTakenSessionDeliveryText',
                    decoration: const InputDecoration(labelText: '*Giờ giao hụi'),
                    initialValue: replacebleText['takenSessionText']!,
                    onChanged: (value) => setState(() {
                      replacebleText['takenSessionText'] = value!;
                    }),
                  ),
                  FormBuilderTextField(
                    name: 'fundNextTakenSessionMethodText',
                    decoration: const InputDecoration(labelText: '*Hình thức khui'),
                    initialValue: replacebleText['newSessionMethodText']!,
                    onChanged: (value) => setState(() {
                      replacebleText['newSessionMethodText'] = value!;
                    }),
                  ),
                  FormBuilderTextField(
                    name: 'warningText',
                    maxLines: 7,
                    decoration: const InputDecoration(labelText: '*Lưu ý'),
                    initialValue: replacebleText['warningText']!,
                    onChanged: (value) => setState(() {
                      replacebleText['warningText'] = value!;
                    }),
                  ),
                  const SizedBox(height: 8),
                  const Text('Danh sách hốt:'),
                  Container(
                    height: 60 * (takenSessionMemberRows.length + 1),
                    child: PlutoGrid(
                      columns: takenSessionColumns,
                      rows: takenSessionMemberRows,
                      onChanged: (event) {
                        int index = int.parse(event.row.cells['index']!.value.toString()) - 1;

                        setState(() {
                          takenMemberReportViewModels[index].note = event.row.cells['note']!.value.toString();
                        });
                      },
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(8),
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: () {
                          final fundReportToPdfViewModel = FundReportToPdfViewModel(
                            ownerName: authenticationModel.subUser.name,
                            ownerAddress: authenticationModel.subUser.address,
                            ownerPhoneNumber: authenticationModel.subUser.phoneNumber,
                            ownerBankName: authenticationModel.subUser.bankName,
                            ownerBankAccountNumber: authenticationModel.subUser.bankNumber,
                            fundName: fund.name,
                            fundStartDate: fund.openDate,
                            //remember to edit this shit
                            fundEndDate: fund.openDate,
                            totalMemberCount: fund.membersCount,
                            serviceCost: fund.serviceCost,
                            lastTakenAmount: 0,
                            nextSessionDateText: replacebleText['takenSessionText']!,
                            nextTakenSessionDeliveryText: replacebleText['newSessionText']!,
                            newSessionMethodText: replacebleText['newSessionMethodText']!,
                            warningText: replacebleText['warningText']!,
                            takenMemberReportViewModels: takenMemberReportViewModels,
                          );

                          context.router.push(PdfExportReviewRoute(fundReportToPdfViewModel: fundReportToPdfViewModel));
                        },
                        child: const Text('Xuất PDF')),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
