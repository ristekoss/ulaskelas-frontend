part of '_datasources.dart';

abstract class CalculatorRemoteDataSource {
  Future<Parsed<List<CalculatorModel>>> getAllCalculator();
  Future<Parsed<void>> postCalculator(String courseCode);
  Future<Parsed<void>> deleteCalculator(QueryCalculator q);
}

class CalculatorRemoteDataSourceImpl extends CalculatorRemoteDataSource {
  @override
  Future<Parsed<List<CalculatorModel>>> getAllCalculator() async {
    final list = <CalculatorModel>[];
    final url = Endpoints.calculators;
    final resp = await getIt(url);
    for (final data in resp.dataBodyIterable) {
      list.add(CalculatorModel.fromJson(data));
    }
    return resp.parse(list);
  }

  @override
  Future<Parsed<void>> postCalculator(String courseCode) async {
    final url = Endpoints.calculators;
    final resp = await postIt(
      url,
      model: <String, dynamic>{
        'course_code': courseCode,
      },
    );
    return resp.parse(null);
  }

  @override
  Future<Parsed<void>> deleteCalculator(QueryCalculator q) async {
    final url = '${Endpoints.calculators}?$q';
    final resp = await deleteIt(url);
    return resp.parse(null);
  }
}
