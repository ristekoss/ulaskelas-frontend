// Created by Muhamad Fauzi Ridwan on 07/11/21.

part of '_models.dart';

class MatkulModel {
  MatkulModel({
    this.code,
    this.curriculum,
    this.name,
    this.description,
    this.sks,
    this.term,
    this.prerequisites,
    this.reviewCount,
  });

  MatkulModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    curriculum = json['curriculum'];
    name = json['name'];
    description = json['description'];
    sks = json['sks'];
    term = json['term'];
    prerequisites = json['prerequisites'];
    reviewCount = json['review_count'];
    if (name?.isNotEmpty ?? false) {
      shortName = name?.split(' ').fold<String>(
          '',
          (previousValue, element) =>
              previousValue + element.substring(0, min(element.length, 1)));
      shortName = shortName!.substring(0, min(shortName!.length, 2));
    }
  }

  String? code;
  String? curriculum;
  String? name;
  String? description;
  int? sks;
  int? term;
  String? prerequisites;
  int? reviewCount;
  String? shortName;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['code'] = code;
    data['curriculum'] = curriculum;
    data['name'] = name;
    data['description'] = description;
    data['sks'] = sks;
    data['term'] = term;
    data['prerequisites'] = prerequisites;
    data['review_count'] = reviewCount;
    return data;
  }
}
