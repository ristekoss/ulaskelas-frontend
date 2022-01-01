// Created by Muhamad Fauzi Ridwan on 09/11/21.

part of '_repositories.dart';

abstract class MatkulRepository {
  Future<Decide<Failure, Parsed<List<MatkulModel>>>> getAllMatkul(
      QuerySearch querySearch);
  Future<Decide<Failure, Parsed<List<MatkulModel>>>> getAllMatkulFromCache();
}
