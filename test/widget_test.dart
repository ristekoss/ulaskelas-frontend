import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:states_rebuilder/states_rebuilder.dart';
import 'package:ulaskelas/core/_core.dart';
import 'package:ulaskelas/main_page.dart';

typedef PumperWidget = Widget Function(Widget widget);

Widget material(Widget child) {
  return Injector(
    inject: GlobalState.injectDataMocks(),
    builder: (context) {
      return MaterialApp(
        navigatorKey: nav.navigatorKey,
        home: child,
      );
    },
  );
}

Widget scaffold({
  PreferredSizeWidget? appBar,
  Widget? child,
  Widget? botNav,
}) {
  return material(
    Scaffold(
      appBar: appBar,
      body: child,
      bottomNavigationBar: botNav,
    ),
  );
}

void main() {
  late PumperWidget widget;

  setUpAll(() async {
    widget = (Widget? child) => scaffold(
          child: Injector(
            inject: GlobalState.injectDataMocks(),
            builder: (context) {
              return child!;
            },
          ),
        );
  });

  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(widget.call(const MainPage()));
  });
}
