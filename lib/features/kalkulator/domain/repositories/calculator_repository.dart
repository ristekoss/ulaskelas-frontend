part of '_repositories.dart';

abstract class CalculatorRepository {
  Future<Decide<Failure, Parsed<List<CalculatorModel>>>> getAllCalculator();
  Future<Decide<Failure, Parsed<void>>> postCalculator(String courseCode);
  Future<Decide<Failure, Parsed<void>>> deleteCalculator(QueryCalculator q);
}
