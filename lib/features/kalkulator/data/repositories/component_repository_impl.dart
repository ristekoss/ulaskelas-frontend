part of '_repositories.dart';

class ComponentRepositoryImpl extends ComponentRepository {
  ComponentRepositoryImpl(
    this._remoteDataSource,
  );

  final ComponentRemoteDataSource _remoteDataSource;

  @override
  Future<Decide<Failure, Parsed<List<ComponentModel>>>> getAllComponent(
    QueryComponent q,
  ) {
    return apiCall(_remoteDataSource.getAllComponent(q));
  }

  @override
  Future<Decide<Failure, Parsed<ComponentModel>>> createComponent(
    Map<String, dynamic> model,
  ) {
    return apiCall(_remoteDataSource.createComponent(model));
  }

  @override
  Future<Decide<Failure, Parsed<ComponentModel>>> editComponent(
      Map<String, dynamic> model,) {
    return apiCall(_remoteDataSource.editComponent(model));
  }

  @override
  Future<Decide<Failure, void>> deleteComponent(QueryComponent q) {
    return apiCall(_remoteDataSource.deleteComponent(q));
  }
}
