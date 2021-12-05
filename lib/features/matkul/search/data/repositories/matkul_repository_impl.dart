// Created by Muhamad Fauzi Ridwan on 09/11/21.

part of '_repositories.dart';

class MatkulRepositoryImpl implements MatkulRepository {
  MatkulRepositoryImpl(
    this._remoteDataSource,
    this._localDataSource,
  );

  final MatkulRemoteDataSource _remoteDataSource;
  final MatkulLocalDataSource _localDataSource;

  @override
  Future<Decide<Failure, Parsed<List<MatkulModel>>>> getAllMatkul() {
    return apiCall(_remoteDataSource.getAllMatkul());
  }

  @override
  Future<Decide<Failure, Parsed<List<MatkulModel>>>> getAllMatkulFromCache() {
    return apiCall(_localDataSource.getAllMatkul());
  }
}
