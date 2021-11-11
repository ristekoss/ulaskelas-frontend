// Created by Muhamad Fauzi Ridwan on 07/11/21.

part of '_models.dart';

class MatkulModel {
  MatkulModel({
    this.name,
    this.matkulType,
    this.matkulTypeValue,
    this.reviews,
    this.shortName,
    this.sks,
  });

  MatkulModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    matkulType = json['matkulType'];
    matkulTypeValue = json['matkulTypeValue'];
    reviews = json['reviews'];
    shortName = json['shortName'];
    sks = json['sks'];
  }

  String? name;
  String? matkulType;
  String? matkulTypeValue;
  int? reviews;
  String? shortName;
  String? sks;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['name'] = name;
    data['matkulType'] = matkulType;
    data['matkulTypeValue'] = matkulTypeValue;
    data['reviews'] = reviews;
    data['shortName'] = shortName;
    return data;
  }

  @override
  bool operator ==(Object other) {
    if (other is MatkulModel) {
      return name == other.name;
    }
    return super == other;
  }

  @override
  int get hashCode => super.hashCode;
}
