part of '_models.dart';

class BookmarkModel {
  BookmarkModel({
    this.courseCode,
    this.isBookmark
  });
  
  String? courseCode;
  bool? isBookmark;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['courseCode'] = courseCode;
    data['isBookmark'] = isBookmark;
    return data;
  }
  
}