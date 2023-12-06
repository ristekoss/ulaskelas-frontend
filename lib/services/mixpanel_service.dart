part of '_services.dart';

class MixpanelService {
  static Mixpanel? _mixpanel;

  static Future<void> init() async {
    Logger().i('Initializing Mixpanel Service');
    _mixpanel = await Mixpanel.init(
      Secret.mixpanelToken,
      trackAutomaticEvents: true,
    );
  }

  static Future<Mixpanel> get instance async {
    return _mixpanel ??= await Mixpanel.init(
      Secret.mixpanelToken,
      trackAutomaticEvents: true,
    );
  }

  static void track(String eventName, {Map<String, String>? params}) {
    _mixpanel!.track(eventName, properties: params);
    Logger().i(
      '''
      Track Events: $eventName,
      Parameters: $params
      '''
    );
  }
}
