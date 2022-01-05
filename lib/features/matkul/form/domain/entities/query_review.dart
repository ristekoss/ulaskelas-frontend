class QueryReview {
  String courseCode;
  int page;
  int limit;

  QueryReview({
    required this.courseCode,
    this.page = 1,
    this.limit = 10,
  });

  @override
  String toString() {
    final data = <String, String>{};
    data['course_code'] = courseCode;
    data['page'] = page.toString();
    return Uri(queryParameters: data).query;
  }
}
