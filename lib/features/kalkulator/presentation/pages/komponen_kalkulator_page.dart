part of '_pages.dart';

class CalculatorComponentPage extends StatefulWidget {
  const CalculatorComponentPage({
    Key? key,
    required this.calculatorId,
    required this.courseName,
    required this.totalScore,
    required this.totalPercentage,
  }) : super(key: key);

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
  void init() {}

  Future<void> retrieveData() async {
    // unawaited(
    //   courseDetailRM.setState((s) => s.retrieveData(widget.courseId)),
    // );
    // await reviewCourseRM.setState(
    //       (s) => s.retrieveData(QueryReview(courseCode: widget.courseCode)),
    // );
  }

  @override
  ScaffoldAttribute buildAttribute() {
    return ScaffoldAttribute();
  }

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context) {
    return BaseAppBar(label: 'Detail Mata Kuliah');
  }

  @override
  Widget buildNarrowLayout(
    BuildContext context,
    SizingInformation sizeInfo,
  ) {
    return Padding(
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
              )
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
                )
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(
                vertical: 10,
              ),
              children: [
                const CardCompononent(
                  id: 1, name: 'Komponen', score: 50, weight: 15,
                ),
                const CardCompononent(
                  id: 1, name: 'Komponen', score: 50, weight: 15,
                ),
                const CardCompononent(
                  id: 1, name: 'Komponen', score: 50, weight: 15,
                ),
                const CardCompononent(
                  id: 1, name: 'Komponen', score: 50, weight: 15,
                ),
                const CardCompononent(
                  id: 1, name: 'Komponen', score: 50, weight: 15,
                ),

                const HeightSpace(30),

                SecondaryButton(
                  width: double.infinity,
                  text: 'Tambah Komponen',
                  backgroundColor: BaseColors.purpleHearth,
                  onPressed: () {
                    nav.goToComponentFormPage(
                        calculatorId: widget.calculatorId,);
                  },
                ),

                const HeightSpace(70),

                Center(
                  child: InkWell(
                    onTap: () {nav.pop();},
                    child: Text(
                      'Hapus Kalkulator Mata Kuliah',
                      style: FontTheme.poppins14w500black().copyWith(
                        color: BaseColors.error,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
          // Expanded(
          //   child: RefreshIndicator(
          //     key: refreshIndicatorKey,
          //     onRefresh: retrieveData,
          //     child: OnBuilder<CourseDetailState>.all(
          //       listenTo: courseDetailRM,
          //       onIdle: () => WaitingView(),
          //       onWaiting: () => WaitingView(),
          //       onError: (dynamic error, refresh) => const Text('error'),
          //       onData: (data) {
          //         final course = data.detailCourse;
          //         return ListView(
          //           shrinkWrap: true,
          //           controller: scrollController,
          //           padding: const EdgeInsets.all(24),
          //           children: [
          //             _buildTitleAndBookmark(course),
          //             const HeightSpace(24),
          //             if (course.tags?.isNotEmpty ?? false)
          //               _buildMatkulTag(course),
          //             const HeightSpace(16),
          //             _buildMatkulDescription(course),
          //             const HeightSpace(32),
          //             _buildMatkulPrerequisite(course),
          //             const HeightSpace(32),
          //             _buildReviewBySelf(),
          //             _buildReviews(),
          //           ],
          //         );
          //       },
          //     ),
          //   ),
          // ),
        ],
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
}
