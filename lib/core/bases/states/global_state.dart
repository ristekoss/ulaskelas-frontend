part of '_states.dart';

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

  static ReactiveModel<FilterState> filter() {
    return Injector.getAsReactive<FilterState>();
  }

  static ReactiveModel<SearchMatkulState> search() {
    return Injector.getAsReactive<SearchMatkulState>();
  }
}
