part of '_datasources.dart';

abstract class LikeRemoteDataSource {
  Future<dynamic> like(ReviewModel review);
  Future<dynamic> unlike(ReviewModel review);
}

class LikeRemoteDataSourceImpl implements LikeRemoteDataSource {
  @override
  Future<dynamic> like(ReviewModel review) async {
    final url = Endpoints.likes;
    final resp = await postIt(
      url,
      model: {
        'review_id': review.id,
        'is_like': true,
      },
    );
    return resp;
  }

  @override
  Future<dynamic> unlike(ReviewModel review) async {
    final url = Endpoints.likes;
    final resp = await postIt(
      url,
      model: {
        'review_id': review.id,
        'is_like': false,
      },
    );
    return resp;
  }
}
