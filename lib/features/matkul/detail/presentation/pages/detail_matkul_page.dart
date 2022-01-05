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
      (s) => s.retrieveData(QueryReview(courseCode: widget.course.code!)),
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
    // final ownedReview = reviewRM.state.findOwnedReview(widget.matkul);
    return Column(
      children: [
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(24),
            children: [
              // Title + BookmarkIcon
              _buildTitleAndBookmark(context),
              const HeightSpace(24),

              _buildMatkulTag(),
              const HeightSpace(16),

              _buildMatkulDescription(),
              const HeightSpace(32),
              // ~~~~~~~~~~~~~~~~~~~~~~~~~
              _buildMatkulPrerequisite(),
              const HeightSpace(32),

              // ~~~~~~~~~~~~~~~~~~~~~~~~~
              // if (ownedReview != null) _buildReviewBySelf(ownedReview),

              _buildReviews(),
            ],
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
      widget.course.description.toString(),
      textAlign: TextAlign.justify,
      style: FontTheme.poppins12w400black(),
    );
  }

  Widget _buildMatkulTag() {
    return Row(
      children: const [
        Tag(
          label: 'Tags here',
        ),
        WidthSpace(8),
        Tag(
          label: 'Tags here',
        ),
        WidthSpace(8),
        Tag(
          label: 'Tags here',
        ),
      ],
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
                    // TODO(bim): bookmark matkul
                    // bookmarkRM.setState((s) => s.tapMark(widget.matkul));
                    // if (bookmarkRM.state.isMarked(widget.matkul)) {
                    //   SuccessMessenger('Mata kuliah berhasil disimpan')
                    //       .show(context);
                    // }
                  },
                  child: const Icon(
                    Icons.bookmark,
                    // color: bookmarkRM.state.isMarked(widget.matkul)
                    //     ? BaseColors.goldenrod
                    //     : BaseColors.gray3,
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
            return ListView.separated(
              shrinkWrap: true,
              itemCount: data.reviews.length,
              separatorBuilder: (c, i) {
                return const Divider();
              },
              itemBuilder: (c, i) {
                final review = data.reviews[i];
                return ReviewCard(
                  review: review,
                );
              },
            );
            return Container();
          },
        ),
        // OnReactive(() {
        //   return Column(
        //     crossAxisAlignment: CrossAxisAlignment.start,
        //     children: reviewRM.state.reviews[widget.matkul]?.map((rev) {
        //           if (rev.author != reviewRM.state.thisAuthor) {
        //             return ReviewCard(
        //               name: rev.author!,
        //               major: 'Ilmu Komputer',
        //               year: '2018',
        //               classTakenOn: rev.classTakenOn!,
        //               description: rev.description!,
        //               likesCount: rev.likesCount!,
        //               reviewedOn: rev.reviewedOn!,
        //               likesCountColor:
        //                   reviewRM.state.isLiked(widget.matkul, rev)
        //                       ? BaseColors.purpleHearth
        //                       : BaseColors.gray1,
        //               thumbIconColor: reviewRM.state.isLiked
        //               (widget.matkul, rev)
        //                   ? BaseColors.purpleHearth
        //                   : BaseColors.gray3,
        //               imgUrl: 'test',
        //               onLiked: () {
        //                 reviewRM.setState((s) =>
        //                 s.click(widget.matkul, rev));
        //               },
        //             );
        //           }
        //           return const SizedBox();
        //         }).toList() ??
        //         [],
        //   );
        // }),
      ],
    );
  }

  // Widget _buildReviewBySelf(ReviewModel ownedReview) {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       Text(
  //         'Ulasan Kamu',
  //         style: FontTheme.poppins14w700black(),
  //       ),
  //       const HeightSpace(8),
  //       const Divider(
  //         height: 1,
  //         thickness: 1,
  //         color: Color(0xFFE0E0E0),
  //       ),
  //       const HeightSpace(12),
  //       // OnReactive(() {
  //       //   return ReviewCard(
  //       //     name: ownedReview.author!,
  //       //     major: 'Sistem Informasi',
  //       //     year: '2019',
  //       //     classTakenOn: ownedReview.classTakenOn!,
  //       //     description: ownedReview.description!,
  //       //     likesCount: ownedReview.likesCount!,
  //       //     reviewedOn: ownedReview.reviewedOn!,
  //       //     likesCountColor: reviewRM.state.isLiked(widget.matkul, ownedReview)
  //       //         ? BaseColors.purpleHearth
  //       //         : BaseColors.gray1,
  //       //     thumbIconColor: reviewRM.state.isLiked(widget.matkul, ownedReview)
  //       //         ? BaseColors.purpleHearth
  //       //         : BaseColors.gray3,
  //       //     status: ownedReview.status,
  //       //     onLiked: () {
  //       //       reviewRM.setState((s) => s.click(widget.matkul, ownedReview));
  //       //     },
  //       //   );
  //       // }),
  //       const HeightSpace(32),
  //     ],
  //   );
  // }

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
                        '\u2022  Statistika dan Probabilitas',
                        style: FontTheme.poppins12w400black(),
                      ),
                    ),
                  )
                  .toList(),
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
    return true;
  }
}
