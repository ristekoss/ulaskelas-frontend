part of '_error.dart';

abstract class Failure implements Exception {
  Failure({
    this.title,
    this.code,
    this.message,
  });

  String? title;

  /// In case server provider error codes.
  String? code;

  /// Hold Error Message.
  String? message;
}

class DioFailure implements Exception {
  DioFailure.fromDioError(DioError dioError) {
    switch (dioError.type) {
      case DioErrorType.cancel:
        message = 'Request to API server was cancelled';
        break;
      case DioErrorType.connectTimeout:
        message = 'Connection timeout with API server';
        break;
      case DioErrorType.other:
        message = 'Connection to API server failed due to internet connection';
        break;
      case DioErrorType.receiveTimeout:
        message = 'Receive timeout in connection with API server';
        break;
      case DioErrorType.sendTimeout:
        message = 'Send timeout in connection with API server';
        break;
      case DioErrorType.response:
        message = _handleResponseError(dioError.response);
        break;
      default:
        message = 'Something went wrong';
        break;
    }
  }

  String message = 'Permintaan gagal, silahkan coba lagi atau hubungi admin';

  String _handleResponseError(Response? res) {
    var errorMessage = message;

    // ignore:
    if (res?.data['message'] != null) {
      errorMessage = res!.data['message'].toString();
    }

    if (res?.data['errors'] != null) {
      errorMessage = res!.data['errors'].toString();
    }

    if (res?.data['error'] != null) {
      errorMessage = res!.data['error'].toString();
    }

    return errorMessage;
  }

  @override
  String toString() => message;
}

class NetworkFailure extends Failure {
  NetworkFailure({
    String? code,
    String? message,
  }) : super(
          code: code,
          message: message,
          title: 'Network Failure',
        );
}

class NotFoundFailure extends Failure {
  NotFoundFailure({
    String? code,
    String? message,
  }) : super(
          code: code,
          message: message,
          title: 'Not Found Failure',
        );
}

class BadRequestFailure extends Failure {
  BadRequestFailure({
    String? code,
    String? message,
  }) : super(
          code: code,
          message: message,
          title: 'Bad Request Failure',
        );
}

class GeneralFailure extends Failure {
  GeneralFailure({
    String? message,
  }) : super(
          message: message,
          title: 'General Failure',
        );
}

class TimeoutFailure extends Failure {
  TimeoutFailure({
    String? message,
  }) : super(
          message: message,
          title: 'Timeout Failure',
        );
}

class ArgumentFailure extends Failure {
  ArgumentFailure({
    String? message,
  }) : super(
          message: message,
          title: 'Argument Failure',
        );
}

class ParseFailure extends Failure {}

class EmptyFailure extends Failure {}
