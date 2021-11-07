// Created by Muhamad Fauzi Ridwan on 23/08/21.

import 'dart:async';

import 'package:flutter/material.dart';
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
    // TODO(adit): comment this timer to start modify the splash screen content
    Timer(
      const Duration(milliseconds: 3000),
      () async => ssoPageRoute(),
    );
  }

  void ssoPageRoute() {
    nav.replaceToSsoPage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BaseColors.white,
      // TODO(adit): splash screen content
      body: Container(),
    );
  }
}
