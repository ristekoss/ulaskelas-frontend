part of '_repositories.dart';

class CalculatorRepositoryImpl implements CalculatorRepository{
  CalculatorRepositoryImpl(
      this._remoteDataSource,
      );
  final CalculatorRemoteDataSource _remoteDataSource;

  @override
  Future<Decide<Failure, Parsed<List<CalculatorModel>>>> getAllCalculator() {
    return apiCall(_remoteDataSource.getAllCalculator());
  }

  @override
  Future<Decide<Failure, void>> postCalculator(String courseCode) {
    return apiCall(_remoteDataSource.postCalculator(courseCode));
  }

  @override
  Future<Decide<Failure, void>> deleteCalculator(QueryCalculator q) {
    return apiCall(_remoteDataSource.deleteCalculator(q));
  }
}
