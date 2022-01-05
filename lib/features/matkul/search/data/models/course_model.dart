// Created by Muhamad Fauzi Ridwan on 07/11/21.

part of '_models.dart';

class CourseModel {
  CourseModel({
    this.code,
    this.curriculum,
    this.name,
    this.description,
    this.sks,
    this.term,
    this.prerequisites,
    this.reviewCount,
    this.codeDesc,
  });

  CourseModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    codeDesc = json['code_desc'] ?? code;
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
                previousValue + element.substring(0, min(element.length, 1)),
          );
      shortName = shortName!.substring(0, min(shortName!.length, 2));
    }
  }

  String? code;
  String? codeDesc;
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
    data['code_desc'] = codeDesc;
    data['curriculum'] = curriculum;
    data['name'] = name;
    data['description'] = description;
    data['sks'] = sks;
    data['term'] = term;
    data['prerequisites'] = prerequisites;
    data['review_count'] = reviewCount;
    return data;
  }

  @override
  bool operator ==(Object other) {
    if (other is CourseModel) {
      return code == other.code;
    }
    return super == other;
  }

  @override
  int get hashCode => super.hashCode;

  String get describe => '$code  •  $sks SKS  •  $codeDesc';
}
