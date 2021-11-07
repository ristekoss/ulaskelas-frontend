// Created by Muhamad Fauzi Ridwan on 24/08/21.

part of '_services.dart';

class HiveDataBaseService {
  HiveDataBaseService._();

  static Future<void> init() async {
    Logger().i('Initializing Hive DB Service');
    final document = await getApplicationDocumentsDirectory();
    Hive.init(document.path);
    await Hive.openBox<dynamic>('users');
    await Hive.openBox<dynamic>('me');
  }
}
