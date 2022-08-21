part of '_datasources.dart';

abstract class TagRemoteDataSource {
  Future<Parsed<List<String>>> getAllTag(QuerySearchTag query);
}

class TagRemoteDataSourceImpl implements TagRemoteDataSource {
  @override
  Future<Parsed<List<String>>> getAllTag(QuerySearchTag query) async {
    final list = <String>[];
    final url = '${EndpointsV1.tags}?$query';
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
