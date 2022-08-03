part of '_datasources.dart';

abstract class ComponentRemoteDataSource {
  Future<Parsed<List<ComponentModel>>> getAllComponent(QueryComponent q);

  Future<Parsed<ComponentModel>> createComponent(Map<String, dynamic> model);

  Future<Parsed<ComponentModel>> editComponent(Map<String, dynamic> model);

  Future<void> deleteComponent(QueryComponent q);


}

class ComponentRemoteDataSourceImpl extends ComponentRemoteDataSource {
  @override
  Future<Parsed<List<ComponentModel>>> getAllComponent(QueryComponent q) async {
    final list = <ComponentModel>[];
    final url = '${Endpoints.components}?$q';
    final resp = await getIt(url);
    for (final data in resp.dataBodyIterable) {
      list.add(ComponentModel.fromJson(data));
    }
    return resp.parse(list);
  }

  @override
  Future<Parsed<ComponentModel>> createComponent(
    Map<String, dynamic> model,
  ) async {
    final url = Endpoints.components;
    final resp = await postIt(url, model: model);
    return resp.parse(ComponentModel.fromJson(resp.dataBodyAsMap));
  }

  @override
  Future<Parsed<ComponentModel>> editComponent(
    Map<String, dynamic> model,
  ) async {
    final url = Endpoints.components;
    final resp = await putIt(url, model: model);
    return resp.parse(ComponentModel.fromJson(resp.dataBodyAsMap));
  }

  @override
  Future<void> deleteComponent(QueryComponent q) async {
    final url = '${Endpoints.components}?$q';
    final resp = await deleteIt(url);
    if (resp.statusCode == 200) {
      Logger().i('Component successfully deleted');
    } else {
      Logger().e('Something went wrong');
    }
  }
}
