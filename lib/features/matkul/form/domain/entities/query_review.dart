class QueryReview {
  String? courseCode;
  int page;
  int limit;
  bool? byAuthor;

  QueryReview({
    this.courseCode,
    this.page = 1,
    this.limit = 10,
    this.byAuthor,
  });

  @override
  String toString() {
    final data = <String, String>{};
    if (courseCode != null) {
      data['course_code'] = courseCode.toString();
    }
    data['page'] = page.toString();
    if (byAuthor != null) {
      data['by_author'] = byAuthor.toString();
    }
    return Uri(queryParameters: data).query;
  }
}
