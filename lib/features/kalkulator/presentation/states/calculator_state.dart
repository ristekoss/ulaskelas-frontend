part of '_states.dart';

class CalculatorState {
  CalculatorState() {
    final remoteDataSource = CalculatorRemoteDataSourceImpl();
    _repo = CalculatorRepositoryImpl(remoteDataSource);
  }

  late CalculatorRepository _repo;
  List<CalculatorModel>? _calculators;

  List<CalculatorModel> get calculators => _calculators ?? [];

  bool hasReachedMax = false;
  int page = 1;

  String? cacheKey = 'calculator-state';

  bool getCondition() {
    print('data ${_calculators?.isNotEmpty}');
    return _calculators?.isNotEmpty ?? false;
  }

  Future<void> retrieveData() async {
    final resp = await _repo.getAllCalculator();
    resp.fold((failure) => throw failure, (result) {
      final lessThanLimit = result.data.length < 10;
      hasReachedMax = result.data.isEmpty || lessThanLimit;
      _calculators = result.data;
      print(_calculators);
    });
    calculatorRM.notify();
  }

  Future<void> postCalculator(String courseCode) async {
    final resp = await _repo.postCalculator(courseCode);
    await resp.fold((failure) {
      ErrorMessenger('Kalkulator dengan Mata Kuliah tersebut sudah ada')
          .show(ctx!);
    }, (result) async {
      SuccessMessenger('Kalkulator berhasil dibuat').show(ctx!);
      final calcResp = await _repo.getAllCalculator();
      calcResp.fold((failure) => throw failure, (result) {
        final lessThanLimit = result.data.length < 10;
        hasReachedMax = result.data.isEmpty || lessThanLimit;
        _calculators = result.data;
        print(_calculators);
      });
    });
    calculatorRM.notify();
  }

  Future<void> deleteCalculator({
    required QueryCalculator query,
    required String courseName,
    required double totalScore,
  }) async {
    final resp = await _repo.deleteCalculator(query);
    MixpanelService.track(
      'calculator_delete_course_component',
      params: {
        'course_id': courseName,
        'final_letter_grade': totalScore.toString(),
        'final_grade': getFinalGrade(totalScore),
      },
    );
    await resp.fold((failure) {
      ErrorMessenger('Kalkulator gagal dihapus').show(ctx!);
    }, (result) async {
      SuccessMessenger('Kalkulator berhasil dipahus').show(ctx!);
      final calcResp = await _repo.getAllCalculator();
      calcResp.fold((failure) => throw failure, (result) {
        final lessThanLimit = result.data.length < 10;
        hasReachedMax = result.data.isEmpty || lessThanLimit;
        _calculators = result.data;
        print(_calculators);
      });
    });
    calculatorRM.notify();
  }
}
