// Created by Muhamad Fauzi Ridwan on 08/11/21.

part of '_pages.dart';

// TODO(bim): route to review widget.matkul use
/// ```dart
/// nav.push<void>(ReviewMatkulPage, RouteName.reviewMatkul,);
/// ```;
class DetailMatkulPage extends StatefulWidget {
  const DetailMatkulPage({Key? key, required this.matkul}) : super(key: key);

  final String matkul;

  @override
  _DetailMatkulPageState createState() => _DetailMatkulPageState();
}

class _DetailMatkulPageState extends BaseStateful<DetailMatkulPage> {
  final String lorem = 'Lorem ipsum dolor sit amet, consectetur adipiscing '
      'elit, sed do eiusmod tempor incididunt ut labore et dolore magna '
      'aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco '
      'laboris nisi ut aliquip ex ea commodo consequat.';

  @override
  void init() {}

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
    final ownedReview = review.state.findOwnedReview(widget.matkul);
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
              if (!ownedReview!.isEmpty()) _buildReviewBySelf(ownedReview),

              _buildReviews(),
            ],
          ),
        ),
        TulisUlasanButton(
          onTap: () => nav.goToReviewMatkulFormPage(),
        )
      ],
    );
  }

  Widget _buildMatkulDescription() {
    return Text(
      lorem,
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
                widget.matkul,
                style: FontTheme.poppins20w700black(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: OnReactive(() {
                return GestureDetector(
                  onTap: () {
                    //TODO(bim): bookmark matkul
                    bookmark.setState((s) => s.tapMark(widget.matkul));
                    if (bookmark.state.isMarked(widget.matkul)) {
                      SuccessMessenger('Mata kuliah berhasil disimpan')
                          .show(context);
                    }
                  },
                  child: Icon(
                    Icons.bookmark,
                    color: bookmark.state.isMarked(widget.matkul)
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
          'CSIE604273  •  4 SKS  •  Wajib SI',
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
        OnReactive(() {
          return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: review.state.reviews[widget.matkul]!.map((rev) {
                if (rev.author != review.state.thisAuthor) {
                  return ReviewCard(
                    name: rev.author!,
                    major: 'Ilmu Komputer',
                    year: '2018',
                    classTakenOn: rev.classTakenOn!,
                    description: rev.description!,
                    likesCount: rev.likesCount!,
                    reviewedOn: rev.reviewedOn!,
                    likesCountColor: review.state.isLiked(widget.matkul, rev)
                        ? BaseColors.purpleHearth
                        : BaseColors.gray1,
                    thumbIconColor: review.state.isLiked(widget.matkul, rev)
                        ? BaseColors.purpleHearth
                        : BaseColors.gray3,
                    imgUrl: 'test',
                    onLiked: () {
                      review.setState((s) => s.click(widget.matkul, rev));
                    },
                  );
                }
                return const SizedBox();
              }).toList());
        }),
      ],
    );
  }

  Widget _buildReviewBySelf(ReviewModel ownedReview) {
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
        OnReactive(() {
          return ReviewCard(
              name: ownedReview.author!,
              major: 'Sistem Informasi',
              year: '2019',
              classTakenOn: ownedReview.classTakenOn!,
              description: ownedReview.description!,
              likesCount: ownedReview.likesCount!,
              reviewedOn: ownedReview.reviewedOn!,
              likesCountColor: review.state.isLiked(widget.matkul, ownedReview)
                  ? BaseColors.purpleHearth
                  : BaseColors.gray1,
              thumbIconColor: review.state.isLiked(widget.matkul, ownedReview)
                  ? BaseColors.purpleHearth
                  : BaseColors.gray3,
              status: ownedReview.status,
              onLiked: () {
                review.setState((s) => s.click(widget.matkul, ownedReview));
              });
        }),
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
        Padding(
          padding: const EdgeInsets.only(left: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '\u2022  Statistika dan Probabilitas',
                style: FontTheme.poppins12w400black(),
              ),
              const HeightSpace(4),
              Text(
                '\u2022  Basis Data',
                style: FontTheme.poppins12w400black(),
              )
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
    return true;
  }
}
