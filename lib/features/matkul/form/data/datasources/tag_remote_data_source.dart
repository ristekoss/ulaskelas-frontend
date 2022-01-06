part of '_datasources.dart';

abstract class TagRemoteDataSource {
  Future<Parsed<List<String>>> getAllTag();
}

class TagRemoteDataSourceImpl implements TagRemoteDataSource {
  @override
  Future<Parsed<List<String>>> getAllTag() async {
    final list = <String>[];
    final url = Endpoints.tags;
    final resp = await getIt(url);
    for (final data in resp.dataBodyAsMap['tags']) {
      list.add(data);
    }
    if (resp.statusCode == 200) {
      await FileService.saveJson('tag.json', jsonEncode(resp.data));
    }
    return resp.parse(list);
  }
}
