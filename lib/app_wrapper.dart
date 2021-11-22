// Created by Muhamad Fauzi Ridwan on 23/08/21.

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ulaskelas/core/_core.dart';
import 'package:ulaskelas/core/bases/states/_states.dart';
import 'package:ulaskelas/core/theme/_theme.dart';

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
        await auth.state.initialize();
        if (auth.state.isLogin) {
          mainPageRoute();
        } else if (auth.state.isNewInstall) {
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
                              )),
                        ]),
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
