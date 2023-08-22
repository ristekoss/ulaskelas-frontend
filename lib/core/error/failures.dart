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
      case DioErrorType.connectTimeout:
        message = 'Connection timeout with API server';
      case DioErrorType.other:
        message = 'Connection to API server failed due to internet connection';
      case DioErrorType.receiveTimeout:
        message = 'Receive timeout in connection with API server';
      case DioErrorType.sendTimeout:
        message = 'Send timeout in connection with API server';
      case DioErrorType.response:
        message = _handleResponseError(dioError.response);
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
    super.code,
    super.message,
  }) : super(
          title: 'Network Failure',
        );
}

class NotFoundFailure extends Failure {
  NotFoundFailure({
    super.code,
    super.message,
  }) : super(
          title: 'Not Found Failure',
        );
}

class BadRequestFailure extends Failure {
  BadRequestFailure({
    super.code,
    super.message,
  }) : super(
          title: 'Bad Request Failure',
        );
}

class GeneralFailure extends Failure {
  GeneralFailure({
    super.message,
  }) : super(
          title: 'General Failure',
        );
}

class TimeoutFailure extends Failure {
  TimeoutFailure({
    super.message,
  }) : super(
          title: 'Timeout Failure',
        );
}

class ArgumentFailure extends Failure {
  ArgumentFailure({
    super.message,
  }) : super(
          title: 'Argument Failure',
        );
}

class UnAuthorizeFailure extends Failure {
  UnAuthorizeFailure({
    super.message,
  }) : super(
          title: 'UnAuthorize Failure',
        );
}

class ParseFailure extends Failure {}

class EmptyFailure extends Failure {}
