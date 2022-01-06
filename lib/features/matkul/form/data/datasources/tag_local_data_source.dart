part of '_datasources.dart';

abstract class TagLocalDataSource {
  Future<Parsed<List<String>>> getAllTag();
}

class TagLocalDataSourceImpl implements TagLocalDataSource {
  @override
  Future<Parsed<List<String>>> getAllTag() async {
    final list = <String>[];
    final file = await FileService.getJson('tag.json');
    final rawJson = await file.readAsString();
    Logger().i(rawJson);
    final json = jsonDecode(rawJson) as Map<String, dynamic>;
    for (final data in json['data']['tags']) {
      list.add(data);
    }
    return Parsed.fromJson(json, 200, list);
  }
}
