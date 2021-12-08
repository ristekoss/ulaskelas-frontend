part of '_datasources.dart';

abstract class ReviewRemoteDataSource {
  Future<Parsed<ReviewNewModel>> createReview(Map<String, dynamic> model);
}

class ReviewRemoteDataSourceImpl implements ReviewRemoteDataSource {
  @override
  Future<Parsed<ReviewNewModel>> createReview(
      Map<String, dynamic> model) async {
    final url = Endpoints.review;
    final resp = await postIt(url, model: model);

    return resp.parse(ReviewNewModel.fromJson(resp.dataBodyAsMap));
  }
}
