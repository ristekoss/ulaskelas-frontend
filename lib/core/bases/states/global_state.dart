part of '_states.dart';

/// Top level injection
final searchMatkul = RM.inject(
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
);

final bookmarkRM = RM.inject(
  () => BookmarkState(),
  autoDisposeWhenNotUsed: false,
);

final auth = RM.inject(
  () => AuthState(),
  autoDisposeWhenNotUsed: false,
);

final progressWebView = RM.inject(
  () => ProgressWebViewState(),
);

/// Semua state harus diinject di global state
class GlobalState {
  static List<Injectable> injectDataMocks() {
    return <Injectable>[
      Inject(() => ThemeState(
              themeData: ThemeData(
            primaryColor: BaseColors.purpleHearth,
          ))),
      Inject(() => NavigationServiceState()),
      Inject(() => FilterState()),
      Inject(() => SearchMatkulState()),
      Inject(() => ReviewState()),
      Inject(() => SearchTagState()),
      Inject(() => BookmarkState()),
    ];
  }

  static List<Injectable> injectData = <Injectable>[
    Inject(() => ThemeState()),
    Inject(() => NavigationServiceState()),
    Inject(() => FilterState()),
    Inject(() => SearchMatkulState()),
    Inject(() => ReviewState()),
    Inject(() => SearchTagState()),
    Inject(() => BookmarkState()),
  ];

  static ReactiveModel<ThemeState> theme() {
    return Injector.getAsReactive<ThemeState>();
  }

  static ReactiveModel<NavigationServiceState> navigation() {
    return Injector.getAsReactive<NavigationServiceState>();
  }
}
