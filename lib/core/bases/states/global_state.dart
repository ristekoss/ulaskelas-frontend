part of '_states.dart';

/// Top level injection
final searchCourseRM = RM.inject(
  SearchCourseState.new,
  autoDisposeWhenNotUsed: false,
);

final filterRM = RM.inject(
  FilterState.new,
  autoDisposeWhenNotUsed: false,
);

// final reviewRM = RM.inject(
//   () => ReviewState(),
//   autoDisposeWhenNotUsed: false,
// );

final reviewFormRM = RM.inject(
  ReviewCourseFormState.new,
  autoDisposeWhenNotUsed: false,
);

final searchTagRM = RM.inject(
  SearchTagState.new,
);

final bookmarkRM = RM.inject(
  BookmarkState.new,
  autoDisposeWhenNotUsed: false,
);

final authRM = RM.inject(
  AuthState.new,
  autoDisposeWhenNotUsed: false,
);

final progressWebView = RM.inject(
  ProgressWebViewState.new,
);

final currentTermCourseRM = RM.inject(
  CurrentTermCourseState.new,
  autoDisposeWhenNotUsed: false,
);

final profileRM = RM.inject(
  ProfileState.new,
  autoDisposeWhenNotUsed: false,
);

final reviewCourseRM = RM.inject(
  ReviewCourseState.new,
  autoDisposeWhenNotUsed: false,
);

final reviewHistoryRM = RM.inject(
  ReviewHistoryState.new,
  autoDisposeWhenNotUsed: false,
);

final courseDetailRM = RM.inject(
  CourseDetailState.new,
);

final leaderboardRM = RM.inject(
      LeaderboardState.new,
);

final calculatorRM = RM.inject(
  CalculatorState.new,
);

final componentRM = RM.inject(
  ComponentState.new,
);

final componentFormRM = RM.inject(
      ComponentFormState.new,
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
      Inject(NavigationServiceState.new),
      Inject(FilterState.new),
      Inject(SearchCourseState.new),
      // Inject(() => ReviewState()),
      Inject(SearchTagState.new),
      Inject(BookmarkState.new),
      Inject(CalculatorState.new),
    ];
  }

  static List<Injectable> injectData = <Injectable>[
    Inject(ThemeState.new),
    Inject(NavigationServiceState.new),
    Inject(FilterState.new),
    Inject(SearchCourseState.new),
    // Inject(() => ReviewState()),
    Inject(SearchTagState.new),
    Inject(BookmarkState.new),
    Inject(CalculatorState.new),
  ];

  static ReactiveModel<ThemeState> theme() {
    return Injector.getAsReactive<ThemeState>();
  }

  static ReactiveModel<NavigationServiceState> navigation() {
    return Injector.getAsReactive<NavigationServiceState>();
  }
}
