import 'dart:async';
import 'dart:typed_data';

import 'package:after_layout/after_layout.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hui_management/helper/dialog.dart';
import 'package:hui_management/helper/utils.dart';
import 'package:hui_management/model/authentication_model.dart';
import 'package:hui_management/model/fund_model.dart';
import 'package:image_downloader_web/image_downloader_web.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:provider/provider.dart';

import '../../model/fund_normal_session_detail_model.dart';
import '../../model/fund_session_model.dart';
import '../../provider/authentication_provider.dart';
import '../../provider/fund_provider.dart';

import 'package:image/image.dart' as img;

@RoutePage()
class FundNormalSessionExportPdfScreen extends StatefulWidget {
  final NormalSessionDetail takenSessionDetail;
  final FundSession session;

  FundNormalSessionExportPdfScreen({super.key, required this.takenSessionDetail, required this.session});

  @override
  State<FundNormalSessionExportPdfScreen> createState() => _FundNormalSessionExportPdfScreenState();
}

class _FundNormalSessionExportPdfScreenState extends State<FundNormalSessionExportPdfScreen> with AfterLayoutMixin<FundNormalSessionExportPdfScreen> {
  Uint8List pdfBytes = Uint8List(0);
  int pageWidth = 0;
  int pageHeight = 0;

