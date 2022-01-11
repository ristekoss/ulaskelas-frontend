// Created by Muhamad Fauzi Ridwan on 23/08/21.

import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ristek_material_component/ristek_material_component.dart';
import 'package:ulaskelas/core/_core.dart';
import 'package:ulaskelas/core/bases/widgets/confirmation_modal_dialog.dart';
import 'package:ulaskelas/core/theme/_theme.dart';
import 'package:ulaskelas/services/launch_service.dart';
import 'package:ulaskelas/services/versioning/check_version.dart';

import 'core/environment/_environment.dart';

class AppWrapper extends StatefulWidget {
  const AppWrapper({Key? key}) : super(key: key);

  @override
  _AppWrapperState createState() => _AppWrapperState();
}

class _AppWrapperState extends State<AppWrapper> {
  // TODO(pawpaw): Auth and profile state

  @override
  void initState() {
    super.initState();
    splashTime();
  }

  Future<void> splashTime() async {
    Timer(
      const Duration(milliseconds: 2500),
      () async {
        final forceUpdate = await canUpdate(context);
        if (!forceUpdate) {
          final confirm = await const ConfirmationModalDialog(
            title: 'title',
            description: '''
A new version of this app available on the store, please update into the newer version\n''',
            yesLabel: 'Update',
            noLabel: 'Later',
            type: ConfirmationModalDialogType.warning,
          ).show();
          if (confirm ?? false) {
            final url = Platform.isAndroid
                ? 'https://play.google.com/store/apps/details?id=${Config.packageName}'
                : Platform.isIOS
                    ? 'https://itunes.apple.com/lookup?bundleId=${Config.packageName}'
                    : '';
            await LaunchServices.launchInBrowser(url);
          } else {
            await SystemNavigator.pop(animated: true);
          }
          return;
        }
        await authRM.state.initialize();
        if (authRM.state.isLogin) {
          if (profileRM.state.profile.isBlocked ?? false) {
            ErrorMessenger('Your account is blocked').show(ctx!);
            ssoPageRoute();
            return;
          }
          mainPageRoute();
        } else if (authRM.state.isNewInstall) {
          onboardingPageRoute();
        } else {
          ssoPageRoute();
        }
      },
    );
  }

  void ssoPageRoute() {
    nav.replaceToSsoPage();
  }

  void mainPageRoute() {
    nav.replaceToMainPage();
  }

  void onboardingPageRoute() {
    nav.replaceToOnboardingPage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BaseColors.purpleHearth,
      body: Stack(
        children: [
          Center(
            child: Image.asset(
              '${Constants.imagePath}/logo_splash.png',
              width: 160,
              height: 160,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  RichText(
                    text: TextSpan(
                      text: 'Ulas',
                      style: FontTheme.poppins20w700white(),
                      children: const <TextSpan>[
                        TextSpan(
                          text: 'Kelas',
                          style: TextStyle(
                            color: BaseColors.malibu,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    'by RISTEK Fasilkom UI',
                    style: FontTheme.poppins14w500white(),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
