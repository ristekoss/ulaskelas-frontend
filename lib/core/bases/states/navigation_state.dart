// Created by Muhamad Fauzi Ridwan on 23/08/21.

part of '_states.dart';

NavigationServiceState nav = GlobalState.navigation().state;
BuildContext? ctx = GlobalState.navigation().state.navigatorKey.currentContext;

abstract class Navigation {
  Future<T?> pushRoute<T>(ModalRoute<T> route, [String? routeName]);

  void pop<T>([T result]);

  void popUntil(String routeName);
}

class NavigationServiceState implements Navigation {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  Future<T?> push<T>(Widget widget, [String? routeName]) async {
    return navigatorKey.currentState!.push<T>(
      MaterialPageRoute(
        builder: (_) => widget,
        settings: RouteSettings(name: routeName),
      ),
    );
  }

  Future<T?> pushReplacement<T, K>(Widget widget, [String? routeName]) async {
    return navigatorKey.currentState!.pushReplacement<T, K>(
      MaterialPageRoute(
        builder: (_) => widget,
        settings: RouteSettings(name: routeName),
      ),
    );
  }

  @override
  Future<T?> pushRoute<T>(Route<T> route, [String? routeName]) {
    return navigatorKey.currentState!.push<T>(route);
  }

  @override
  void pop<T>([T? result]) {
    navigatorKey.currentState!.pop<T>(result);
  }

  @override
  void popUntil(String routeName) {
    navigatorKey.currentState!.popUntil(ModalRoute.withName(routeName));
  }

  bool canPop() {
    return navigatorKey.currentState!.canPop();
  }

  Future<void> replaceToSsoPage() {
    while (canPop()) {
      nav.pop();
    }
    return nav.pushReplacement<void, void>(
      const AuthenticationPage(),
      RouteName.authPage,
    );
  }

  Future<void> replaceToMainPage() {
    return nav.pushReplacement<void, void>(
      const MainPage(),
      RouteName.mainPage,
    );
  }

  Future<void> replaceToOnboardingPage() {
    return nav.pushReplacement<void, void>(
      const OnboardingPage(),
      RouteName.onboardingPage,
    );
  }

  Future<bool?> goToFilterPage() {
    return nav.push<bool>(
      const FilterPage(),
      RouteName.mainPage,
    );
  }

  Future<void> goToDetailMatkulPage(
    int courseId,
    String courseCode,
  ) {
    return nav.push<void>(
      DetailMatkulPage(
        courseId: courseId,
        courseCode: courseCode,
      ),
      RouteName.courseDetail,
    );
  }

  Future<void> goToReviewMatkulPage() {
    return nav.push<void>(
      const ReviewMatkulPage(),
      RouteName.reviewMatkul,
    );
  }

  Future<void> goToReviewMatkulFormPage({required CourseModel course}) {
    return nav.push<void>(
      ReviewMatkulFormPage(
        course: course,
      ),
      RouteName.reviewMatkulFormPage,
    );
  }

  Future<List<String>?> goToAddReviewMatkulTagPage() {
    return nav.push<List<String>>(
      const AddReviewMatkulTagPage(),
      RouteName.addReviewMatkulTagPage,
    );
  }

  Future<void> goToHomeDaftarMatkul() {
    return nav.push<void>(
      const HomeCourseListPage(),
      RouteName.homeDaftarMatkul,
    );
  }

  Future<void> goToHomeDaftarUlasan() {
    return nav.push<void>(
      const HomeDaftarUlasanPage(),
      RouteName.homeDaftarUlasan,
    );
  }

  Future<void> goToProfilePage() {
    return nav.push<void>(
      const ProfilePage(),
      RouteName.profilePage,
    );
  }

  Future<void> goToSsoWebView() {
    return nav.push<void>(
      const SSOWebPage(),
      RouteName.ssoLogin,
    );
  }

  Future<void> replaceToReviewPendingPage() {
    return nav.pushReplacement<void, void>(
      const SuccessFormPage(),
      RouteName.onboardingPage,
    );
  }

  Future<void> goToSearchCourseCalculatorPage() {
    return nav.push<void>(
      const SearchCourseCalculator(),
      RouteName.searchCourseCalculator,
    );
  }

  Future<void> goToComponentCalculatorPage({
    required int calculatorId,
    required String courseName,
    required double totalScore,
    required double totalPercentage,
  }) {
    return nav.push<void>(
      CalculatorComponentPage(
        calculatorId: calculatorId,
        courseName: courseName,
        totalScore: totalScore,
        totalPercentage: totalPercentage,
      ),
      RouteName.calculatorComponent,
    );
  }

  Future<void> goToComponentFormPage({
    required int calculatorId,
    required String courseName,
    required double totalScore,
    required double totalPercentage,
  }) {
    return nav.push<void>(
      ComponentFormPage(
        calculatorId: calculatorId,
        courseName: courseName,
        totalScore: totalScore,
        totalPercentage: totalPercentage,
      ),
      RouteName.componentFormPage,
    );
  }

  Future<void> replaceToComponentPage({
    required int calculatorId,
    required String courseName,
    required double totalScore,
    required double totalPercentage,
  }) {
    return nav.pushReplacement<void, void>(
      CalculatorComponentPage(
        calculatorId: calculatorId,
        courseName: courseName,
        totalScore: totalScore,
        totalPercentage: totalPercentage,
      ),
      RouteName.calculatorComponent,
    );
  }

  Future<void> goToEditComponentPage({
    required int id,
    required int calculatorId,
    required String courseName,
    required double totalScore,
    required double totalPercentage,
    required String componentName,
    required double componentScore,
    required double componentWeight,
  }) {
    return nav.push<void>(
      EditComponentPage(
        id: id,
        calculatorId: calculatorId,
        courseName: courseName,
        totalScore: totalScore,
        totalPercentage: totalPercentage,
        componentName: componentName,
        componentScore: componentScore,
        componentWeight: componentWeight,
      ),
      RouteName.editComponent,
    );
  }
}
