import 'dart:io';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:latihan_pdf_viewer/app/modules/home/views/pdf_view.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HomeView'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {},
              child: Text('Asset PDF'),
            ),
            ElevatedButton(
              onPressed: () async {
                final file = await controller.pickFile();
                if (file == null) return;
                openPDF(context, file);
              },
              child: Text('File PDF'),
            ),
            ElevatedButton(
              onPressed: () async {
                final url =
                    'https://www.tutorialspoint.com/flutter/flutter_tutorial.pdf';
                final file = await controller.loadNetwork(url);
                openPDF(context, file);
              },
              child: Text('Network PDF'),
            ),
          ],
        ),
      ),
    );
  }

  void openPDF(BuildContext context, File file) => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => PdfView(file: file),
        ),
      );
}
