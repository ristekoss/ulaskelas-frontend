// Created by Muhamad Fauzi Ridwan on 22/11/21.

part of '_states.dart';

class AuthState {
  bool? _isLogin;
  bool? _isLoading;
  late bool isNewInstall;

  bool get isLogin => _isLogin ?? false;
  set isLogin(bool val) => _isLogin = val;

  bool get isLoading => _isLoading ?? false;
  set isLoading(bool val) => _isLoading = val;

  Future<void> initialize() async {
    // TODO(paw): check session
    _isLogin = false;
    isNewInstall = await _isNewInstall();
  }

  Future<void> ssoLogin() async {
    // TODO(paw): sso login
    // _isLogin = true;
    await nav.goToSsoWebView();
    // isLoading = false;
  }

  Future<bool> _isNewInstall() async {
    const key = 'pie';
    return !Pref.containsKey(key) || !(Pref.getBool(key) ?? true);
  }
}
