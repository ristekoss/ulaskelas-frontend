// ignore_for_file: lines_longer_than_80_chars

part of '_pages.dart';

class CalculatorComponentPage extends StatefulWidget {
  const CalculatorComponentPage({
    required this.calculatorId,
    required this.courseName,
    required this.totalScore,
    required this.totalPercentage,
    super.key,
  });

  final int calculatorId;
  final String courseName;
  final double totalScore;
  final double totalPercentage;

  @override
  _CalculatorComponentPageState createState() =>
      _CalculatorComponentPageState();
}

class _CalculatorComponentPageState
    extends BaseStateful<CalculatorComponentPage> {
  late ScrollController scrollController;
  Completer<void>? completer;

  @override
  void init() {
    StateInitializer(
      rIndicator: refreshIndicatorKey!,
      state: false,
      cacheKey: componentRM.state.cacheKey!,
    ).initialize();
  }

  @override
  ScaffoldAttribute buildAttribute() {
    return ScaffoldAttribute();
  }

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context) {
    return BaseAppBar(
      label: 'Tambah Nilai Mata Kuliah',
      onBackPress: onBackPressed,
    );
  }

  @override
  Widget buildNarrowLayout(
    BuildContext context,
    SizingInformation sizeInfo,
  ) {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Text(
                  widget.courseName,
                  style: FontTheme.poppins20w700black(),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Nilai Akhir',
                    style: FontTheme.poppins14w400black(),
                  ),
                  Text(
                    _getFinalScoreAndGrade(widget.totalScore),
                    style: FontTheme.poppins14w600black(),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 20,
                ),
                child: Row(
                  children: [
                    Expanded(
                      flex: 4,
                      child: Text(
                        'Komponen',
                        style: FontTheme.poppins12w600black(),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        'Nilai',
                        style: FontTheme.poppins12w600black(),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        'Bobot',
                        textAlign: TextAlign.center,
                        style: FontTheme.poppins12w600black(),
                      ),
                    ),
                  ],
                ),
              ),
              RefreshIndicator(
                onRefresh: retrieveData,
                key: refreshIndicatorKey,
                child: OnBuilder<ComponentState>.all(
                  listenTo: componentRM,
                  onIdle: () => const CircleLoading(),
                  onWaiting: () => const CircleLoading(),
                  onError: (dynamic error, refresh) => Text(error.toString()),
                  onData: (data) {
                    final components = data.components;
                    if (components.isEmpty) {
                      return Padding(
                        padding: const EdgeInsets.all(10),
                        child: Center(
                          child: Text(
                            'Belum Ada Komponen',
                            style: FontTheme.poppins12w500black(),
                          ),
                        ),
                      );
                    }
                    return ListView.separated(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      padding: const EdgeInsets.only(top: 20),
                      itemCount: componentRM.state.components.length,
                      itemBuilder: (context, index) {
                        final component = components[index];
                        return CardCompononent(
                          id: component.id!,
                          name: component.name!,
                          score: component.score!,
                          weight: component.weight!,
                          onTap: () {
                            nav.goToEditComponentPage(
                              id: component.id!,
                              calculatorId: widget.calculatorId,
                              courseName: widget.courseName,
                              totalScore: widget.totalScore,
                              totalPercentage: widget.totalPercentage,
                              componentName: component.name!,
                              componentScore: component.score!,
                              componentWeight: component.weight!,
                            );
                          },
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) =>
                          const SizedBox(height: 1),
                    );
                  },
                ),
              ),
              const HeightSpace(30),
              SecondaryButton(
                width: double.infinity,
                text: 'Tambah Komponen',
                backgroundColor: BaseColors.purpleHearth,
                onPressed: () {
                  nav.goToComponentFormPage(
                    calculatorId: widget.calculatorId,
                    courseName: widget.courseName,
                    totalScore: widget.totalScore,
                    totalPercentage: widget.totalPercentage,
                  );
                },
              ),
              const HeightSpace(70),
              Center(
                child: InkWell(
                  onTap: () {
                    nav.pop();
                    calculatorRM.setState(
                      (s) => s.deleteCalculator(
                        QueryCalculator(id: widget.calculatorId),
                      ),
                    );
                    MixpanelService.track(
                      'calculator_delete_course_component',
                      params: {
                        'course_id': widget.courseName,
                        'final_letter_grade': widget.totalScore.toString(),
                        'final_grade': _getFinalScoreAndGrade(widget.totalScore),
                      },
                    );
                  },
                  child: Text(
                    'Hapus Kalkulator Mata Kuliah',
                    style: FontTheme.poppins14w500black().copyWith(
                      color: BaseColors.error,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
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
    nav.pop();
    await nav.replaceToMainPage();
    return true;
  }

  String _getFinalScoreAndGrade(double score) {
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

    return '$grade (${score.toStringAsFixed(2)})';
  }

  Future<void> retrieveData() async {
    await componentRM.setState(
      (s) => s.retrieveData(
        QueryComponent(
          calculatorId: widget.calculatorId,
        ),
      ),
    );
  }
}
