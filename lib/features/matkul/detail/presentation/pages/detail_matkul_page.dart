// Created by Muhamad Fauzi Ridwan on 08/11/21.

part of '_pages.dart';

// TODO(bim): route to review widget.matkul use
/// ```dart
/// nav.push<void>(ReviewMatkulPage, RouteName.reviewMatkul,);
/// ```;
class DetailMatkulPage extends StatefulWidget {
  const DetailMatkulPage({
    Key? key,
    required this.courseId,
    required this.courseCode,
  }) : super(key: key);

  final int courseId;
  final String courseCode;

  @override
  _DetailMatkulPageState createState() => _DetailMatkulPageState();
}

class _DetailMatkulPageState extends BaseStateful<DetailMatkulPage> {
  late ScrollController scrollController;
  Completer<void>? completer;

  @override
  void init() {
    scrollController = ScrollController();
    completer = Completer<void>();
    scrollController.addListener(_onScroll);
    StateInitializer(
      rIndicator: refreshIndicatorKey!,
      cacheKey: 'detail-course',
      state: false,
    ).initialize();
  }

  void _onScroll() {
    if (_isBottom && !completer!.isCompleted && scrollCondition()) {
      onScroll();
    }
  }

  bool scrollCondition() {
    return !reviewCourseRM.state.hasReachedMax;
  }

  void onScroll() {
    completer?.complete();
    final query = QueryReview(courseCode: widget.courseCode);
    reviewCourseRM.state.retrieveMoreData(query).then((value) {
      completer = Completer<void>();
      reviewCourseRM.notify();
    }).onError((error, stackTrace) {
      completer = Completer<void>();
    });
  }

  bool get _isBottom {
    if (!scrollController.hasClients) {
      print('no client');
      return false;
    }
    final maxScroll = scrollController.position.maxScrollExtent;
    final currentScroll = scrollController.offset;
    print(currentScroll >= (maxScroll * 0.9));
    return currentScroll >= (maxScroll * 0.9);
  }

