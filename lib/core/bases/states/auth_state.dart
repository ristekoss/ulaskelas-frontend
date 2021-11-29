// Created by Muhamad Fauzi Ridwan on 22/11/21.

part of '_states.dart';

class AuthState {
  bool? _isLogin;
  bool? _isLoading;
  WindowBase? _popupWin;
  late bool isNewInstall;

  bool get isLogin => _isLogin ?? false;
  set isLogin(bool val) => _isLogin = val;

  bool get isLoading => _isLoading ?? false;
  set isLoading(bool val) => _isLoading = val;

  Future<void> initialize() async {
    isNewInstall = await _isNewInstall();
    _isLogin = await _hasToken();
  }

  Future<void> ssoLogin() async {
    if (kIsWeb) {
      final currentUri = Uri.base;

      final redirectUri = Uri(
        host: currentUri.host,
        scheme: currentUri.scheme,
        port: currentUri.port,
        path: '/static.html',
      );

      final url = '${Endpoints.sso}/?redirect_url=${redirectUri.toString()}';
      Logger().w(Uri.parse(url).query);

      Logger().w(redirectUri.toString());
      _popupWin = window.open(
        url,
        'Sso Auth',
        'width=800, height=900, scrollbars=yes',
      );

      window.onMessage.listen((event) {
        /// If the event contains the token it means the user is authenticated.
        Logger().i(event.data.toString());
        if (event.data.toString().contains('token=')) {
          _login(event.data);
        }
      });
    } else {
      await nav.goToSsoWebView();
    }
  }

  Future<bool> _isNewInstall() async {
    const key = PreferencesKeys.onBoard;
    return !Pref.containsKey(key);
  }

  Future<bool> _hasToken() async {
    const key = PreferencesKeys.ulasKelasCred;
    return Pref.containsKey(key);
  }

  void _login(String data) {
    /// Parse data into an Uri to extract the token easily.
    final receivedUri = Uri.parse(data);

    /// authentication service it might be contained in another
    /// property of your Uri.

    final params = receivedUri.queryParameters;
    for (final param in params.entries) {
      if (param.key == 'token') {
        Pref.saveToken(param.value);
      } else if (param.key == 'username') {
        Pref.saveString(param.key, param.value);
        auth.setState((s) {
          s.isLogin = true;
        });
      }
    }

    /// Close the popup window
    if (_popupWin != null) {
      _popupWin?.close();
      _popupWin = null;
      if (auth.state.isLogin) {
        unawaited(nav.replaceToMainPage());
        SuccessMessenger('Login Successful').show(ctx!);
      }
    }
  }
}
