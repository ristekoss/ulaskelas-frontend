import 'package:flutter/material.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

import 'app.dart';
import 'core/bases/states/_states.dart';
import 'core/environment/_environment.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Config.init(Flavor.production);
  final rootWidget = Injector(
    inject: GlobalState.injectData,
    builder: (context) {
      return const App();
    },
  );
  runApp(rootWidget);
}