  Future<void> retrieveData() async {
    unawaited(
      courseDetailRM.setState((s) => s.retrieveData(widget.courseId)),
    );
    await reviewCourseRM.setState(
      (s) => s.retrieveData(QueryReview(courseCode: widget.courseCode)),
    );
    await Future.wait([
      leaderboardRM.setState((s) => s.retrieveData()),
    ]);
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
    return Column(
      children: [
        Expanded(
          child: RefreshIndicator(
            key: refreshIndicatorKey,
            onRefresh: retrieveData,
            child: OnBuilder<CourseDetailState>.all(
              listenTo: courseDetailRM,
              onIdle: () => WaitingView(),
              onWaiting: () => WaitingView(),
              onError: (dynamic error, refresh) => const Text('error'),
              onData: (data) {
                final course = data.detailCourse;
                return ListView(
                  shrinkWrap: true,
                  controller: scrollController,
                  padding: const EdgeInsets.all(24),
                  children: [
                    TitleAndBookMark(course: course),
                    const HeightSpace(24),
                    if (course.tags?.isNotEmpty ?? false)
                    _buildMatkulTag(course),
                    const HeightSpace(16),
                    _buildMatkulDescription(course),
                    const HeightSpace(32),
                    _buildMatkulPrerequisite(course),
                    const HeightSpace(32),
                    _buildReviewBySelf(),
                    _buildReviews(course),
                    const HeightSpace(16),
                    if (course.reviewCount! > 3)
                      InkWell(
                        onTap: () => nav.goToAllReviewMatkulPage(
                          courseId: widget.courseId,
                          courseCode: widget.courseCode,
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Lihat Semua Ulasan',
                              style: FontTheme.poppins13w400purple(),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            const Icon(
                              Icons.arrow_forward_rounded,
                              color: BaseColors.purpleHearth,
                              size: 18,
                            ),
                          ],
                        ),
                      ),
                  ],
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMatkulDescription(CourseModel course) {
    return Text(
      course.cleanedDesc,
      textAlign: TextAlign.justify,
      style: FontTheme.poppins12w400black(),
    );
  }

  Widget _buildMatkulTag(CourseModel course) {
    return Wrap(
      children: course.tags!
          .map(
            (e) => Padding(
          padding: const EdgeInsets.only(right: 8, bottom: 8),
          child: Tag(
            label: e,
          ),
        ),
      )
          .toList(),
    );
  }

  Widget _buildReviews(CourseModel course) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Ulasan',
          style: FontTheme.poppins14w700black(),
        ),
        const HeightSpace(8),
        const Divider(
          height: 1,
          thickness: 1,
          color: Color(0xFFE0E0E0),
        ),
        const HeightSpace(12),
        _buildAllRatings(course),
        const HeightSpace(12),
        OnBuilder<ReviewCourseState>.all(
          listenTo: reviewCourseRM,
          onIdle: () => const CircleLoading(),
          onWaiting: () => const CircleLoading(),
          onError: (dynamic error, refresh) => Text(error.toString()),
          onData: (data) {
            if (data.reviews.isEmpty) {
              return Text(
                'Belum ada Ulasan',
                style: FontTheme.poppins12w500black(),
              );
            }
            return ListView.separated(
              physics: const ScrollPhysics(),
              shrinkWrap: true,
              itemCount: data.reviews.length >= 3 ? 3 : data.reviews.length,
              separatorBuilder: (c, i) {
                return const Divider();
              },
              itemBuilder: (c, i) {
                if (i == data.reviews.length) {
                  return const CircleLoading(
                    size: 25,
                  );
                }
                final review = data.reviews[data.reviews.length - i - 1];
                return ReviewCard(
                  review: review,
                  onLiked: () {
                    reviewCourseRM.state.like(review);
                  },
                );
              },
            );
          },
        ),
      ],
    );
  }

  Widget _buildAllRatings(CourseModel course) {
    return Row(
      children: [
        Column(
          children: [
            Center(
              child: Text(
                (course.ratingAverage ?? 0.0).toStringAsFixed(1),
                style: FontTheme.poppins36w700black(),
              ),
            ),
            const HeightSpace(8),
            StarRating(
              rating: course.ratingAverage ?? 0.0,
            ),
            const HeightSpace(4),
            Center(
              child: Text(
                '${course.reviewCount} Ulasan',
                style: FontTheme.poppins12w400black(),
              ),
            )
          ],
        ),
        const WidthSpace(32),
        Expanded(
          child: Column(
            children: [
              _buildRatingComponent(
                'Mudah dipahami',
                course.ratingUnderstandable,
              ),
              _buildRatingComponent(
                'Kesesuaian SKS',
                course.ratingFitToCredit,
              ),
              _buildRatingComponent(
                'Kesesuaian BRP',
                course.ratingFitToStudyBook,
              ),
              _buildRatingComponent(
                'Manfaat',
                course.ratingBeneficial,
              ),
              _buildRatingComponent(
                'Direkomendasikan',
                course.ratingRecommended,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildRatingComponent(String text, double? rating) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: FontTheme.poppins12w400black(),
          ),
          StarRating(rating: rating ?? 0),
        ],
      ),
    );
  }

  Widget _buildReviewBySelf() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Ulasan Kelas Ini',
          style: FontTheme.poppins14w700black(),
        ),
        const HeightSpace(8),
        const Divider(
          height: 1,
          thickness: 1,
          color: Color(0xFFE0E0E0),
        ),
        const HeightSpace(12),
        OnBuilder<ReviewCourseState>.all(
          listenTo: reviewCourseRM,
          onIdle: () => const CircleLoading(),
          onWaiting: () => const CircleLoading(),
          onError: (dynamic error, refresh) => Text(error.toString()),
          onData: (data) {
            if (data.myReviews.isEmpty) {
              return Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Ceritakan pengalaman kamu selama menjalani kelas ini',
                      style: FontTheme.poppins12w400black(),
                    ),
                  ),
                  TulisUlasanButton(
                    onTap: () {
                      if (courseDetailRM.isDone && courseDetailRM.hasData) {
                        nav.goToReviewMatkulFormPage(
                          course: courseDetailRM.state.detailCourse,
                        );
                      }
                    },
                  )
                ],
              );
            }
            return ListView.separated(
              physics: const ScrollPhysics(),
              shrinkWrap: true,
              itemCount: data.myReviews.length,
              separatorBuilder: (c, i) {
                return const Divider();
              },
              itemBuilder: (c, i) {
                final review = data.myReviews[i];
                return ReviewCard(
                  review: review,
                  status: review.hateSpeechStatus,
                );
              },
            );
          },
        ),
        const HeightSpace(32),
      ],
    );
  }

  Widget _buildMatkulPrerequisite(CourseModel course) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Mata Kuliah Prasyarat',
          style: FontTheme.poppins14w700black(),
        ),
        const HeightSpace(8),
        const Divider(
          height: 1,
          thickness: 1,
          color: Color(0xFFE0E0E0),
        ),
        const HeightSpace(12),
        if (course.prerequisites?.isNotEmpty ?? false)
          Padding(
            padding: const EdgeInsets.only(left: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: course.prerequisites!
                  .split(',')
                  .map(
                    (e) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2),
                      child: Text(
                        '\u2022  $e',
                        style: FontTheme.poppins12w400black(),
                      ),
                    ),
                  )
                  .toList(),
            ),
          )
        else
          Text(
            'Tidak ada prasyarat',
            style: FontTheme.poppins12w500black(),
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
    return true;
  }
}
