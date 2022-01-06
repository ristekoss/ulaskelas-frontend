part of '_models.dart';

class BookmarkModel {
  String? user;
  String? courseCode;
  String? courseCodeDesc;
  String? courseName;
  int? courseReviewCount;
  String? shortName;

  BookmarkModel({
    this.user,
    this.courseCode,
    this.courseCodeDesc,
    this.courseName,
    this.courseReviewCount,
    this.shortName,
  });

  BookmarkModel.fromJson(Map<String, dynamic> json) {
    user = json['user'];
    courseCode = json['course_code'];
    courseCodeDesc = json['course_code_desc'] ?? courseCode;
    courseName = json['course_name'];
    courseReviewCount = json['course_review_count'];
    if (courseName?.isNotEmpty ?? false) {
      shortName = courseName?.split(' ').fold<String>(
            '',
            (previousValue, element) =>
                previousValue + element.substring(0, min(element.length, 1)),
          );
      shortName = shortName!.substring(0, min(shortName!.length, 2));
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['user'] = user;
    data['course_code'] = courseCode;
    data['course_code_desc'] = courseCodeDesc;
    data['course_name'] = courseName;
    data['course_review_count'] = courseReviewCount;
    return data;
  }

  @override
  bool operator ==(Object other) {
    if (other is BookmarkModel) {
      return courseCode == other.courseCode;
    }
    return super == other;
  }

  @override
  int get hashCode => super.hashCode;
}
