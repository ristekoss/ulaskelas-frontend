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
  @override
  void init() {
    // courseDetailRM.setState((s) => s.retrieveData(widget.courseId));
    // reviewCourseRM.setState(
    //   (s) => s.retrieveData(QueryReview(courseCode: widget.courseCode)),
    // );
    StateInitializer(
      rIndicator: refreshIndicatorKey!,
      cacheKey: 'detail-course',
      state: false,
    ).initialize();
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
                  padding: const EdgeInsets.all(24),
                  children: [
                    _buildTitleAndBookmark(course),
                    const HeightSpace(24),
                    if (course.tags?.isNotEmpty ?? false)
                      _buildMatkulTag(course),
                    const HeightSpace(16),
                    _buildMatkulDescription(course),
                    const HeightSpace(32),
                    _buildMatkulPrerequisite(course),
                    const HeightSpace(32),
                    _buildReviewBySelf(),
                    _buildReviews(),
                  ],
                );
              },
            ),
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

  Widget _buildMatkulDescription(CourseModel course) {
    return Text(
      course.cleanedDesc,
      textAlign: TextAlign.justify,
      style: FontTheme.poppins12w400black(),
    );
  }

  Widget _buildMatkulTag(CourseModel course) {
    return Row(
      children: course.tags!
          .map(
            (e) => Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Tag(
                label: e,
              ),
            ),
          )
          .toList(),
    );
  }

  Widget _buildTitleAndBookmark(CourseModel course) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Text(
                course.name.toString(),
                style: FontTheme.poppins20w700black(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: OnReactive(() {
                return GestureDetector(
                  onTap: () {
                    final bookmark = BookmarkModel(
                      courseId: course.id,
                      courseCode: course.code,
                      courseName: course.name,
                      courseCodeDesc: course.codeDesc,
                      courseReviewCount: course.reviewCount,
                      shortName: course.shortName,
                    );
                    bookmarkRM.setState((s) => s.toggleBookmark(bookmark));
                  },
                  child: Icon(
                    Icons.bookmark,
                    color: bookmarkRM.state.isMarked(course)
                        ? BaseColors.goldenrod
                        : BaseColors.gray3,
                  ),
                );
              }),
            ),
          ],
        ),
        const HeightSpace(8),
        Text(
          course.describe,
          style: FontTheme.poppins16w500black(),
        ),
      ],
    );
  }

  Widget _buildReviews() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Semua Ulasan',
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
            if (data.reviews.isEmpty) {
              return Text(
                'Belum ada Ulasan',
                style: FontTheme.poppins12w500black(),
              );
            }
            return ListView.separated(
              physics: const ScrollPhysics(),
              shrinkWrap: true,
              itemCount: data.reviews.length,
              separatorBuilder: (c, i) {
                return const Divider();
              },
              itemBuilder: (c, i) {
                final review = data.reviews[i];
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

  Widget _buildReviewBySelf() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Ulasan Kamu',
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
              return Text(
                'Belum ada Ulasan',
                style: FontTheme.poppins12w500black(),
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
