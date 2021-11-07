// Created by Muhamad Fauzi Ridwan on 23/08/21.

part of '_states.dart';

NavigationServiceState nav = GlobalState.navigation().state;

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

  Future<void> replaceToAuthenticationPage() {
    return nav.pushReplacement<void, void>(
      const AuthenticationPage(),
      RouteNameConst.authPage,
    );
  }

  Future<void> replaceToMainPage() {
    return nav.pushReplacement<void, void>(
      const MainPage(),
      RouteNameConst.mainPage,
    );
  }

  Future<void> goToForgotPassword() {
    return push(const ForgotPasswordPage());
  }

  Future<void> goToForgotPasswordResult({required String email}) {
    return push(ForgotPasswordResultPage(email: email));
  }

  Future<void> goToUserVerification() {
    return push(const UserVerificationPage());
  }

  Future<void> replaceToUploadKtp() {
    return pushReplacement<void, void>(
      const GovernmentIdUploadPage(),
      RouteNameConst.uploadKtp,
    );
  }

  Future<void> goToUploadKtp() {
    return push(
      const GovernmentIdUploadPage(),
      RouteNameConst.uploadKtp,
    );
  }

  Future<void> goToNotification() {
    return push(const NotificationPage());
  }

  // TODO: Change this
  Future<void> goToWaitingForUserValidation() {
    return push(const WaitingUserValidationPage());
  }
}
