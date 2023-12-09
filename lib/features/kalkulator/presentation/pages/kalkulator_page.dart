part of '_pages.dart';

class CalculatorPage extends StatefulWidget {
  const CalculatorPage({
    super.key,
  });

  @override
  _CalculatorPageState createState() => _CalculatorPageState();
}

class _CalculatorPageState extends BaseStateful<CalculatorPage> {
  @override
  void init() {
    StateInitializer(
      rIndicator: refreshIndicatorKey!,
      state: calculatorRM.state.getCondition(),
      cacheKey: calculatorRM.state.cacheKey!,
    ).initialize();
  }

  @override
  ScaffoldAttribute buildAttribute() {
    return ScaffoldAttribute();
  }

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context) {
    return BaseAppBar(
      hasLeading: false,
      label: 'Kalkulator Nilai Mata Kuliah',
      centerTitle: false,
      elevation: 0,
    );
  }

  @override
  Widget buildNarrowLayout(
    BuildContext context,
    SizingInformation sizeInfo,
  ) {
    return SafeArea(
      child: RefreshIndicator(
        key: refreshIndicatorKey,
        onRefresh: retrieveData,
        child: OnBuilder<CalculatorState>.all(
          listenTo: calculatorRM,
          onIdle: WaitingView.new,
          onWaiting: WaitingView.new,
          onError: (dynamic error, refresh) => const Text('error'),
          onData: (data) {
            final calculators = data.calculators;
            if (calculators.isEmpty) {
              return Padding(
                padding: const EdgeInsets.all(20),
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      HeightSpace(sizeInfo.screenSize.height * .05),
                      Image.asset(
                        Ilustration.notfound,
                        width: sizeInfo.screenSize.width * .6,
                      ),
                      const HeightSpace(20),
                      Text(
                        'Belum Ada Kalkulator Nilai Tersimpan',
                        style: FontTheme.poppins14w700black().copyWith(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      const HeightSpace(10),
                      Text(
                        '''
Kamu Belum memiliki kalkulator nilai tersimpan. Silakan tambahkan terlebih dahulu.''',
                        style: Theme.of(context).textTheme.bodySmall,
                        textAlign: TextAlign.center,
                      ),
                      const HeightSpace(30),
                      SecondaryButton(
                        width: double.infinity,
                        text: 'Tambah Mata Kuliah',
                        backgroundColor: BaseColors.purpleHearth,
                        onPressed: () {
                          nav.goToSearchCourseCalculatorPage();
                          // ignore: lines_longer_than_80_chars
                          MixpanelService.track('calculator_add_course');
                        },
                      ),
                    ],
                  ),
                ),
              );
            }
            return Column(
              children: [
                Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.all(20),
                    itemCount: calculatorRM.state.calculators.length + 1,
                    itemBuilder: (context, index) {
                      if (index == calculators.length) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 20,
                          ),
                          child: SecondaryButton(
                            width: double.infinity,
                            text: 'Tambah Mata Kuliah',
                            backgroundColor: BaseColors.purpleHearth,
                            onPressed: () =>
                                nav.goToSearchCourseCalculatorPage(),
                          ),
                        );
                      }
                      final calculator = calculators[index];
                      return CardCalculator(
                        model: calculator,
                        onTap: () {
                          nav.goToComponentCalculatorPage(
                            calculatorId: calculator.id!,
                            courseName: calculator.courseName!,
                            totalScore: calculator.totalScore!,
                            totalPercentage: calculator.totalPercentage!,
                          );
                          MixpanelService.track(
                            'calculator_view_course',
                            params: {
                              'course_id': calculator.courseName!,
                              'final_letter_grade': _getFinalGrade(
                                  calculator.totalScore!,),
                              'final_grade': calculator.totalScore.toString(),
                            },
                          );
                        },
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) =>
                        const SizedBox(height: 16),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  @override
  Widget buildWideLayout(
    BuildContext context,
    SizingInformation sizeInfo,
  ) {
    return buildNarrowLayout(context, sizeInfo);
  }

  @override
  Future<bool> onBackPressed() async {
    return true;
  }

  void onScroll() {}

  Future<void> retrieveData() async {
    await calculatorRM.setState((s) => s.retrieveData());
  }

  bool scrollCondition() {
    throw UnimplementedError();
  }

  String _getFinalGrade(double score) {
    var grade = 'E';
    if (score >= 85) {
      grade = 'A';
    } else if (score >= 80) {
      grade = 'A-';
    } else if (score >= 75) {
      grade = 'B+';
    } else if (score >= 70) {
      grade = 'B';
    } else if (score >= 65) {
      grade = 'B-';
    } else if (score >= 60) {
      grade = 'C+';
    } else if (score >= 55) {
      grade = 'C';
    } else if (score >= 40) {
      grade = 'D';
    }

    return grade;
  }
}
