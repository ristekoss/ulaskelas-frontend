import 'package:ulaskelas/features/matkul/search/domain/entities/_entities.dart';

class QuerySearchCourse extends QuerySearch {
  QuerySearchCourse({
    this.isShowAll = true,
  });

  bool isShowAll;

  @override
  String toString() {
    final data = <String, String>{};
    data['show_all'] = isShowAll.toString();
    return Uri(queryParameters: data).query;
  }
}
