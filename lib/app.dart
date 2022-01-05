// Created by Muhamad Fauzi Ridwan on 23/08/21.

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';
import 'package:states_rebuilder/states_rebuilder.dart';
import 'package:ulaskelas/app_wrapper.dart';
import 'package:ulaskelas/core/bases/states/_states.dart';
import 'package:ulaskelas/core/constants/_constants.dart';

FirebaseAnalytics analytics = FirebaseAnalytics();

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StateBuilder<ThemeState>(
      observeMany: const [
        GlobalState.theme,
        GlobalState.navigation,
      ],
      initState: (_, __) => __?.setState((s) => s.init()),
      builder: (context, snapshot) {
        return MaterialApp(
          title: Constants.ulaskelas,
          navigatorKey: nav.navigatorKey,
          debugShowCheckedModeBanner: false,
          theme: GlobalState.theme().state.type,
          navigatorObservers: [
            FirebaseAnalyticsObserver(analytics: analytics),
          ],
          home: const AppWrapper(),
          routes: {
            '/callback': (context) => Scaffold(
                  body: Container(),
                ),
          },
        );
      },
    );
  }
}
