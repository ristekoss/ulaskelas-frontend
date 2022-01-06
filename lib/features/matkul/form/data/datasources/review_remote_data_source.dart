part of '_datasources.dart';

abstract class ReviewRemoteDataSource {
  Future<Parsed<ReviewModel>> createReview(Map<String, dynamic> model);
  Future<Parsed<List<ReviewModel>>> getAllReview(QueryReview q);
}

class ReviewRemoteDataSourceImpl implements ReviewRemoteDataSource {
  @override
  Future<Parsed<ReviewModel>> createReview(
    Map<String, dynamic> model,
  ) async {
    final url = Endpoints.review;
    await postIt(
      Endpoints.tags,
      model: <String, dynamic>{'tags': model['tags']},
    );
    final resp = await postIt(url, model: model);

    return resp.parse(ReviewModel.fromJson(resp.dataBodyAsMap));
  }

  @override
  Future<Parsed<List<ReviewModel>>> getAllReview(QueryReview q) async {
    final list = <ReviewModel>[];
    final url = '${Endpoints.review}?$q';
    final resp = await getIt(url);
    for (final data in resp.dataBodyIterable) {
      list.add(ReviewModel.fromJson(data));
    }
    if (resp.statusCode == 200) {
      final filename = Filename.review
          .replaceAll('{code}', q.courseCode.toString())
          .replaceAll('{page}', q.page.toString());

      await FileService.saveJson(filename, jsonEncode(resp.data));
      await Pref.saveString(filename, DateTime.now().toIso8601String());
    }
    return resp.parse(list);
  }
}
