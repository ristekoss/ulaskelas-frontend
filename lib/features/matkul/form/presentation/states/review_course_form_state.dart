// Created by Muhamad Fauzi Ridwan on 20/11/21.

part of '_states.dart';

class ReviewCourseFormState {
  ReviewCourseFormState() {
    final remoteDataSource = ReviewRemoteDataSourceImpl();
    final localDataSource = ReviewLocalDataSourceImpl();
    _repo = ReviewRepositoryImpl(
      remoteDataSource,
      localDataSource,
    );
  }

  late ReviewRepository _repo;
  final formKey = GlobalKey<FormState>();
  var _formData = ReviewMatkulData();
  final _descController = TextEditingController();

  final semesters = <String>['Semester ganjil', 'Semester genap'];
  final years = <String>['2022', '2021', '2020', '2019', '2018', '2017'];

  bool isLoading = false;

  /// Submitting form data
  Future<void> submitForm({
    required CourseModel course,
  }) async {
    isLoading = true;
    reviewFormRM.notify();
    final result = <String, dynamic>{};
    // TODO(Any): sync with current matkul
    result['course_code'] = course.code;
    result['semester'] = _formData.semester! == semesters[0] ? 1 : 2;
    result['academic_year'] =
        getPairedYear(result['semester'], _formData.year!);
    result['content'] = _formData.description;
    result['is_anonym'] = _formData.isAnonymous;
    result['tags'] = [for (final i in _formData.tagData) i];

    result['rating_understandable'] = _formData.ratingUnderstandable;
    result['rating_fit_to_credit'] = _formData.ratingFitToCredit;
    result['rating_fit_to_study_book'] = _formData.ratingFitToStudyBook;
    result['rating_beneficial'] = _formData.ratingBeneficial;
    result['rating_recommended'] = _formData.ratingRecommended;

    final resp = await _repo.createReview(result);
    MixpanelService.track(
      'write_review',
      params: {
        'course_id': course.code.toString(),
        'course_name': course.name.toString(),
        'created_at': DateTime.now().toString(),
        'period_taking': _formData.semester.toString(),
        'year_taking': _formData.year.toString(),
        'avg_rating_given': reviewFormRM.state.getAvgRating().toString(),
        'tags': _formData.tagData.toString(),
        'anonymous_review': _formData.isAnonymous.toString(),
      },
    );
    isLoading = false;
    reviewFormRM.notify();
    resp.fold((failure) {
      throw failure;
    }, (result) {
      final successSubmittedReview = result.data;
      print(successSubmittedReview);
    });
  }

  String getPairedYear(int semester, String selectedYear) {
    if (semester == 1) {
      return '$selectedYear/${int.parse(selectedYear) + 1}';
    }
    return '${int.parse(selectedYear) - 1}/$selectedYear';
  }

  ReviewMatkulData get formData => _formData;

  TextEditingController get descController => _descController;

  set selectTag(List<String> data) => _formData.tagData = data;

  void setSemester(String sem) {
    _formData.semester = sem;
  }

  void setYear(String year) {
    _formData.year = year;
  }

  void setDesc() {
    _formData.description = descController.text;
  }

  void setAnon({required bool val}) {
    _formData.isAnonymous = val;
  }

  void setRatingUnderstandable({
    required double ratingUnderstandable,
  }) {
    _formData.ratingUnderstandable = ratingUnderstandable;
  }

  void setRatingFitToCredit({
    required double ratingFitToCredit,
  }) {
    _formData.ratingFitToCredit = ratingFitToCredit;
  }

  void setRatingFitToStudyBook({
    required double ratingFitToStudyBook,
  }) {
    _formData.ratingFitToStudyBook = ratingFitToStudyBook;
  }

  void setRatingBeneficial({
    required double ratingBeneficial,
  }) {
    _formData.ratingBeneficial = ratingBeneficial;
  }

  void setRatingRecommended({
    required double ratingRecommended,
  }) {
    _formData.ratingRecommended = ratingRecommended;
  }

  double getAvgRating() {
    return ((_formData.ratingBeneficial ?? 0) +
            (_formData.ratingFitToCredit ?? 0) +
            (_formData.ratingFitToStudyBook ?? 0) +
            (_formData.ratingRecommended ?? 0) +
            (_formData.ratingUnderstandable ?? 0)) /
        5;
  }

  /// Cleaning form when success submitting form
  void cleanForm() {
    _formData = ReviewMatkulData();
    _descController.text = '';
    searchTagRM.state.cleanSearch();
  }
}

class ReviewMatkulData {
  ReviewMatkulData() {
    tagData = [];
    isAnonymous = false;
  }

  late List<String> tagData;
  String? semester;
  String? year;
  String? description;
  late bool isAnonymous;
  double? ratingUnderstandable;
  double? ratingFitToCredit;
  double? ratingFitToStudyBook;
  double? ratingBeneficial;
  double? ratingRecommended;
}
