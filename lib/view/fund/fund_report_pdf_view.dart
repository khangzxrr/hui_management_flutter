import 'dart:typed_data';

import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:hui_management/view_models/fund_report_to_pdf_vm.dart';
import 'package:pdf/pdf.dart';
import '../../helper/utils.dart';

import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

@RoutePage()
class PdfExportReviewScreen extends StatelessWidget {
  final FundReportToPdfViewModel fundReportToPdfViewModel;

  const PdfExportReviewScreen({super.key, required this.fundReportToPdfViewModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Giấy hụi PDF'),
      ),
      body: PdfPreview(build: (format) => _generatePdf(format)),
    );
  }

  pw.Container gridTile(pw.Widget child) {
    return pw.Container(
      decoration: pw.BoxDecoration(
        border: pw.Border.all(width: 0.5),
      ),
      padding: pw.EdgeInsets.all(8.0),
      child: child,
    );
  }

  Future<Uint8List> _generatePdf(PdfPageFormat format) async {
    final pdf = pw.Document(version: PdfVersion.pdf_1_5, compress: true);
    final boldFont = await PdfGoogleFonts.robotoBlack();
    final font = await PdfGoogleFonts.robotoRegular();

    pdf.addPage(
      pw.Page(
        pageFormat: format,
        build: (context) {
          double lineCount = fundReportToPdfViewModel.nextSessionDateText.split(' ').length.toDouble() / 7;

          print(lineCount);

          final nextSessionDateRow = pw.Container(
            padding: pw.EdgeInsets.fromLTRB(10, 0, 10, 0),
            height: lineCount < 0 ? 30 : lineCount.ceilToDouble() * 30,
            child: pw.GridView(
              crossAxisCount: 2,
              children: [
                gridTile(pw.Text('Giờ khui: ', style: pw.TextStyle(font: boldFont, fontSize: 15))),
                gridTile(pw.Text(fundReportToPdfViewModel.nextSessionDateText, style: pw.TextStyle(font: boldFont, fontSize: 15), textAlign: pw.TextAlign.right)),
              ],
            ),
          );

          lineCount = fundReportToPdfViewModel.nextTakenSessionDeliveryText.split(' ').length.toDouble() / 7;

          print(lineCount);

          final nextSessionDeliveryRow = pw.Container(
            padding: pw.EdgeInsets.fromLTRB(10, 0, 10, 10),
            height: lineCount < 0 ? 30 : lineCount.ceilToDouble() * 30,
            child: pw.GridView(
              crossAxisCount: 2,
              children: [
                gridTile(pw.Text('Giờ giao hụi: ', style: pw.TextStyle(font: boldFont, fontSize: 15))),
                gridTile(pw.Text(fundReportToPdfViewModel.nextTakenSessionDeliveryText, style: pw.TextStyle(font: boldFont, fontSize: 15), textAlign: pw.TextAlign.right)),
              ],
            ),
          );

          return pw.Column(
            children: [
              pw.Text('Chủ hụi ${fundReportToPdfViewModel.ownerName}', style: pw.TextStyle(font: boldFont, fontSize: 30, color: PdfColors.red)),
              pw.SizedBox(height: 10),
              pw.Text('Địa chỉ: ${fundReportToPdfViewModel.ownerAddress}', style: pw.TextStyle(font: font, fontSize: 15)),
              pw.Text('SĐT: ${fundReportToPdfViewModel.ownerPhoneNumber}', style: pw.TextStyle(font: font, fontSize: 15)),
              pw.Text(
                'Ngân hàng: ${fundReportToPdfViewModel.ownerBankName} - ${fundReportToPdfViewModel.ownerBankAccountNumber} - ${fundReportToPdfViewModel.ownerName}',
                style: pw.TextStyle(
                  font: font,
                  fontSize: 15,
                  color: PdfColors.red,
                ),
              ),
              pw.SizedBox(height: 20),
              pw.Text('THÔNG TIN HỤI', style: pw.TextStyle(font: boldFont, fontSize: 30, color: PdfColors.red)),
              pw.Container(
                padding: pw.EdgeInsets.fromLTRB(10, 0, 10, 0),
                height: 200,
                child: pw.GridView(
                  crossAxisCount: 2,
                  children: [
                    gridTile(pw.Text('Tên hụi: ', style: pw.TextStyle(font: font, fontSize: 15))),
                    gridTile(pw.Text(fundReportToPdfViewModel.fundName, style: pw.TextStyle(font: font, fontSize: 15), textAlign: pw.TextAlign.right)),
                    gridTile(pw.Text('Ngày bắt đầu: ', style: pw.TextStyle(font: font, fontSize: 15))),
                    gridTile(pw.Text(Utils.dateFormat.format(fundReportToPdfViewModel.fundStartDate), style: pw.TextStyle(font: font, fontSize: 15), textAlign: pw.TextAlign.right)),
                    gridTile(pw.Text('Ngày kết thúc: ', style: pw.TextStyle(font: font, fontSize: 15))),
                    gridTile(pw.Text(Utils.dateFormat.format(fundReportToPdfViewModel.fundEndDate), style: pw.TextStyle(font: font, fontSize: 15), textAlign: pw.TextAlign.right)),
                    gridTile(pw.Text('Tổng phần: ', style: pw.TextStyle(font: font, fontSize: 15))),
                    gridTile(pw.Text('${fundReportToPdfViewModel.totalMemberCount} phần', style: pw.TextStyle(font: font, fontSize: 15), textAlign: pw.TextAlign.right)),
                    gridTile(pw.Text('Hoa hồng: ', style: pw.TextStyle(font: font, fontSize: 15))),
                    gridTile(pw.Text('${Utils.moneyFormat.format(fundReportToPdfViewModel.serviceCost)} đ', style: pw.TextStyle(font: font, fontSize: 15), textAlign: pw.TextAlign.right)),
                    gridTile(pw.Text('Hốt chót: ', style: pw.TextStyle(font: font, fontSize: 15))),
                    gridTile(pw.Text('${Utils.moneyFormat.format(fundReportToPdfViewModel.lastTakenAmount)} đ', style: pw.TextStyle(font: font, fontSize: 15), textAlign: pw.TextAlign.right)),
                    gridTile(pw.Text('Hình thức khui: ', style: pw.TextStyle(font: boldFont, fontSize: 15))),
                    gridTile(pw.Text(fundReportToPdfViewModel.newSessionMethodText, style: pw.TextStyle(font: boldFont, fontSize: 15), textAlign: pw.TextAlign.right)),
                  ],
                ),
              ),
              nextSessionDateRow,
              nextSessionDeliveryRow,
              pw.SizedBox(height: 20),
              pw.Text('*LƯU Ý:', style: pw.TextStyle(font: boldFont, fontSize: 20), textAlign: pw.TextAlign.left),
              pw.Text(fundReportToPdfViewModel.warningText, style: pw.TextStyle(font: font, fontSize: 10)),
              pw.Spacer(),
              pw.Text('CHÚC HỤI VIÊN PHÁT TÀI, MAY MẮN, VẠN LỘC và THÀNH CÔNG !', style: pw.TextStyle(font: boldFont, fontSize: 15, color: PdfColors.red)),
              pw.Spacer(),
              pw.Text('TRANG 1/2', style: pw.TextStyle(font: boldFont, fontSize: 10, color: PdfColors.red)),
              pw.SizedBox(height: 8),
            ],
          );
        },
      ),
    );

    final takenMemberRows = fundReportToPdfViewModel.takenMemberReportViewModels
        .map(
          (takenMember) => pw.Container(
            height: 30,
            decoration: pw.BoxDecoration(
              border: pw.Border.all(width: 0.5),
            ),
            child: pw.GridView(
              crossAxisCount: 4,
              children: [
                gridTile(pw.Text(takenMember.index.toString(), style: pw.TextStyle(font: font, fontSize: 15), textAlign: pw.TextAlign.center)),
                gridTile(pw.Text(Utils.dateFormat.format(takenMember.takenDate), style: pw.TextStyle(font: font, fontSize: 15), textAlign: pw.TextAlign.center)),
                gridTile(pw.Text(takenMember.name, style: pw.TextStyle(font: font, fontSize: 15), textAlign: pw.TextAlign.center)),
                gridTile(pw.Text(takenMember.note, style: pw.TextStyle(font: font, fontSize: 15), textAlign: pw.TextAlign.center)),
              ],
            ),
          ),
        )
        .toList();

    pdf.addPage(
      pw.Page(
        pageFormat: format,
        build: (context) {
          return pw.Column(
            children: [
              pw.Text('Danh sách hốt hụi:', style: pw.TextStyle(font: boldFont, fontSize: 20, color: PdfColors.red)),
              pw.SizedBox(height: 10),
              pw.Container(
                height: 30,
                decoration: pw.BoxDecoration(
                  border: pw.Border.all(width: 0.5),
                ),
                child: pw.GridView(
                  crossAxisCount: 4,
                  children: [
                    gridTile(pw.Text('STT', style: pw.TextStyle(font: boldFont, fontSize: 15), textAlign: pw.TextAlign.center)),
                    gridTile(pw.Text('Ngày hốt', style: pw.TextStyle(font: boldFont, fontSize: 15), textAlign: pw.TextAlign.center)),
                    gridTile(pw.Text('Tên hụi viên', style: pw.TextStyle(font: boldFont, fontSize: 15), textAlign: pw.TextAlign.center)),
                    gridTile(pw.Text('Ghi chú', style: pw.TextStyle(font: boldFont, fontSize: 15), textAlign: pw.TextAlign.center)),
                  ],
                ),
              ),
              ...takenMemberRows,
            ],
          );
        },
      ),
    );

    return pdf.save();
  }
}
