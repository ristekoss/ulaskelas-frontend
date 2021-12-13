// Created by Muhamad Fauzi Ridwan on 05/12/21.

part of '_services.dart';

class FileService {
  static Future<void> saveJson(String filename, String rawJson) async {
    if (kIsWeb) {
      return;
    }
    final dir = await getTemporaryDirectory();
    final file = File('${dir.path}/$filename');
    await file.writeAsString(rawJson);
  }

  static Future<File> getJson(String filename) async {
    final dir = await getTemporaryDirectory();
    return File('${dir.path}/$filename');
  }
}
