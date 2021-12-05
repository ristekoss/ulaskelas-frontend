// Created by Muhamad Fauzi Ridwan on 09/11/21.

part of '_repositories.dart';

class MatkulRepositoryImpl implements MatkulRepository {
  MatkulRepositoryImpl(this._remoteDataSource);

  final MatkulRemoteDataSource _remoteDataSource;

  @override
  Future<Decide<Failure, Parsed<List<MatkulModel>>>> getAllMatkul() {
    return apiCall(_remoteDataSource.getAllMatkul());
  }
}
