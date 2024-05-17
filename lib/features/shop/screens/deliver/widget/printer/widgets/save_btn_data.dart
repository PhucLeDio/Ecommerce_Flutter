import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/utils/constants/image_strings.dart';
import 'printable_data.dart';
import 'package:printing/printing.dart';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:flutter/services.dart' show rootBundle;

class SaveBtnBuilder extends StatelessWidget {
  const SaveBtnBuilder({super.key, required this.id, required this.orderDate, required this.paymentMethod, required this.deliveryDate, required this.address, required this.price});

  final String id;
  final String orderDate;
  final String paymentMethod;
  final String deliveryDate;
  final String address;
  final String price;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.indigo,
        backgroundColor: Colors.indigo,
        minimumSize: const Size(double.infinity, 56),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
      ),
      onPressed: () => printDoc(id, orderDate, paymentMethod, address, price),
      child: const Text(
        "Save as PDF",
        style: TextStyle(color: Colors.white, fontSize: 20.00),
      ),
    );
  }

  Future<void> printDoc(id, orderDate, payMethod, address, price) async {
    final image = await imageFromAssetBundle(TImages.printer);

    List<String> columnTitles = [
      "Id",
      "OrderDate",
      "PaymentMethod",
      "DeliveryDate",
      "Address",
      "Price"
    ];

    List<String> columnData = [
      id,
      orderDate,
      payMethod,
      address,
      price,
    ];

    // Load the custom font
    final fontData = await rootBundle.load('assets/fonts/Roboto-Regular.ttf');
    final fontBoldData = await rootBundle.load('assets/fonts/Roboto-Bold.ttf');
    final ttf = pw.Font.ttf(fontData);
    final ttfBold = pw.Font.ttf(fontBoldData);

    final doc = pw.Document();
    doc.addPage(pw.Page(
      pageFormat: PdfPageFormat.a4,
      build: (pw.Context context) {
        return buildPrintableData(image, ttf, ttfBold, columnData);
      },
    ));
    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => doc.save(),
    );
  }
}

buildPrintableData(image, pw.Font ttf, pw.Font ttfBold, columnData) => pw.Padding(
  padding: const pw.EdgeInsets.all(25.00),
  child: pw.Column(
    children: [
      pw.Text("Hoang - Phuc",
          style: pw.TextStyle(font: ttfBold, fontSize: 25.00, fontWeight: pw.FontWeight.bold)),
      pw.SizedBox(height: 10.00),
      pw.Divider(),
      pw.Align(
        alignment: pw.Alignment.center,
        child: pw.Image(
          image,
          width: 250,
          height: 250,
        ),
      ),
      pw.Column(
        children: [
          pw.Row(
            crossAxisAlignment: pw.CrossAxisAlignment.end,
            children: [
              pw.SizedBox(width: 5.5),
              pw.Text(
                "Invoice",
                style: pw.TextStyle(font: ttfBold, fontSize: 23.00, fontWeight: pw.FontWeight.bold),
              )
            ],
          ),
          pw.SizedBox(height: 10.00),
          pw.Container(
            color: const PdfColor(0.5, 1, 0.5, 0.7),
            width: double.infinity,
            height: 36.00,
            child: pw.Center(
              child: pw.Text(
                "Approvals",
                style: pw.TextStyle(
                    color: const PdfColor(0.2, 0.6, 0.2, 0.7),
                    font: ttfBold,
                    fontSize: 20.00,
                    fontWeight: pw.FontWeight.bold),
              ),
            ),
          ),
          for (var i = 0; i < 6; i++)
            pw.Container(
              color: i % 2 != 0
                  ? const PdfColor(0.9, 0.9, 0.9, 0.6)
                  : const PdfColor(1, 1, 1, 0.1),
              width: double.infinity,
              height: 36.00,
              child: pw.Padding(
                padding: const pw.EdgeInsets.symmetric(horizontal: 25.0),
                child: pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    i == 5 ? pw.Text("Tax", style: pw.TextStyle(font: ttfBold, fontSize: 18.00, fontWeight: pw.FontWeight.bold),) : pw.Text(columnTitles[i], style: pw.TextStyle(font: ttfBold, fontSize: 18.00, fontWeight: pw.FontWeight.bold), softWrap: true, maxLines: 2, overflow: pw.TextOverflow.visible),
                    i == 5 ? pw.Text("\$ 0.00", style: pw.TextStyle(font: ttf, fontSize: 18.00, fontWeight: pw.FontWeight.normal),) : pw.Text(columnData[i], style: pw.TextStyle(font: ttf, fontSize: 18.00, fontWeight: pw.FontWeight.normal), softWrap: true, maxLines: 2, overflow: pw.TextOverflow.visible),
                  ],
                ),
              ),
            ),
          pw.Padding(
            padding: const pw.EdgeInsets.symmetric(horizontal: 25.0),
            child: pw.Container(
              width: double.infinity,
              height: 36.00,
              child: pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.end,
                children: [
                  pw.Text(
                    columnData[4],
                    style: pw.TextStyle(
                      font: ttfBold,
                      fontSize: 22.00,
                      fontWeight: pw.FontWeight.bold,
                      color: const PdfColor(0.2, 0.6, 0.2, 0.7),
                    ),
                  ),
                ],
              ),
            ),
          ),
          pw.SizedBox(height: 15.00),
          pw.Text(
            "Thanks for choosing our service!",
            style: pw.TextStyle(
                font: ttf,
                color: PdfColor(0.5, 0.5, 0.5, 0.5), fontSize: 15.00),
          ),
          pw.SizedBox(height: 5.00),
          pw.Text(
            "Contact the branch for any clarifications.",
            style: pw.TextStyle(
                font: ttf,
                color: PdfColor(0.5, 0.5, 0.5, 0.5), fontSize: 15.00),
          ),
          pw.SizedBox(height: 15.00),
        ],
      ),
    ],
  ),
);
