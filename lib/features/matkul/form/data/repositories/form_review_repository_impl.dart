part of '_repositories.dart';

class FormReviewRepositoryImpl implements FormReviewRepository {
  FormReviewRepositoryImpl(this._reviewRemoteDataSource);

  final ReviewRemoteDataSource _reviewRemoteDataSource;


  @override
  Future<Decide<Failure, Parsed<ReviewNewModel>>> createReview(
      Map<String, dynamic> model) async {
    return apiCall(_reviewRemoteDataSource.createReview(model));
  }

}