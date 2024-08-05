import 'dart:io';

import 'package:path_provider/path_provider.dart';

class FileStorage {
  Future<String> get _localPath async {
    Directory? directory = await getDownloadsDirectory();

    directory ??= await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> _localFile(String fileName) async {
    final path = await _localPath;
    return File('$path/$fileName');
  }

  Future<File> writeFile(
      {required String content, required String fileName}) async {
    final file = await _localFile(fileName);

    // Write the file
    return file.writeAsString(content);
  }
}
