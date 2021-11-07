// Created by Muhamad Fauzi Ridwan on 07/11/21.

part of '_models.dart';

class MatkulModel {
  MatkulModel({
    this.name,
    this.precondition,
    this.reviews,
    this.shortName,
  });

  MatkulModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    precondition = json['precondition'];
    reviews = json['reviews'];
    shortName = json['shortName'];
  }

  String? name;
  String? precondition;
  int? reviews;
  String? shortName;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['name'] = name;
    data['precondition'] = precondition;
    data['reviews'] = reviews;
    data['shortName'] = shortName;
    return data;
  }
}
