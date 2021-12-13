part of '_models.dart';

class BookmarkModel {
  BookmarkModel({
    this.user,
    this.course,
  });

  BookmarkModel.fromJson(Map<String, dynamic> json) {
    user = json['user'];
    course = json['course'];
  }

  String? user;
  String? course;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['user'] = user;
    data['course'] = course;
    return data;
  }
}
