import 'dart:async';

import 'package:auto_route/annotations.dart';
import 'package:file_saver/file_saver.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hui_management/view_models/fund_report_to_pdf_vm.dart';
import 'package:image_downloader_web/image_downloader_web.dart';
import 'package:pdf/pdf.dart';
import '../../helper/utils.dart';

import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import 'package:image/image.dart' as img;

@RoutePage()
class PdfExportReviewScreen extends StatefulWidget {
  final FundReportToPdfViewModel fundReportToPdfViewModel;

  const PdfExportReviewScreen({super.key, required this.fundReportToPdfViewModel});

  @override
  State<PdfExportReviewScreen> createState() => _PdfExportReviewScreenState();
}

class _PdfExportReviewScreenState extends State<PdfExportReviewScreen> {
  Uint8List _pdfBytes = Uint8List(0);

  double pageWidth = 0;
  double pageHeight = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Xem trước giấy hụi'),
      ),
      body: PdfPreview(build: (format) async {
        final generatedPdfBytes = await _generatePdf(format);

        setState(() {
          _pdfBytes = generatedPdfBytes;
        });

        return generatedPdfBytes;
      }),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton.icon(
              onPressed: () async {
                double width = pageWidth * 2; //2 page
                double height = pageHeight;

                final mergedImage = img.Image(width: width.toInt(), height: height.toInt());

                int posX = 0;

                await for (var page in Printing.raster(_pdfBytes, pages: [0, 1], dpi: 72)) {
                  final imageBytes = await page.toPng(); // ...or page.toPng()
                  final decodedImage = img.decodeImage(imageBytes);

                  img.compositeImage(mergedImage, decodedImage!, dstX: posX, linearBlend: false);

                  posX += decodedImage.width;
                }

                final mergedImageBytes = img.encodePng(mergedImage);

                if (kIsWeb) {
                  await WebImageDownloader.downloadImageFromUInt8List(uInt8List: mergedImageBytes, name: 'giay_hui.png');
                } else {
                  await FileSaver.instance.saveAs(name: 'giay_hui', ext: 'png', mimeType: MimeType.png, bytes: mergedImageBytes);
                }
              },
              label: const Text('Tải về tệp ảnh'),
              icon: const Icon(Icons.image),
            ),
          ],
        ),
      ),
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

    setState(() {
      pageWidth = format.width;
      pageHeight = format.height;
    });

    pdf.addPage(
      pw.Page(
        pageFormat: format,
        build: (context) {
          double lineCount = widget.fundReportToPdfViewModel.nextSessionDateText.split(' ').length.toDouble() / 7;

          print(lineCount);

          final nextSessionDateRow = pw.Container(
            padding: pw.EdgeInsets.fromLTRB(10, 0, 10, 0),
            height: lineCount < 0 ? 30 : lineCount.ceilToDouble() * 30,
            child: pw.GridView(
              crossAxisCount: 2,
              children: [
                gridTile(pw.Text('Giờ khui: ', style: pw.TextStyle(font: boldFont, fontSize: 15))),
                gridTile(pw.Text(widget.fundReportToPdfViewModel.nextSessionDateText, style: pw.TextStyle(font: boldFont, fontSize: 15), textAlign: pw.TextAlign.right)),
              ],
            ),
          );

          lineCount = widget.fundReportToPdfViewModel.nextTakenSessionDeliveryText.split(' ').length.toDouble() / 7;

          print(lineCount);

          final nextSessionDeliveryRow = pw.Container(
            padding: pw.EdgeInsets.fromLTRB(10, 0, 10, 10),
            height: lineCount < 0 ? 30 : lineCount.ceilToDouble() * 40,
            child: pw.GridView(
              crossAxisCount: 2,
              children: [
                gridTile(pw.Text('Giờ giao hụi: ', style: pw.TextStyle(font: boldFont, fontSize: 15))),
                gridTile(pw.Text(widget.fundReportToPdfViewModel.nextTakenSessionDeliveryText, style: pw.TextStyle(font: boldFont, fontSize: 15), textAlign: pw.TextAlign.right)),
              ],
            ),
          );

          return pw.Column(
            children: [
              pw.Text('Chủ hụi ${widget.fundReportToPdfViewModel.ownerName}', style: pw.TextStyle(font: boldFont, fontSize: 30, color: PdfColors.red)),
              pw.SizedBox(height: 10),
              pw.Text('Địa chỉ: ${widget.fundReportToPdfViewModel.ownerAddress}', style: pw.TextStyle(font: font, fontSize: 15)),
              pw.Text('SĐT: ${widget.fundReportToPdfViewModel.ownerPhoneNumber}', style: pw.TextStyle(font: font, fontSize: 15)),
              pw.Text(
                'Ngân hàng: ${widget.fundReportToPdfViewModel.ownerBankName} - ${widget.fundReportToPdfViewModel.ownerBankAccountNumber} - ${widget.fundReportToPdfViewModel.ownerName}',
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
                    gridTile(pw.Text(widget.fundReportToPdfViewModel.fundName, style: pw.TextStyle(font: font, fontSize: 15), textAlign: pw.TextAlign.right)),
                    gridTile(pw.Text('Ngày bắt đầu: ', style: pw.TextStyle(font: font, fontSize: 15))),
                    gridTile(pw.Text(Utils.dateFormat.format(widget.fundReportToPdfViewModel.fundStartDate), style: pw.TextStyle(font: font, fontSize: 15), textAlign: pw.TextAlign.right)),
                    gridTile(pw.Text('Ngày kết thúc: ', style: pw.TextStyle(font: font, fontSize: 15))),
                    gridTile(pw.Text(Utils.dateFormat.format(widget.fundReportToPdfViewModel.fundEndDate), style: pw.TextStyle(font: font, fontSize: 15), textAlign: pw.TextAlign.right)),
                    gridTile(pw.Text('Tổng phần: ', style: pw.TextStyle(font: font, fontSize: 15))),
                    gridTile(pw.Text('${widget.fundReportToPdfViewModel.totalMemberCount} phần', style: pw.TextStyle(font: font, fontSize: 15), textAlign: pw.TextAlign.right)),
                    gridTile(pw.Text('Hoa hồng: ', style: pw.TextStyle(font: font, fontSize: 15))),
                    gridTile(pw.Text('${Utils.moneyFormat.format(widget.fundReportToPdfViewModel.serviceCost)} đ', style: pw.TextStyle(font: font, fontSize: 15), textAlign: pw.TextAlign.right)),
                    gridTile(pw.Text('Hốt chót: ', style: pw.TextStyle(font: font, fontSize: 15))),
                    gridTile(pw.Text('${Utils.moneyFormat.format(widget.fundReportToPdfViewModel.lastTakenAmount)} đ', style: pw.TextStyle(font: font, fontSize: 15), textAlign: pw.TextAlign.right)),
                    gridTile(pw.Text('Hình thức khui: ', style: pw.TextStyle(font: boldFont, fontSize: 15))),
                    gridTile(pw.Text(widget.fundReportToPdfViewModel.newSessionMethodText, style: pw.TextStyle(font: boldFont, fontSize: 15), textAlign: pw.TextAlign.right)),
                  ],
                ),
              ),
              nextSessionDateRow,
              nextSessionDeliveryRow,
              pw.SizedBox(height: 20),
              pw.Text('*LƯU Ý:', style: pw.TextStyle(font: boldFont, fontSize: 20), textAlign: pw.TextAlign.left),
              pw.Text(widget.fundReportToPdfViewModel.warningText, style: pw.TextStyle(font: font, fontSize: 10)),
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

    final takenMemberRows = widget.fundReportToPdfViewModel.takenMemberReportViewModels
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
