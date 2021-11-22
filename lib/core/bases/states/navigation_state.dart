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
    return navigatorKey.currentState!.push<T>(MaterialPageRoute(
      builder: (_) => widget,
      settings: RouteSettings(name: routeName),
    ));
  }

  Future<T?> pushReplacement<T, K>(Widget widget, [String? routeName]) async {
    return navigatorKey.currentState!.pushReplacement<T, K>(MaterialPageRoute(
      builder: (_) => widget,
      settings: RouteSettings(name: routeName),
    ));
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

  Future<void> replaceToSsoPage() {
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

  Future<void> goToDetailMatkulPage() {
    return nav.push<void>(
      const DetailMatkulPage(),
      RouteName.mainPage,
    );
  }
}
