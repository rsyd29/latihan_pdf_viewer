import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:latihan_pdf_viewer/app/modules/home/controllers/home_controller.dart';
import 'package:path/path.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

class PdfView extends StatefulWidget {
  final File file;

  const PdfView({
    Key? key,
    required this.file,
  }) : super(key: key);

  @override
  _PdfViewState createState() => _PdfViewState();
}

class _PdfViewState extends State<PdfView> {
  late PDFViewController controller;
  int pages = 0;
  int indexPage = 0;

  @override
  Widget build(BuildContext context) {
    final homeC = Get.find<HomeController>();
    final filePath = widget.file.path;
    final name = basename(filePath);
    final text = '${indexPage + 1} of $pages';

    return Scaffold(
      appBar: AppBar(
        title: Text(name),
        actions: [
          IconButton(
            onPressed: () {
              print(widget.file.path);
              homeC.shareFile(path: filePath);
            },
            icon: Icon(
              Icons.share,
            ),
          ),
        ],
      ),
      body: PDFView(
        filePath: filePath,
        swipeHorizontal: true,
        onRender: (pages) => setState(
          () => this.pages = pages!,
        ),
        onViewCreated: (controller) => setState(
          () => this.controller = controller,
        ),
        onPageChanged: (indexPage, _) => setState(
          () => this.indexPage = indexPage!,
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        height: Get.height * 0.08,
        width: double.infinity,
        color: Colors.blue,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: () {
                final page = indexPage == 0 ? pages : indexPage - 1;
                controller.setPage(page);
              },
              icon: Icon(
                Icons.arrow_back_ios_new_outlined,
                color: Colors.white,
              ),
            ),
            (pages >= 2)
                ? Text(
                    text,
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  )
                : SizedBox(),
            IconButton(
              onPressed: () {
                final page = indexPage == pages - 1 ? 0 : indexPage + 1;
                controller.setPage(page);
              },
              icon: Icon(
                Icons.arrow_forward_ios_outlined,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
