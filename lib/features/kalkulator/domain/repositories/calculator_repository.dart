part of '_repositories.dart';

abstract class CalculatorRepository {
  Future<Decide<Failure, Parsed<List<CalculatorModel>>>> getAllCalculator();
  Future<Decide<Failure, void>> postCalculator(String courseCode);
  Future<Decide<Failure, void>> deleteCalculator(QueryCalculator q);
}
