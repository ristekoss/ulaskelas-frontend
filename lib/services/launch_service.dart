import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:ristek_material_component/ristek_material_component.dart';
import 'package:ulaskelas/core/bases/states/_states.dart';
import 'package:url_launcher/url_launcher.dart';

// Please refer to https://pub.dev/packages/url_launcher

class LaunchServices {
  static Future<void> launchInBrowser(
    String urlString, {
    BuildContext? context,
  }) async {
    Logger().i('Launch Url $urlString');
    final url = Uri.parse(urlString);
    if (await canLaunchUrl(url)) {
      await launchUrl(
        url,
      );
    } else {
      ErrorMessenger('Cant launch the url').show(ctx!);
    }
  }

  static Future<void> openEmail(
    String email,
    String subject,
    String body,
  ) async {
    await launchInBrowser('mailto:$email?subject=$subject&body=$body');
  }
}
