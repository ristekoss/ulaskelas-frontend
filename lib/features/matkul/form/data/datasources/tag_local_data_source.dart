part of '_datasources.dart';

abstract class TagLocalDataSource {
  Future<Parsed<List<TagModel>>> getAllTag();
}

class TagLocalDataSourceImpl implements TagLocalDataSource {
  @override
  Future<Parsed<List<TagModel>>> getAllTag() async {
    final list = <TagModel>[];
    final file = await FileService.getJson('tag.json');
    final rawJson = await file.readAsString();
    Logger().i(rawJson);
    final json = jsonDecode(rawJson) as Map<String, dynamic>;
    for (final data in json['data']['tags']) {
      list.add(TagModel.fromJson(data));
    }
    return Parsed.fromJson(json, 200, list);
  }
}
