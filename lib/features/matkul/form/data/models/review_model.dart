part of '_models.dart';

class ReviewModel {
  int? id;
  int? user;
  int? course;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? academicYear;
  int? semester;
  String? content;
  String? hateSpeechStatus;
  int? sentimen;
  bool? isAnonym;
  bool? isActive;
  String? author;
  String? authorGeneration;
  String? authorStudyProgram;
  String? courseCode;
  String? courseCodeDesc;
  String? courseName;
  String? shortName;
  int? courseReviewCount;
  List<String>? tags;
  int likesCount;
  bool? isLiked;
  double? ratingAverage;
  double? ratingUnderstandable;
  double? ratingFitToCredit;
  double? ratingFitToStudyBook;
  double? ratingBeneficial;
  double? ratingRecommended;
  int? rankTop20;

  ReviewModel({
    this.id,
    this.user,
    this.course,
    this.createdAt,
    this.updatedAt,
    this.academicYear,
    this.semester,
    this.content,
    this.hateSpeechStatus,
    this.sentimen,
    this.isAnonym,
    this.isActive,
    this.author,
    this.authorGeneration,
    this.authorStudyProgram,
    this.courseCode,
    this.courseCodeDesc,
    this.courseName,
    this.courseReviewCount,
    this.tags,
    this.likesCount = 0,
    this.isLiked,
    this.ratingAverage = 0,
    this.ratingUnderstandable = 0,
    this.ratingFitToCredit = 0,
    this.ratingFitToStudyBook = 0,
    this.ratingBeneficial = 0,
    this.ratingRecommended = 0,
    this.rankTop20 = 0,
  });

  ReviewModel.fromJson(Map<String, dynamic> json, {this.likesCount = 0}) {
    id = json['id'];
    user = json['user'];
    course = json['course'];
    createdAt = DateTime.tryParse(json['created_at'])?.toLocal();
    updatedAt = DateTime.tryParse(json['updated_at'])?.toLocal();
    academicYear = json['academic_year'];
    semester = json['semester'];
    content = json['content'];
    hateSpeechStatus = json['hate_speech_status'];
    sentimen = json['sentimen'];
    isAnonym = json['is_anonym'];
    isActive = json['is_active'];
    author = json['author'];
    authorGeneration = json['author_generation'];
    authorStudyProgram = json['author_study_program'];
    courseCode = json['course_code'];
    courseCodeDesc = json['course_code_desc'] ?? courseCode;
    courseName = json['course_name'];
    courseReviewCount = json['course_review_count'];
    tags = json['tags'].cast<String>();
    likesCount = json['likes_count'];
    isLiked = json['is_liked'];
    if (courseName?.isNotEmpty ?? false) {
      shortName = courseName?.split(' ').fold<String>(
            '',
            (previousValue, element) =>
                previousValue + element.substring(0, min(element.length, 1)),
          );
      shortName = shortName!.substring(0, min(shortName!.length, 2));
    }
    if (isAnonym ?? false) {
      author = 'Anonymous';
      authorStudyProgram = '****';
      authorGeneration = '****';
    }
    ratingAverage = json['rating_average'];
    ratingUnderstandable = json['rating_understandable'];
    ratingFitToCredit = json['rating_fit_to_credit'];
    ratingFitToStudyBook = json['rating_fit_to_study_book'];
    ratingBeneficial = json['rating_beneficial'];
    ratingRecommended = json['rating_recommended'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['user'] = user;
    data['course'] = course;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['academic_year'] = academicYear;
    data['semester'] = semester;
    data['content'] = content;
    data['hate_speech_status'] = hateSpeechStatus;
    data['sentimen'] = sentimen;
    data['is_anonym'] = isAnonym;
    data['is_active'] = isActive;
    data['author'] = author;
    data['author_generation'] = authorGeneration;
    data['author_study_program'] = authorStudyProgram;
    data['course_code'] = courseCode;
    data['course_code_desc'] = courseCodeDesc;
    data['course_name'] = courseName;
    data['course_review_count'] = courseReviewCount;
    data['tags'] = tags;
    data['likes_count'] = likesCount;
    data['is_liked'] = isLiked;
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
    if (other is ReviewModel) {
      return id == other.id;
    }
    return super == other;
  }

  @override
  int get hashCode => super.hashCode;
}
