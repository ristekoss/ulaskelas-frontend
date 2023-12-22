part of '_client.dart';

Future<Response> getIt(
  String url, {
  Map<String, String>? headers,
}) async {
  if (kDebugMode) {
    Logger().i({'url': url, 'headers': '${Pref.getHeaders()}'});
  }
  final getHeaders = headers ?? Pref.getHeaders();
  final resp = await Dio().get(
    url,
    options: Options(
      headers: getHeaders,
      receiveTimeout: 5000,
      sendTimeout: 6000,
    ),
  );
  if (kDebugMode) {
    Logger()
        .i({'response': '${resp.data}', 'statusCode': '${resp.statusCode}'});
  }
  return resp;
}

Future<Response> postIt(
  String url, {
  Map<String, String>? headers,
  Map<String, dynamic>? model,
}) async {
  if (kDebugMode) {
    Logger().i({
      'url': url,
      'headers': '${Pref.getHeaders()}',
      'model': '$model',
    });
  }
  final getHeaders = headers ?? Pref.getHeaders();
  final resp = await Dio().post(
    url,
    data: json.encode(model),
    options: Options(
      headers: getHeaders,
      receiveTimeout: 5000,
      sendTimeout: 6000,
    ),
  );
  if (kDebugMode) {
    Logger()
        .i({'response': '${resp.data}', 'statusCode': '${resp.statusCode}'});
  }
  return resp;
}

Future<Response> putIt(
  String url, {
  Map<String, String>? headers,
  Map<String, dynamic>? model,
}) async {
  if (kDebugMode) {
    Logger().i({
      'url': url,
      'headers': '${Pref.getHeaders()}',
      'model': '$model',
    });
  }
  final getHeaders = headers ?? Pref.getHeaders();
  final resp = await Dio().put(
    url,
    data: model,
    options: Options(
      headers: getHeaders,
      receiveTimeout: 5000,
      sendTimeout: 6000,
    ),
  );
  if (kDebugMode) {
    Logger()
        .i({'response': '${resp.data}', 'statusCode': '${resp.statusCode}'});
  }
  return resp;
}

Future<Response> deleteIt(
  String url, {
  Map<String, String>? headers,
  Map<String, dynamic>? model,
}) async {
  if (kDebugMode) {
    Logger().i({
      'url': url,
      'headers': '${Pref.getHeaders()}',
      'model': '$model',
    });
  }
  final getHeaders = headers ?? Pref.getHeaders();
  final resp = await Dio().delete(
    url,
    data: model,
    options: Options(
      headers: getHeaders,
      receiveTimeout: 5000,
      sendTimeout: 6000,
    ),
  );
  if (kDebugMode) {
    Logger()
        .i({'response': '${resp.data}', 'statusCode': '${resp.statusCode}'});
  }
  return resp;
}
