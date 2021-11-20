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
    return OnReactive(() {
      final ownedReview = review.state.findOwnedReview(widget.matkul);

      return Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(24),
              children: [
                // Title + BookmarkIcon
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      child: Text(
                        widget.matkul,
                        style: FontTheme.poppins20w700black(),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: const Icon(
                        Icons.bookmark,
                        color: Color(0xFFBDBDBD),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  'CSIE604273  •  4 SKS  •  Wajib SI',
                  style: FontTheme.poppins16w500black(),
                ),
                const SizedBox(
                  height: 24,
                ),
                Row(
                  children: const [
                    Tag(
                      label: 'Tags here',
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Tag(
                      label: 'Tags here',
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Tag(
                      label: 'Tags here',
                    ),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                Text(
                  lorem,
                  textAlign: TextAlign.justify,
                  style: FontTheme.poppins12w400black(),
                ),
                const SizedBox(
                  height: 32,
                ),
                // ~~~~~~~~~~~~~~~~~~~~~~~~~
                Text(
                  'Mata Kuliah Prasyarat',
                  style: FontTheme.poppins14w700black(),
                ),
                const SizedBox(
                  height: 8,
                ),
                const Divider(
                  height: 1,
                  thickness: 1,
                  color: Color(0xFFE0E0E0),
                ),
                const SizedBox(
                  height: 12,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '\u2022  Statistika dan Probabilitas',
                        style: FontTheme.poppins12w400black(),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Text(
                        '\u2022  Basis Data',
                        style: FontTheme.poppins12w400black(),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 32,
                ),

                // ~~~~~~~~~~~~~~~~~~~~~~~~~
                if (!ownedReview!.isEmpty())
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Ulasan Kamu',
                        style: FontTheme.poppins14w700black(),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      const Divider(
                        height: 1,
                        thickness: 1,
                        color: Color(0xFFE0E0E0),
                      ),
                      const SizedBox(
                        height: 12,
                      ),

                      // Review Card
                      ReviewCard(
                          name: ownedReview.author!,
                          major: 'Sistem Informasi',
                          year: '2019',
                          classTakenOn: ownedReview.classTakenOn!,
                          description: 'Lorem ipsum dolor sit amet, adisplis '
                              'consectetur adipiscing elit, sed do '
                              'eiusmod tempor incididun ut labore et '
                              'dolore magna aliqua. Ut enim ad minim veniam, '
                              'quis nostrud exercitation ullamco laboris '
                              'nisi ut aliquip ex ea commodot.',
                          likesCount: ownedReview.likesCount!,
                          reviewedOn: DateTime(2021, 9, 10),
                          likesCountColor:
                              review.state.isLiked(widget.matkul, ownedReview)
                                  ? BaseColors.purpleHearth
                                  : BaseColors.gray1,
                          thumbIconColor:
                              review.state.isLiked(widget.matkul, ownedReview)
                                  ? BaseColors.purpleHearth
                                  : BaseColors.gray3,
                          onLiked: () {
                            review.setState(
                                (s) => s.click(widget.matkul, ownedReview));
                          }),
                      const SizedBox(
                        height: 32,
                      ),
                    ],
                  ),

                Text(
                  'Semua Ulasan',
                  style: FontTheme.poppins14w700black(),
                ),
                const SizedBox(
                  height: 8,
                ),
                const Divider(
                  height: 1,
                  thickness: 1,
                  color: Color(0xFFE0E0E0),
                ),
                const SizedBox(
                  height: 12,
                ),

                ...review.state.reviews[widget.matkul]!.map((rev) {
                  if (rev.author != review.state.thisAuthor) {
                    return ReviewCard(
                      name: rev.author!,
                      major: 'Ilmu Komputer',
                      year: '2018',
                      classTakenOn: rev.classTakenOn!,
                      description: 'Lorem ipsum dolor sit amet, adisplis '
                          'consectetur adipiscing elit, sed do '
                          'eiusmod tempor incididun ut labore et '
                          'dolore magna aliqua. Ut enim ad minim veniam, '
                          'quis nostrud exercitation ullamco laboris '
                          'nisi ut aliquip ex ea commodot.',
                      likesCount: rev.likesCount!,
                      reviewedOn: DateTime(2021, 9, 10),
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
                }).toList(),
              ],
            ),
          ),
          Container(
            padding:
                const EdgeInsets.only(top: 12, left: 24, right: 24, bottom: 24),
            decoration: const BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, 0.05),
                  blurRadius: 4,
                  offset: Offset(0, -2),
                )
              ],
            ),
            child: AutoLayoutButton(
              text: 'Tulis Ulasan',
              onTap: () {
                nav.goToReviewMatkulPage();
              },
            ),
          )
        ],
      );
    });
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
