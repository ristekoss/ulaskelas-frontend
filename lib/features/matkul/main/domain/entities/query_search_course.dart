import 'package:ulaskelas/features/matkul/search/domain/entities/_entities.dart';

class QuerySearchCourse extends QuerySearch {
  QuerySearchCourse({
    this.isShowAll = true,
    String name = '',
    int page = 1,
  }) : super(
          q: name,
          page: page,
        );

  bool isShowAll;
  int? sks;
  int? term;

  @override
  String toString() {
    final data = <String, String>{};
    data['show_all'] = isShowAll.toString();
    if (page != null) {
      data['page'] = page.toString();
    }
    if (q.isNotEmpty) {
      data['name'] = q;
    }
    return Uri(queryParameters: data).query;
  }
}
