// Created by Muhamad Fauzi Ridwan on 30/11/21.

part of '_client.dart';

Future<Decide<Failure, T>> apiCall<T>(Future<T> t) async {
  try {
    final futureCall = await t;
    return Right(futureCall);
  } on DioError catch (e) {
    Logger().wtf(e.error.runtimeType);
    Logger().wtf(e.error.toString());
    if (e.error is ArgumentError) {
      final error = e.error as ArgumentError;
      return Left(GeneralFailure(message: error.message));
    } else if (e.error is SocketException) {
      Logger().e('Error: No Internet Connection');
      return Left(NetworkFailure(message: 'No Internet Connection'));
    } else if (e.error is TimeoutException) {
      Logger().e('Error: Timeout');
      return Left(TimeoutFailure());
    } else if (e.error is FormatException) {
      /// Case json not match || attribute name changed from BE
      Logger().e('Error: Format from front end error');
      return Left(GeneralFailure(message: 'Format Exception'));
    } else if ((e.response?.statusCode ?? 0) == 403) {
      Logger().e('Unauthorized');
      return Left(GeneralFailure(message: 'Unauthorize'));
    } else if ((e.response?.statusCode ?? 0) == 404) {
      Logger().e('Not Found Failure');
      return Left(
        NotFoundFailure(
          message: e.response?.data['message'] ?? 'Not Found',
        ),
      );
    } else {
      final message = DioFailure.fromDioError(e).message;
      return Left(GeneralFailure(message: message));
    }
  } catch (e) {
    Logger().e(e.toString());
    Logger().e(e.runtimeType);
    if (e is TypeError) {
      return Left(GeneralFailure(message: 'Type Error occured'));
    }

    ///case error FrontEnd Service
    return Left(GeneralFailure(message: ''));
  }
}
