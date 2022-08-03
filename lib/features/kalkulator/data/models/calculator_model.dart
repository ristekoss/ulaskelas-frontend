import 'dart:math';

class CalculatorModel {
  int? id;
  String? user;
  int? courseId;
  String? courseName;
  double? totalScore;
  double? totalPercentage;
  String? shortName;

  CalculatorModel(
      {this.id,
        this.user,
        this.courseId,
        this.courseName,
        this.totalScore,
        this.totalPercentage,
        this.shortName,
      });

  CalculatorModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    user = json['user'];
    courseId = json['course_id'];
    courseName = json['course_name'];
    totalScore = json['total_score'];
    totalPercentage = json['total_percentage'];
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
    data['id'] = id;
    data['user'] = user;
    data['course_id'] = courseId;
    data['course_name'] = courseName;
    data['total_score'] = totalScore;
    data['total_percentage'] = totalPercentage;
    return data;
  }
}
