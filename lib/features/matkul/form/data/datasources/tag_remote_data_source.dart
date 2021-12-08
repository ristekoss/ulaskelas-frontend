part of '_datasources.dart';

abstract class TagRemoteDataSource {
  Future<Parsed<List<TagModel>>> getAllTag();
}

class TagRemoteDataSourceImpl implements TagRemoteDataSource {
  @override
  Future<Parsed<List<TagModel>>> getAllTag() async {
    final list = <TagModel>[];
    final url = Endpoints.tags;
    final resp = await getIt(url);
    for (final data in resp.dataBodyAsMap['tags']) {
      list.add(TagModel.fromJson(data));
    }
    if (resp.statusCode == 200) {
      await FileService.saveJson('tag.json', jsonEncode(resp.data));
    }
    return resp.parse(list);
  }
}
