import 'package:flutter/material.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

import 'app.dart';
import 'core/bases/states/_states.dart';
import 'core/environment/_environment.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // TODO(all): duit
  await Config.init(Flavor.development);
  final rootWidget = Injector(
    inject: GlobalState.injectData,
    builder: (context) {
      return const App();
    },
  );
  // final rootWidget = kIsWeb
  //     ? Container(
  //         width: 500,
  //         constraints: const BoxConstraints(maxWidth: 500),
  //         child: Center(child: injectorWidget),
  //       )
  //     : injectorWidget;
  runApp(rootWidget);
}
