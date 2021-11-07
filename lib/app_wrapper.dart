// Created by Muhamad Fauzi Ridwan on 23/08/21.

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:houmi/core/bases/states/_states.dart';
import 'package:houmi/core/theme/_theme.dart';

class AppWrapper extends StatefulWidget {
  const AppWrapper({Key? key}) : super(key: key);

  @override
  _AppWrapperState createState() => _AppWrapperState();
}

class _AppWrapperState extends State<AppWrapper> {
  final auth = GlobalState.auth();
  final profile = GlobalState.profile();

  @override
  void initState() {
    super.initState();
    splashTime();
  }

  Future<void> splashTime() async {
    Timer(
      const Duration(milliseconds: 3000),
      () async => auth.setState((s) => s.initialize(), onData: (data) async {
        if (data.isLogin && !data.isEmailNotVerified) {
          await profile.setState((s) => s.retrieveMyProfile());
          if (!profile.state.isUserInfoVerified) {
            await auth.state.instance.signOut();
            authPageRoute();
          } else if (!profile.state.isSubmitKtp) {
            await auth.state.instance.signOut();
            authPageRoute();
          } else {
            mainPageRoute();
          }
        } else {
          authPageRoute();
        }
      }),
    );
  }

  void mainPageRoute() {
    nav.replaceToMainPage();
  }

  void authPageRoute() {
    nav.replaceToAuthenticationPage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HoumiColors.neutralWhite,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
          child: Image.asset(
            'assets/images/houmi.png',
            width: MediaQuery.of(context).size.width * .5,
          ),
        ),
      ),
    );
  }
}
