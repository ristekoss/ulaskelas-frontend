part of '_extension.dart';

class Parsed<T> {
  Parsed.fromJson(
    Map<String, dynamic> json,
    this.statusCode,
    this.data,
  ) {
    message = json['error'] ?? json['detail'] ?? '';
  }

  Parsed.fromPaginationJson(
    Map<String, dynamic> json,
    this.statusCode,
    this.data,
    this.meta,
  ) {
    message = json['error'] ?? json['detail'] ?? '';
  }

  late int statusCode;
  late String message;
  late T data;
  PaginationMeta? meta;
}

extension ResponseExtension<T> on Response {
  //ignore:avoid_shadowing_type_parameters
  Parsed<T> parse<T>(T t) {
    return Parsed.fromJson(
      data as Map<String, dynamic>,
      statusCode!,
      t,
    );
  }

  dynamic get responseData => (data as Map<String, dynamic>)['data'];

  /// Get iterable data
  dynamic get dataBodyIterable => (data as Map<String, dynamic>)['data'];
  Map<String, dynamic> get bodyAsMap => data as Map<String, dynamic>;
  Map<String, dynamic> get dataBodyAsMap => responseData ?? <String, dynamic>{};
  Map<String, dynamic> get bodyMap => data as Map<String, dynamic>;
}

class PaginationMeta {
  PaginationMeta({
    this.currentPage,
    this.lastPage,
    this.total,
    this.perPage,
  });

  PaginationMeta.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    lastPage = json['last_page'];
    total = json['total'];
    perPage = json['per_page'];
  }

  int? currentPage;
  int? lastPage;
  int? total;
  int? perPage;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['current_page'] = currentPage;
    data['last_page'] = lastPage;
    data['total'] = total;
    data['per_page'] = perPage;
    return data;
  }
}
