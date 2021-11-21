// Created by Muhamad Fauzi Ridwan on 20/11/21.

part of '_states.dart';

class ReviewMatkulFormState {
  final formKey = GlobalKey<FormState>();
  var _formData = ReviewMatkulData();

  /// Submitting form data
  Future<void> submitForm() async {}

  ReviewMatkulData get formData => _formData;
  set selectTag(List<TagModel> data) => _formData.tagData = data;

  /// Cleaning form when success submitting form
  void cleanForm() {
    _formData = ReviewMatkulData();
    searchTag.state.cleanSearch();
  }
}

class ReviewMatkulData {
  ReviewMatkulData() {
    tagData = [];
  }

  late List<TagModel> tagData;
}
