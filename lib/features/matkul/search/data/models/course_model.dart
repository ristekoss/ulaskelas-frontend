// Created by Muhamad Fauzi Ridwan on 07/11/21.

part of '_models.dart';

class CourseModel {
  CourseModel({
    this.id,
    this.code,
    this.curriculum,
    this.name,
    this.description,
    this.sks,
    this.term,
    this.prerequisites,
    this.reviewCount,
    this.codeDesc,
    this.tags,
    this.ratingAverage,
    this.ratingUnderstandable,
    this.ratingFitToCredit,
    this.ratingFitToStudyBook,
    this.ratingBeneficial,
    this.ratingRecommended,
  });

  CourseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
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
    if (description?.isEmpty ?? true) {
      description = 'Tidak ada deskripsi';
    }

    if (json['tags'] != null) {
      tags = json['tags'].cast<String>();
    }
    ratingAverage = json['rating_average'];
    ratingUnderstandable = json['rating_understandable'];
    ratingFitToCredit = json['rating_fit_to_credit'];
    ratingFitToStudyBook = json['rating_fit_to_study_book'];
    ratingBeneficial = json['rating_beneficial'];
    ratingRecommended = json['rating_recommended'];
  }

  int? id;
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
  List<String>? tags;
  double? ratingAverage;
  double? ratingUnderstandable;
  double? ratingFitToCredit;
  double? ratingFitToStudyBook;
  double? ratingBeneficial;
  double? ratingRecommended;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['code'] = code;
    data['code_desc'] = codeDesc;
    data['curriculum'] = curriculum;
    data['name'] = name;
    data['description'] = description;
    data['sks'] = sks;
    data['term'] = term;
    data['prerequisites'] = prerequisites;
    data['review_count'] = reviewCount;
    data['tags'] = tags;
    data['rating_average'] = ratingAverage;
    data['rating_understandable'] = ratingUnderstandable;
    data['rating_fit_to_credit'] = ratingFitToCredit;
    data['rating_fit_to_study_book'] = ratingFitToStudyBook;
    data['rating_beneficial'] = ratingBeneficial;
    data['rating_recommended'] = ratingRecommended;
    return data;
  }

  @override
  bool operator ==(Object other) {
    if (other is CourseModel) {
      return code == other.code || id == other.id;
    }
    return super == other;
  }

  @override
  int get hashCode => super.hashCode;

  String get describe => '$code  •  $sks SKS  •  $codeDesc';
  String get cleanedDesc =>
      description?.isEmpty ?? true ? 'Tidak ada deskripsi' : '$description';
}
