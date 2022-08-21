part of '_datasources.dart';

abstract class LikeRemoteDataSource {
  Future<Parsed<String>> like(ReviewModel review);
  Future<Parsed<String>> unlike(ReviewModel review);
}

class LikeRemoteDataSourceImpl implements LikeRemoteDataSource {
  @override
  Future<Parsed<String>> like(ReviewModel review) async {
    final url = EndpointsV1.likes;
    final resp = await postIt(
      url,
      model: {
        'review_id': review.id,
        'is_like': true,
      },
    );
    return resp.parse('');
  }

  @override
  Future<Parsed<String>> unlike(ReviewModel review) async {
    final url = EndpointsV1.likes;
    final resp = await postIt(
      url,
      model: {
        'review_id': review.id,
        'is_like': false,
      },
    );
    return resp.parse('');
  }
}
