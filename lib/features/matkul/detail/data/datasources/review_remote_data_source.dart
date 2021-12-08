part of '_datasources.dart';

abstract class ReviewRemoteDataSource {
  Future<Parsed<List<ReviewModel>>> getAllReview();
}

class ReviewRemoteDataSourceImpl implements ReviewRemoteDataSource {
  @override

  // Gimana caranya masukin parameter, kalo dimasukkin parameter dia marah
  Future<Parsed<List<ReviewModel>>> getAllReview() async {
    final list = <ReviewModel>[];
    final url = Endpoints.review;
    final resp = await getIt(url);
    for (final data in resp.data) {
      list.add(ReviewModel.fromJson(data));
    }
    if (resp.statusCode == 200) {
      await FileService.saveJson('review.json', jsonEncode(resp.data));
    }
    return resp.parse(list);
  }
}
