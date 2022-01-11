import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:html/parser.dart' show parse;
import 'package:ulaskelas/core/environment/_environment.dart';

class StoreVersionService {
  static String get _appId => Config.packageName!;
  String version = '';

  static Future<String?> _getAndroidStoreVersion(String id) async {
    final url = 'https://play.google.com/store/apps/details?id=$id';
    final response = await Dio().get(url);
    if (response.statusCode != 200) {
      print("Can't find an app in the Play Store with the id: $id");
      return null;
    }
    final document = parse(response.data);
    final elements = document.getElementsByClassName('hAyfc');
    final versionElement = elements.firstWhere(
      (elm) => elm.querySelector('.BgcNfc')?.text == 'Current Version',
    );
    final version = versionElement.querySelector('.htlgb')?.text;
    return version;
  }

  static Future<String?> _getIOSStoreVersion(String id) async {
    final url = 'https://itunes.apple.com/lookup?bundleId=$id';
    final response = await Dio().get(url);
    if (response.statusCode != 200) {
      print("Can't find an app in the App Store with the id: $id");
      return null;
    }
    final Map<String, dynamic> jsonObj = json.decode(response.data);
    final String version = jsonObj['results'][0]['version'];
    return version;
  }

  static Future<String?> getStoreVersion(BuildContext context) async {
    switch (Theme.of(context).platform) {
      case TargetPlatform.android:
        return _getAndroidStoreVersion(_appId);
      case TargetPlatform.iOS:
        return _getIOSStoreVersion(_appId);
        // ignore:no_default_cases
      default:
        print('This target platform is not yet supported by this package.');
        return null;
    }
  }
}
