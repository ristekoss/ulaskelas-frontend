// Created by Muhamad Fauzi Ridwan on 20/11/21.

part of '_states.dart';

class ReviewMatkulFormState {
  ReviewMatkulFormState() {
    final _remoteDataSource = ReviewRemoteDataSourceImpl();
    _repo = FormReviewRepositoryImpl(
      _remoteDataSource,
    );
  }

  late FormReviewRepository _repo;
  final formKey = GlobalKey<FormState>();
  var _formData = ReviewMatkulData();
  final _descController = TextEditingController();

  final semesters = <String>['Semester ganjil', 'Semester genap'];
  final years = <String>['2021', '2020', '2019', '2018', '2017'];

  /// Submitting form data
  Future<void> submitForm() async {
    final result = <String, dynamic>{};
    // TODO: sync with current matkul
    result['course_code'] = 'CSCE604231';
    result['semester'] = _formData.semester! == semesters[0] ? 1 : 2;
    result['academic_year'] =
        getPairedYear(result['semester'], _formData.year!);
    result['content'] = _formData.description;
    result['is_anonym'] = _formData.isAnonymous;
    result['tags'] = [for (var i in _formData.tagData) i.name];

    final resp = await _repo.createReview(result);
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

  set selectTag(List<TagModel> data) => _formData.tagData = data;

  void setSemester(String sem) {
    _formData.semester = sem;
  }

  void setYear(String year) {
    _formData.year = year;
  }

  void setDesc() {
    _formData.description = descController.text;
  }

  void setAnon(bool val) {
    _formData.isAnonymous = val;
  }

  /// Cleaning form when success submitting form
  void cleanForm() {
    _formData = ReviewMatkulData();
    _descController.text = '';
    searchTag.state.cleanSearch();
  }
}

class ReviewMatkulData {
  ReviewMatkulData() {
    tagData = [];
    isAnonymous = false;
  }

  late List<TagModel> tagData;
  String? semester;
  String? year;
  String? description;
  late bool isAnonymous;
}
