import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as p;
import 'package:flutter_pdfview/flutter_pdfview.dart';

import '../../../personalization/controllers/user_controller.dart';

class TPdfPrinter extends StatelessWidget {
  const TPdfPrinter({
    super.key,
  });

  final String name = 'Phuc';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text("Create a PDF file")),
        body: Center(
          child: Builder(
            builder: (context) => Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    makepdf(context);
                  },
                  child: const Text("Create PDF"),
                ),
                SizedBox(height: 20),
                TextButton(
                  onPressed: () {
                    openPdf(context);
                  },
                  child: const Text("Open PDF"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> makepdf(BuildContext context) async {
    final pdf = p.Document();
    final controller = UserController.instance;
    pdf.addPage(
      p.Page(build: (context) {
        return p.Column(children: [
          p.Text("YOUR INFORMATION"),
          p.Text("We create emotions worth sharing!"),
          p.Text("===================================================================="),
          p.Text("= First name:    ${controller.user.value.firstName}                                                                                                          ="),
          p.Text("= Last name:    ${controller.user.value.lastName}                                                                                                         ="),
          p.Text("= Phone number:    ${controller.user.value.phoneNumber}                                                                                          ="),
          p.Text("= Email:    ${controller.user.value.email}                                                                                   ="),
          p.Text("= Username:    ${controller.user.value.username}                                                                                              ="),
          p.Text("===================================================================="),
        ]);
      }),
    );

    // Get the application documents directory.
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String appDocPath = appDocDir.path;

    // Save the PDF file in the application documents directory.
    String pdfPath = '$appDocPath/test.pdf';
    final file = File(pdfPath);
    await file.writeAsBytes(await pdf.save());
    print("PDF saved at: $pdfPath");
  }

  void openPdf(BuildContext context) async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String appDocPath = appDocDir.path;
    String pdfPath = '$appDocPath/test.pdf';

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PDFView(
          filePath: pdfPath,
        ),
      ),
    );
  }
}
