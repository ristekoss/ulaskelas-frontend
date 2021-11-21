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

final review = RM.inject(
  () => ReviewState(),
  autoDisposeWhenNotUsed: false,
);

final reviewForm = RM.inject(
  () => ReviewMatkulFormState(),
  autoDisposeWhenNotUsed: false,
);

final searchTag = RM.inject(
  () => SearchTagState(),
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
      Inject(() => ReviewState()),
      Inject(() => SearchTagState()),
    ];
  }

  static List<Injectable> injectData = <Injectable>[
    Inject(() => ThemeState()),
    Inject(() => NavigationServiceState()),
    Inject(() => FilterState()),
    Inject(() => SearchMatkulState()),
    Inject(() => ReviewState()),
    Inject(() => SearchTagState()),
  ];

  static ReactiveModel<ThemeState> theme() {
    return Injector.getAsReactive<ThemeState>();
  }

  static ReactiveModel<NavigationServiceState> navigation() {
    return Injector.getAsReactive<NavigationServiceState>();
  }
}
