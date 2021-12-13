// Created by Muhamad Fauzi Ridwan on 05/12/21.
part of '_datasources.dart';

abstract class CourseLocalDataSource {
  Future<Parsed<List<MatkulModel>>> getAllMatkul();
}

class CourseLocalDataSourceImpl implements CourseLocalDataSource {
  @override
  Future<Parsed<List<MatkulModel>>> getAllMatkul() async {
    final list = <MatkulModel>[];
    final file = await FileService.getJson('matkul.json');
    final rawJson = await file.readAsString();
    Logger().i(rawJson);
    final json = jsonDecode(rawJson) as Map<String, dynamic>;
    for (final data in json['data']['courses']) {
      list.add(MatkulModel.fromJson(data));
    }
    return Parsed.fromJson(json, 200, list);
  }
}