  @override
  FutureOr<void> afterFirstLayout(BuildContext context) {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Giấy giao hụi PDF'),
      ),
      body: PdfPreview(
        build: (format) async {
          final fundProvider = Provider.of<FundProvider>(context, listen: false);
          final authenticationProvider = Provider.of<AuthenticationProvider>(context, listen: false);

          final fund = fundProvider.fund;
          final owner = authenticationProvider.model!;

          final pdfBytesValue = await _generatePdf(format, fund, widget.session, widget.takenSessionDetail, owner);

          pdfBytes = pdfBytesValue;

          return pdfBytesValue;
        },
        canDebug: kDebugMode,
        allowSharing: false,
        canChangeOrientation: false,
        actions: [
          TextButton.icon(
            onPressed: () async {
              final mergedImage = img.Image(width: pageWidth, height: pageHeight);

              int posX = 0;

              await for (var page in Printing.raster(pdfBytes, pages: [0], dpi: 72)) {
                final imageBytes = await page.toPng(); // ...or page.toPng()
                final decodedImage = img.decodeImage(imageBytes);

                img.compositeImage(mergedImage, decodedImage!, dstX: posX, linearBlend: false);

                posX += decodedImage.width;
              }

              final mergedImageBytes = img.encodePng(mergedImage);

              if (kIsWeb) {
                await WebImageDownloader.downloadImageFromUInt8List(uInt8List: mergedImageBytes, name: 'giay_giao_hui.png');
              } else {
                await ImageGallerySaver.saveImage(mergedImageBytes, name: 'giay_giao_hui', quality: 100);
              }

              DialogHelper.showSnackBar(context, 'Đã tải về tệp ảnh');
            },
            label: const Text('Tải về tệp ảnh', style: TextStyle(color: Colors.white)),
            icon: const Icon(Icons.image, color: Colors.white),
          ),
        ],
        useActions: true,
      ),
    );
  }

  pw.Container gridTile(pw.Widget child) {
    return pw.Container(
      decoration: pw.BoxDecoration(
        border: pw.Border.all(width: 0.5),
      ),
      padding: const pw.EdgeInsets.all(8.0),
      child: child,
    );
  }

  Future<Uint8List> _generatePdf(
    PdfPageFormat format,
    Fund fund,
    FundSession fundSession,
    NormalSessionDetail normalSessionDetail,
    AuthenticationModel owner,
  ) async {
    final pdf = pw.Document(version: PdfVersion.pdf_1_5, compress: true);
    final boldFont = await PdfGoogleFonts.robotoBlack();
    final font = await PdfGoogleFonts.robotoRegular();

    pageHeight = format.height.toInt();
    pageWidth = format.width.toInt();

    pdf.addPage(
      pw.Page(
          pageTheme: pw.PageTheme(
            pageFormat: format,
            buildBackground: (context) => pw.FullPage(
              ignoreMargins: true,
              child: pw.Container(color: PdfColors.grey50),
            ),
          ),
          build: (context) {
            return pw.Column(
              children: [
                pw.Text('Chủ hụi: ${owner.subUser.name}', style: pw.TextStyle(font: boldFont, fontSize: 15)),
                pw.Text('Số điện thoại: ${owner.subUser.phoneNumber}', style: pw.TextStyle(font: font, fontSize: 15)),
                pw.Text('Địa chỉ: ${owner.subUser.address}', style: pw.TextStyle(font: font, fontSize: 15)),
                pw.Text('Ngân hàng: ${owner.subUser.bankName} - ${owner.subUser.bankNumber}', style: pw.TextStyle(font: font, fontSize: 15)),
                pw.Text('-----------------', style: pw.TextStyle(font: font, fontSize: 15)),
                pw.Text('GIẤY GIAO HỤI', style: pw.TextStyle(font: boldFont, fontSize: 20)),
                pw.SizedBox(height: 10),
                pw.Text('Thông tin hụi', style: pw.TextStyle(font: boldFont, fontSize: 15)),
                pw.SizedBox(
                  height: 100,
                  child: pw.GridView(
                    crossAxisCount: 2,
                    childAspectRatio: 1 / 7,
                    children: [
                      gridTile(pw.Text('Ngày mở', style: pw.TextStyle(font: font))),
                      gridTile(pw.Text(Utils.dateFormat.format(fund.openDate.toLocal()), style: pw.TextStyle(font: boldFont), textAlign: pw.TextAlign.right)),
                      gridTile(pw.Text('Dây hụi', style: pw.TextStyle(font: font))),
                      gridTile(pw.Text(fund.name, style: pw.TextStyle(font: boldFont), textAlign: pw.TextAlign.right)),
                      gridTile(pw.Text('Số phần', style: pw.TextStyle(font: font))),
                      gridTile(pw.Text(fund.membersCount.toString(), style: pw.TextStyle(font: boldFont), textAlign: pw.TextAlign.right)),
                      gridTile(pw.Text('Khui', style: pw.TextStyle(font: font))),
                      gridTile(pw.Text(fund.createSessionDurationAt(), style: pw.TextStyle(font: boldFont), textAlign: pw.TextAlign.right)),
                    ],
                  ),
                ),
                pw.SizedBox(height: 10),
                pw.Text('Thanh toán', style: pw.TextStyle(font: boldFont, fontSize: 15)),
                pw.SizedBox(
                  height: 250,
                  child: pw.GridView(
                    crossAxisCount: 2,
                    childAspectRatio: 1 / 7,
                    children: [
                      gridTile(pw.Text('Hụi viên', style: pw.TextStyle(font: font))),
                      gridTile(pw.Text(widget.takenSessionDetail.fundMember.nickName, style: pw.TextStyle(font: boldFont, color: PdfColors.red), textAlign: pw.TextAlign.right)),
                      gridTile(pw.Text('Ngày hốt', style: pw.TextStyle(font: font))),
                      gridTile(pw.Text(Utils.dateFormat.format(fundSession.takenDate), style: pw.TextStyle(font: boldFont), textAlign: pw.TextAlign.right)),
                      gridTile(pw.Text('Ngày giao', style: pw.TextStyle(font: font))),
                      gridTile(pw.Text(Utils.dateFormat.format(fundSession.takenDate), style: pw.TextStyle(font: boldFont), textAlign: pw.TextAlign.right)),
                      gridTile(pw.Text('Thăm kêu', style: pw.TextStyle(font: font))),
                      gridTile(pw.Text('${Utils.moneyFormat.format(widget.takenSessionDetail.predictedPrice)} đ', style: pw.TextStyle(font: boldFont), textAlign: pw.TextAlign.right)),
                      gridTile(pw.Text('Số kỳ: ', style: pw.TextStyle(font: font))),
                      gridTile(pw.Text(fundSession.sessionNumber.toString(), style: pw.TextStyle(font: boldFont), textAlign: pw.TextAlign.right)),
                      gridTile(pw.Text('Tổng sống + chết', style: pw.TextStyle(font: font, color: PdfColors.blue))),
                      gridTile(
                          pw.Text('${Utils.moneyFormat.format(widget.takenSessionDetail.fundAmount)} đ', style: pw.TextStyle(font: boldFont, color: PdfColors.blue), textAlign: pw.TextAlign.right)),
                      gridTile(pw.Text('Trừ thảo', style: pw.TextStyle(font: font))),
                      gridTile(pw.Text('${Utils.moneyFormat.format(widget.takenSessionDetail.serviceCost)} đ', style: pw.TextStyle(font: boldFont), textAlign: pw.TextAlign.right)),
                      gridTile(pw.Text('Còn lại', style: pw.TextStyle(font: font))),
                      gridTile(pw.Text('${Utils.moneyFormat.format(widget.takenSessionDetail.payCost)} đ', style: pw.TextStyle(font: boldFont, color: PdfColors.red), textAlign: pw.TextAlign.right)),
                    ],
                  ),
                ),
                pw.SizedBox(height: 10),
                pw.Text('Còn đóng lại ${fund.membersCount - fund.sessionsCount} phần là mãn hụi.', style: pw.TextStyle(font: boldFont, fontSize: 15)),
                pw.SizedBox(height: 40),
                pw.Row(
                  mainAxisSize: pw.MainAxisSize.max,
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text('BÊN NHẬN', style: pw.TextStyle(font: font)),
                    pw.Spacer(),
                    pw.Text('BÊN GIAO', style: pw.TextStyle(font: font)),
                  ],
                ),
                pw.SizedBox(height: 40),
                pw.Row(
                  mainAxisSize: pw.MainAxisSize.max,
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text(''),
                    pw.Spacer(),
                    pw.Text(owner.subUser.name, style: pw.TextStyle(font: boldFont)),
                  ],
                ),
              ],
            );
          }),
    );

    return pdf.save();
  }
}
