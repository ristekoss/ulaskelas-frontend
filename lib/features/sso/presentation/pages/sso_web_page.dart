// Created by Muhamad Fauzi Ridwan on 28/11/21.

part of '_pages.dart';

class SSOWebPage extends StatefulWidget {
  const SSOWebPage({super.key});

  @override
  _SSOWebPageState createState() => _SSOWebPageState();
}

class _SSOWebPageState extends BaseStateful<SSOWebPage> {
  final Completer<WebViewController> controller =
      Completer<WebViewController>();

  bool successCallback = false;

  @override
  void init() {
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
  }

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context) {
    return BaseAppBar(
      label: 'SSO Login',
    );
  }

  @override
  ScaffoldAttribute buildAttribute() {
    return ScaffoldAttribute();
  }

  @override
  Widget buildNarrowLayout(BuildContext context, SizingInformation sizeInfo) {
    return Stack(
      children: [
        WebView(
          initialUrl: Endpoints.ssoMobile,
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (webViewController) async {
            await CookieManager().clearCookies();
            controller.complete(webViewController);
          },
          onProgress: _onProgress,
          navigationDelegate: _navigationDelegate,
          onPageStarted: (String url) {
            Logger().i('Page started loading: $url');
          },
          onPageFinished: _onPageFinish,
          gestureNavigationEnabled: true,
        ),
        OnReactive(
          () {
            if (progressWebView.state.progress < 1.0) {
              return LinearProgressIndicator(
                value: progressWebView.state.progress,
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ],
    );
  }

  @override
  Widget buildWideLayout(BuildContext context, SizingInformation sizeInfo) {
    return buildNarrowLayout(context, sizeInfo);
  }

  @override
  Future<bool> onBackPressed() async {
    return true;
  }

  void _onPageFinish(String url) {
    Logger().i('Page finished loading: $url');
    if (url.startsWith(Endpoints.token) && !successCallback) {
      successCallback = true;
      final uri = Uri.parse(url);
      final params = uri.queryParameters;
      for (final param in params.entries) {
        if (param.key == 'token') {
          Pref.saveToken(param.value);
        } else if (param.key == 'username') {
          Pref.saveString(param.key, param.value);
          authRM.setState((s) {
            s
              ..isLogin = true
              ..isLoading = true;
            return;
          });
        }
      }
      nav.pop<bool>(true);
    }
  }

  void _onProgress(int progress) {
    Logger().i(progress);
    progressWebView.setState((s) {
      s.progress = progress / 100;
      return;
    });
  }

  NavigationDecision _navigationDelegate(NavigationRequest request) {
    if (request.url.startsWith('https://www.youtube.com/')) {
      Logger().i('navigation to $request blocked');
      return NavigationDecision.prevent;
    }
    Logger().i('navigation to $request allowed');
    return NavigationDecision.navigate;
  }
}
