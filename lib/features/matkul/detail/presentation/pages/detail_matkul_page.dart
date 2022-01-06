// Created by Muhamad Fauzi Ridwan on 08/11/21.

part of '_pages.dart';

// TODO(bim): route to review widget.matkul use
/// ```dart
/// nav.push<void>(ReviewMatkulPage, RouteName.reviewMatkul,);
/// ```;
class DetailMatkulPage extends StatefulWidget {
  const DetailMatkulPage({Key? key, required this.course}) : super(key: key);

  final CourseModel course;

  @override
  _DetailMatkulPageState createState() => _DetailMatkulPageState();
}

class _DetailMatkulPageState extends BaseStateful<DetailMatkulPage> {
  @override
  void init() {
    reviewCourseRM.setState(
      (s) => s.retrieveData(QueryReview(courseCode: widget.course.code)),
    );
  }

  Future<void> retrieveData() async {
    await reviewCourseRM.setState(
      (s) => s.retrieveData(QueryReview(courseCode: widget.course.code)),
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
            child: ListView(
              padding: const EdgeInsets.all(24),
              children: [
                // Title + BookmarkIcon
                _buildTitleAndBookmark(context),
                const HeightSpace(24),

                if (widget.course.tags?.isNotEmpty ?? false) _buildMatkulTag(),
                const HeightSpace(16),

                _buildMatkulDescription(),
                const HeightSpace(32),
                // ~~~~~~~~~~~~~~~~~~~~~~~~~
                _buildMatkulPrerequisite(),
                const HeightSpace(32),

                // ~~~~~~~~~~~~~~~~~~~~~~~~~
                _buildReviewBySelf(),
                _buildReviews(),
              ],
            ),
          ),
        ),
        TulisUlasanButton(
          onTap: () => nav.goToReviewMatkulFormPage(course: widget.course),
        )
      ],
    );
  }

  Widget _buildMatkulDescription() {
    return Text(
      widget.course.cleanedDesc,
      textAlign: TextAlign.justify,
      style: FontTheme.poppins12w400black(),
    );
  }

  Widget _buildMatkulTag() {
    return Row(
      children: widget.course.tags!
          .map(
            (e) => Tag(
              label: e,
            ),
          )
          .toList(),
    );
  }

  Widget _buildTitleAndBookmark(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Text(
                widget.course.name.toString(),
                style: FontTheme.poppins20w700black(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: OnReactive(() {
                return GestureDetector(
                  onTap: () {
                    final bookmark = BookmarkModel(
                      courseCode: widget.course.code,
                      courseName: widget.course.name,
                      courseCodeDesc: widget.course.codeDesc,
                      courseReviewCount: widget.course.reviewCount,
                      shortName: widget.course.shortName,
                    );
                    bookmarkRM.setState((s) => s.toggleBookmark(bookmark));
                  },
                  child: Icon(
                    Icons.bookmark,
                    color: bookmarkRM.state.isMarked(widget.course)
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
          widget.course.describe,
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
                );
              },
            );
          },
        ),
        const HeightSpace(32),
      ],
    );
  }

  Widget _buildMatkulPrerequisite() {
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
        if (widget.course.prerequisites?.isNotEmpty ?? false)
          Padding(
            padding: const EdgeInsets.only(left: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: widget.course.prerequisites!
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
