part of '_repositories.dart';

abstract class ComponentRepository {
  Future<Decide<Failure, Parsed<List<ComponentModel>>>> getAllComponent(
      QueryComponent q,);
  Future<Decide<Failure, Parsed<ComponentModel>>> createComponent(
      Map<String, dynamic> model,
      );
  Future<Decide<Failure, Parsed<ComponentModel>>> editComponent(
      Map<String, dynamic> model,
      );
  Future<Decide<Failure, Parsed<void>>> deleteComponent(QueryComponent q);
}
