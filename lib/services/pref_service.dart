// Created by Muhamad Fauzi Ridwan on 24/08/21.

part of '_services.dart';

class Pref {
  static SharedPreferences? _pref;

  static Future<void> init() async {
    Logger().i('Initializing Shared Preference Service');
    _pref = await SharedPreferences.getInstance();
  }

  static Future<SharedPreferences> get instance async {
    _pref ??= await SharedPreferences.getInstance();
    return _pref!;
  }

  static Future<void> removeKey(String key) async {
    await _pref!.remove(key);
  }

  static Future<void> saveString(String key, String value) async {
    await _pref!.setString(key, value);
  }

  static String? getString(String key) {
    return _pref!.getString(key);
  }

  static Future<void> saveBool(String key, {required bool value}) async {
    await _pref!.setBool(key, value);
  }

  static bool? getBool(String key) {
    return _pref!.getBool(key);
  }

  static Future<void> saveInt(String key, int value) async {
    await _pref!.setInt(key, value);
  }

  static int? getInt(String? key) {
    return _pref!.getInt(key!);
  }

  static List<String>? getStringList(String key) {
    return _pref!.getStringList(key);
  }

  static bool containsKey(String key) {
    return _pref!.containsKey(key);
  }

  static Future<void> saveToken(String value) async {
    await _pref!.setString('ulasKelasCred', value);
  }

  static Map<String, String> getHeaders() {
    final token = getString('ulasKelasCred');
    return <String, String>{
      'Authorization': 'Token $token',
      'Content-Type': 'application/json'
    };
  }
}
