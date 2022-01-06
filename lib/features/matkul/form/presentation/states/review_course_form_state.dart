// Created by Muhamad Fauzi Ridwan on 20/11/21.

part of '_states.dart';

class ReviewCourseFormState {
  ReviewCourseFormState() {
    final _remoteDataSource = ReviewRemoteDataSourceImpl();
    final _localDataSource = ReviewLocalDataSourceImpl();
    _repo = ReviewRepositoryImpl(
      _remoteDataSource,
      _localDataSource,
    );
  }

  late ReviewRepository _repo;
  final formKey = GlobalKey<FormState>();
  var _formData = ReviewMatkulData();
  final _descController = TextEditingController();

  final semesters = <String>['Semester ganjil', 'Semester genap'];
  final years = <String>['2021', '2020', '2019', '2018', '2017'];

  bool isLoading = false;

  /// Submitting form data
  Future<void> submitForm(String courseCode) async {
    isLoading = true;
    reviewFormRM.notify();
    final result = <String, dynamic>{};
    // TODO(Any): sync with current matkul
    result['course_code'] = courseCode;
    result['semester'] = _formData.semester! == semesters[0] ? 1 : 2;
    result['academic_year'] =
        getPairedYear(result['semester'], _formData.year!);
    result['content'] = _formData.description;
    result['is_anonym'] = _formData.isAnonymous;
    result['tags'] = [for (final i in _formData.tagData) i];

    final resp = await _repo.createReview(result);
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
}
