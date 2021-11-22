part of '_states.dart';

/// Top level injection
final search = RM.inject(
  () => SearchMatkulState(),
  autoDisposeWhenNotUsed: false,
);

final filter = RM.inject(
  () => FilterState(),
  autoDisposeWhenNotUsed: false,
);

final auth = RM.inject(
  () => AuthState(),
  autoDisposeWhenNotUsed: false,
);

/// Semua state harus diinject di global state
class GlobalState {
  static List<Injectable> injectDataMocks() {
    return <Injectable>[
      Inject(() => ThemeState(
              themeData: ThemeData(
            primaryColor: BaseColors.purpleHearth,
            accentColor: BaseColors.goldenrod,
          ))),
      Inject(() => NavigationServiceState()),
      Inject(() => FilterState()),
      Inject(() => SearchMatkulState()),
    ];
  }

  static List<Injectable> injectData = <Injectable>[
    Inject(() => ThemeState()),
    Inject(() => NavigationServiceState()),
    Inject(() => FilterState()),
    Inject(() => SearchMatkulState()),
  ];

  static ReactiveModel<ThemeState> theme() {
    return Injector.getAsReactive<ThemeState>();
  }

  static ReactiveModel<NavigationServiceState> navigation() {
    return Injector.getAsReactive<NavigationServiceState>();
  }
}
