// Created by Muhamad Fauzi Ridwan on 09/11/21.

part of '_datasources.dart';

abstract class MatkulRemoteDataSource {
  Future<Parsed<List<MatkulModel>>> getAllMatkul();
}

class MatkulRemoteDataSourceImpl implements MatkulRemoteDataSource {
  @override
  Future<Parsed<List<MatkulModel>>> getAllMatkul() async {
    final list = <MatkulModel>[];
    final url = Endpoints.courses;
    final resp = await getIt(url);
    for (final data in resp.dataBodyIterable) {
      list.add(MatkulModel.fromJson(data));
    }
    return resp.parse(list);
  }
}
