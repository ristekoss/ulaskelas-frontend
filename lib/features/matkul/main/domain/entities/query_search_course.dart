import 'package:ulaskelas/features/matkul/search/domain/entities/_entities.dart';

class QuerySearchCourse extends QuerySearch {
  QuerySearchCourse({
    this.isShowAll = true,
    String q = '',
    int page = 1,
  }) : super(
          q: q,
          page: page,
        );

  bool isShowAll;

  @override
  String toString() {
    final data = <String, String>{};
    data['show_all'] = isShowAll.toString();
    if (page != null) {
      data['page'] = page.toString();
    }
    // if (q.isNotEmpty) {
    //   data['q'] = q;
    // }
    return Uri(queryParameters: data).query;
  }
}
