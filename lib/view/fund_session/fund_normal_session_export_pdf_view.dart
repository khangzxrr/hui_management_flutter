import 'dart:typed_data';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

@RoutePage()
class FundNormalSessionExportPdfScreen extends StatelessWidget {
  const FundNormalSessionExportPdfScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Giấy giao hụi PDF'),
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
            return pw.Text('hello world');
          }),
    );

    return pdf.save();
  }
}
