part of '_datasources.dart';

abstract class ReviewLocalDataSource {
  Future<Parsed<List<ReviewModel>>> getAllCachedReview(QueryReview q);
}

class ReviewLocalDataSourceImpl implements ReviewLocalDataSource {
  @override
  Future<Parsed<List<ReviewModel>>> getAllCachedReview(
    QueryReview q,
  ) async {
    final list = <ReviewModel>[];
    final url = EndpointsV2.review;
    final resp = await getIt(url);
    for (final data in resp.dataBodyIterable) {
      list.add(ReviewModel.fromJson(data));
    }
    return resp.parse(list);
  }
}
