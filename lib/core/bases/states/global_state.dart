part of '_states.dart';

/// Top level injection
final searchCourseRM = RM.inject(
  () => SearchCourseState(),
  autoDisposeWhenNotUsed: false,
);

final filterRM = RM.inject(
  () => FilterState(),
  autoDisposeWhenNotUsed: false,
);

// final reviewRM = RM.inject(
//   () => ReviewState(),
//   autoDisposeWhenNotUsed: false,
// );

final reviewFormRM = RM.inject(
  () => ReviewCourseFormState(),
  autoDisposeWhenNotUsed: false,
);

final searchTagRM = RM.inject(
  () => SearchTagState(),
);

final bookmarkRM = RM.inject(
  () => BookmarkState(),
  autoDisposeWhenNotUsed: false,
);

final authRM = RM.inject(
  () => AuthState(),
  autoDisposeWhenNotUsed: false,
);

final progressWebView = RM.inject(
  () => ProgressWebViewState(),
);

final currentTermCourseRM = RM.inject(
  () => CurrentTermCourseState(),
  autoDisposeWhenNotUsed: false,
);

final profileRM = RM.inject(
  () => ProfileState(),
  autoDisposeWhenNotUsed: false,
);

final reviewCourseRM = RM.inject(
  () => ReviewCourseState(),
  autoDisposeWhenNotUsed: false,
);

final reviewHistoryRM = RM.inject(
  () => ReviewHistoryState(),
  autoDisposeWhenNotUsed: false,
);

final courseDetailRM = RM.inject(
  () => CourseDetailState(),
);

final leaderboardRM = RM.inject(
      () => LeaderboardState(),
);

final calculatorRM = RM.inject(
  () => CalculatorState(),
);

final componentRM = RM.inject(
  () => ComponentState(),
);

final componentFormRM = RM.inject(
      () => ComponentFormState(),
  autoDisposeWhenNotUsed: false,
);

/// Semua state harus diinject di global state
class GlobalState {
  static List<Injectable> injectDataMocks() {
    return <Injectable>[
      Inject(
        () => ThemeState(
          themeData: ThemeData(
            primaryColor: BaseColors.purpleHearth,
          ),
        ),
      ),
      Inject(() => NavigationServiceState()),
      Inject(() => FilterState()),
      Inject(() => SearchCourseState()),
      // Inject(() => ReviewState()),
      Inject(() => SearchTagState()),
      Inject(() => BookmarkState()),
      Inject(() => CalculatorState()),
    ];
  }

  static List<Injectable> injectData = <Injectable>[
    Inject(() => ThemeState()),
    Inject(() => NavigationServiceState()),
    Inject(() => FilterState()),
    Inject(() => SearchCourseState()),
    // Inject(() => ReviewState()),
    Inject(() => SearchTagState()),
    Inject(() => BookmarkState()),
    Inject(() => CalculatorState()),
  ];

  static ReactiveModel<ThemeState> theme() {
    return Injector.getAsReactive<ThemeState>();
  }

  static ReactiveModel<NavigationServiceState> navigation() {
    return Injector.getAsReactive<NavigationServiceState>();
  }
}
