part of '_datasources.dart';

abstract class ReviewLocalDataSource {
  Future<Parsed<List<ReviewModel>>> getAllReview();
}

class ReviewLocalDataSourceImpl implements ReviewLocalDataSource {
  @override
  Future<Parsed<List<ReviewModel>>> getAllReview() async {
    final list = <ReviewModel>[];
    final file = await FileService.getJson('review.json');
    final rawJson = await file.readAsString();
    Logger().i(rawJson);
    final json = jsonDecode(rawJson) as Map<String, dynamic>;

    // Tapi ini kl get matkul gatau matkulnya apa hm
    // gimana cara dapet course code nya ya
    for (final data in json['data']) {
      list.add(ReviewModel.fromJson(data));
    }
    return Parsed.fromJson(json, 200, list);
  }
}
