part of '_pages.dart';

class AllReviewMatkulPage extends StatefulWidget {
  const AllReviewMatkulPage({
    required this.courseId, required this.courseCode, super.key,
  });

  final int courseId;
  final String courseCode;

  @override
  _AllReviewMatkulPageState createState() => _AllReviewMatkulPageState();
}

class _AllReviewMatkulPageState extends BaseStateful<AllReviewMatkulPage> {
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

  void _scrollToTop() {
    scrollController.animateTo(
      scrollController.position.minScrollExtent,
      duration: const Duration(seconds: 1),
      curve: Curves.fastOutSlowIn,
    );
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
  }

  @override
  ScaffoldAttribute buildAttribute() {
    return ScaffoldAttribute();
  }

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context) {
    return BaseAppBar(label: 'Semua Ulasan');
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
              onIdle: WaitingView.new,
              onWaiting: WaitingView.new,
              onError: (dynamic error, refresh) => const Text('error'),
              onData: (data) {
                final course = data.detailCourse;
                return Stack(
                  children: [
                    ListView(
                      shrinkWrap: true,
                      controller: scrollController,
                      padding: const EdgeInsets.all(24),
                      children: [
                        TitleAndBookMark(course: course),
                        const HeightSpace(24),
                        _buildReviews(),
                      ],
                    ),
                    Positioned(
                      right: 24,
                      bottom: 16,
                      child: FloatingActionButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        backgroundColor: BaseColors.purpleHearth,
                        foregroundColor: BaseColors.white,
                        mini: true,
                        onPressed: _scrollToTop,
                        child: const Icon(
                          Icons.expand_less_rounded,
                          size: 28,
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.only(left: 24, right: 24, bottom: 24),
          decoration: const BoxDecoration(
            color: BaseColors.white,
            boxShadow: [
              BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.05),
                blurRadius: 4,
                offset: Offset(0, -2),
              ),
            ],
          ),
          child: TulisUlasanButton(
            onTap: () {
              if (courseDetailRM.isDone && courseDetailRM.hasData) {
                nav.goToReviewMatkulFormPage(
                  course: courseDetailRM.state.detailCourse,
                );
              }
            },
          ),
        ),
      ],
    );
  }

  Widget _buildReviews() {
    return OnBuilder<ReviewCourseState>.all(
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
          itemCount: data.hasReachedMax
              ? data.reviews.length
              : data.reviews.length + 1,
          separatorBuilder: (c, i) {
            return const Divider();
          },
          itemBuilder: (c, i) {
            if (!data.hasReachedMax && i == data.reviews.length) {
              return const CircleLoading(
                size: 25,
              );
            }
            final review = data.reviews[data.reviews.length - i - 1];
            return Padding(
              padding: EdgeInsets.only(
                bottom: data.hasReachedMax ? 32.0 : 0,
              ),
              child: ReviewCard(
                review: review,
                onLiked: () {
                  reviewCourseRM.state.like(review);
                },
              ),
            );
          },
        );
      },
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
