import 'dart:io';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class HomeController extends GetxController {
  Future<File> loadNetwork(String url) async {
    Uri uri = Uri.parse(url);
    final response = await http.get(uri);
    final bytes = response.bodyBytes;

    return _storeFile(url, bytes);
  }

  Future<File> _storeFile(String url, List<int> bytes) async {
    final filename = basename(url);
    final dir = await getApplicationDocumentsDirectory();

    final file = File('${dir.path}/$filename');
    await file.writeAsBytes(bytes, flush: true);
    return file;
  }
}
