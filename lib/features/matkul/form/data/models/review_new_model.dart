part of '_models.dart';

class ReviewNewModel {
  ReviewNewModel({
    this.id,
    this.author,
    this.courseCode,
    this.createdAt,
    this.updatedAt,
    this.academicYear,
    this.semester,
    this.content,
    this.hateSpeechStatus,
    this.sentimen,
    this.isAnonym,
    this.tags,
    this.likesBy,
  });

  ReviewNewModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    author = json['author'];
    courseCode = json['course_code'];
    createdAt = DateTime.parse(json['created_at']);
    updatedAt = DateTime.parse(json['updated_at']);
    academicYear = json['academic_year'];
    semester = json['semester'];
    content = json['content'];
    hateSpeechStatus = json['hate_speech_status'];
    sentimen = json['sentimen'];
    isAnonym = json['is_anonym'];
    tags = <String>[];
    likesBy = <String>[];

    for (final i in json['tags']) {
      tags!.add(i.toString());
    }

    for (final i in json['likes_by']) {
      likesBy!.add(i.toString());
    }
  }

  int? id;
  String? author;
  String? courseCode;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? academicYear;
  int? semester;
  String? content;
  String? hateSpeechStatus;
  int? sentimen;
  bool? isAnonym;
  List<String>? tags;
  List<String>? likesBy;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['course_code'] = courseCode;
    data['academic_year'] = academicYear;
    data['semester'] = semester;
    data['content'] = content;
    data['is_anonym'] = isAnonym;
    data['tags'] = tags;
    return data;
  }

  bool isEmpty() {
    return author == null;
  }

  @override
  bool operator ==(Object other) {
    if (other is ReviewNewModel) {
      return author == other.author &&
          courseCode == other.courseCode &&
          createdAt == other.createdAt;
    }
    return super == other;
  }

  @override
  int get hashCode => super.hashCode;
}
