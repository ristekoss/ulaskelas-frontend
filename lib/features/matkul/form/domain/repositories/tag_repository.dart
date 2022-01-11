// Created by Muhamad Fauzi Ridwan on 09/11/21.

part of '_repositories.dart';

abstract class TagRepository {
  Future<Decide<Failure, Parsed<List<String>>>> getAllTag(QuerySearchTag query);
  Future<Decide<Failure, Parsed<List<String>>>> getAllTagFromCache();
}
