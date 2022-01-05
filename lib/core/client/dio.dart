part of '_client.dart';

Future<Response> getIt(
  String url, {
  Map<String, String>? headers,
}) async {
  Logger().i('Url $url');
  Logger().i('Header ${Pref.getHeaders()}');
  final _getHeaders = headers ?? Pref.getHeaders();
  final resp = await Dio().get(
    url,
    options: Options(
      headers: _getHeaders,
      receiveTimeout: 5000,
      sendTimeout: 6000,
    ),
  );
  Logger().d('Response');
  Logger().d(resp.data);
  Logger().d('Response code ${resp.statusCode}');
  return resp;
}

Future<Response> postIt(
  String url, {
  Map<String, String>? headers,
  Map<String, dynamic>? model,
}) async {
  Logger().i('Url $url');
  Logger().i('Header ${Pref.getHeaders()}');
  final _getHeaders = headers ?? Pref.getHeaders();
  final resp = await Dio().post(
    url,
    data: json.encode(model),
    options: Options(
      headers: _getHeaders,
      receiveTimeout: 5000,
      sendTimeout: 6000,
    ),
  );
  Logger().d('Response $resp');
  Logger().d('Response code ${resp.statusCode}');
  return resp;
}

Future<Response> putIt(
  String url, {
  Map<String, String>? headers,
  Map<String, dynamic>? model,
}) async {
  Logger().i('Url $url');
  Logger().i('Header ${Pref.getHeaders()}');
  final _getHeaders = headers ?? Pref.getHeaders();
  final resp = await Dio().put(
    url,
    data: model,
    options: Options(
      headers: _getHeaders,
      receiveTimeout: 5000,
      sendTimeout: 6000,
    ),
  );
  Logger().d('Response $resp');
  Logger().d('Response code ${resp.statusCode}');
  return resp;
}

Future<Response> deleteIt(
  String url, {
  Map<String, String>? headers,
  Map<String, dynamic>? model,
}) async {
  Logger().i('Url $url');
  Logger().i('Header ${Pref.getHeaders()}');
  final _getHeaders = headers ?? Pref.getHeaders();
  final resp = await Dio().delete(
    url,
    data: model,
    options: Options(
      headers: _getHeaders,
      receiveTimeout: 5000,
      sendTimeout: 6000,
    ),
  );
  Logger().d('Response $resp');
  Logger().d('Response code ${resp.statusCode}');
  return resp;
}
