import 'package:ulaskelas/core/bases/states/_states.dart';
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
    if (filterRM.state.selectedSks.isNotEmpty) {
      data['sks'] = filterRM.state.selectedSks.join(',');
    }
    if (filterRM.state.selectedSemester.isNotEmpty) {
      data['term'] = filterRM.state.selectedSemester.join(',');
    }
    if (filterRM.state.selectedType.isNotEmpty) {
      data['code_desc'] = filterRM.state.selectedType.join(',');
    }
    return Uri(queryParameters: data).query;
  }
}
