// Created by Muhamad Fauzi Ridwan on 20/11/21.

part of '_states.dart';

class ReviewMatkulFormState {
  final formKey = GlobalKey<FormState>();
  var _formData = ReviewMatkulData();
  final semesters = <String>['Semester ganjil', 'Semester genap'];
  final years = <String>['2021', '2020', '2019', '2018', '2017'];
  final _descController = TextEditingController();

  /// Submitting form data
  Future<void> submitForm() async {}

  ReviewMatkulData get formData => _formData;

  TextEditingController get descController => _descController;

  set selectTag(List<TagModel> data) => _formData.tagData = data;

  void setSemester(String sem) {
    _formData.semester = sem;
  }

  void setYear(String year) {
    _formData.year = year;
  }

  void setDesc(String desc) {
    _formData.description = desc;
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
  bool? isAnonymous;
}
