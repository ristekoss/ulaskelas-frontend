// Created by Muhamad Fauzi Ridwan on 09/11/21.

part of '_datasources.dart';

abstract class CourseRemoteDataSource {
  Future<Parsed<List<MatkulModel>>> getAllMatkul(QuerySearch querySearch);
}

class CourseRemoteDataSourceImpl implements CourseRemoteDataSource {
  @override
  Future<Parsed<List<MatkulModel>>> getAllMatkul(
      QuerySearch querySearch) async {
    final list = <MatkulModel>[];
    final url = '${Endpoints.courses}?$querySearch';
    final resp = await getIt(url);
    for (final data in resp.dataBodyAsMap['courses']) {
      list.add(MatkulModel.fromJson(data));
    }
    if (resp.statusCode == 200) {
      await FileService.saveJson('matkul.json', jsonEncode(resp.data));
    }
    return resp.parse(list);
  }
}
