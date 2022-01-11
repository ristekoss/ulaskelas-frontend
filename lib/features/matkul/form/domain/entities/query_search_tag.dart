import 'package:ulaskelas/features/matkul/search/domain/entities/_entities.dart';

class QuerySearchTag extends QuerySearch {
  QuerySearchTag({
    this.name = '',
    int page = 1,
  }) : super(page: page);

  String name;

  @override
  String toString() {
    final data = <String, String>{};
    if (name.isNotEmpty) {
      data['name'] = name;
    }
    data['page'] = page.toString();
    return Uri(queryParameters: data).query;
  }
}
