part of '_states.dart';

class ComponentState{
  ComponentState() {
    final _remoteDataSource = ComponentRemoteDataSourceImpl();
    _repo = ComponentRepositoryImpl(_remoteDataSource);
  }

  late ComponentRepository _repo;
  List<ComponentModel>? _components;
  List<ComponentModel> get components => _components ?? [];

  bool hasReachedMax = false;
  int page = 1;

  String? cacheKey = 'component-state';

  bool getCondition() {
    print('data ${_components?.isNotEmpty}');
    return _components?.isNotEmpty ?? false;
  }

  Future<void> retrieveData(QueryComponent query) async {
    final resp = await _repo.getAllComponent(query);
    resp.fold((failure) {
      return failure;
    }, (result) {
      final lessThanLimit = result.data.length < 10;
      hasReachedMax = result.data.isEmpty || lessThanLimit;
      _components = result.data;
      print(components);
    },);
    componentRM.notify();
  }

  Future<void> deleteComponent(QueryComponent query) async {
    final resp = await _repo.deleteComponent(query);
    await resp.fold((failure) {
      ErrorMessenger('Komponen gagal dihapus')
          .show(ctx!);
    }, (result) async {
      SuccessMessenger('Komponen berhasil dipahus').show(ctx!);
    });
  }
}
