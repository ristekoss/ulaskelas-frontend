part of '_environment.dart';

class Config {
  static Flavor? appFlavor;
  static Entrypoint? appEntrypoint;
  static String? appName;
  static String? packageName;

  ///asset code base
  static String? assetsPath;
  static String? imagesPath;
  static String? iconsPath;

  static Future<void> init(
    Flavor flavor, {
    Entrypoint entrypoint = Entrypoint.splashScreen,
  }) async {
    appFlavor = flavor;
    appEntrypoint = entrypoint;
    appName = flavor.value;
    assetsPath = baseConfig.assetAbsolutePath;
    //todo grouping
    imagesPath = '${assetsPath!}/images';
    iconsPath = '${assetsPath!}/icons';

    await Firebase.initializeApp();

    ///Initialization of all services
    if (kDebugMode) {
      await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(false);
    }
    await Pref.init();
    await HiveDataBaseService.init();
    // TODO(fauzi): Implement notification plugin
    // await notificationPlugin.init();

    ///Initialize Future variables

    ///Initialize SystemUI
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.dark,
      statusBarColor: BaseColors.transparent,
    ));
  }

  static bool get isDevelopment => appFlavor == Flavor.development;
  static BaseConfig get baseConfig => _baseConfig()!;

  static BaseConfig? _baseConfig() {
    switch (appFlavor) {
      case Flavor.development:
        return const BaseConfig();
      case Flavor.production:
        return const BaseConfig();
    }
  }
}

class BaseConfig {
  const BaseConfig({this.assetAbsolutePath = Constants.assetPath});
  final String assetAbsolutePath;
}