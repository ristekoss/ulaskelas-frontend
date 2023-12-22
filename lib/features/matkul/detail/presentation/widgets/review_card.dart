part of '_widgets.dart';

class ReviewCard extends StatelessWidget {
  const ReviewCard({
    required this.review,
    super.key,
    this.imgUrl,
    this.onLiked,
    this.status,
  });

  final ReviewModel review;
  final String? imgUrl;
  final VoidCallback? onLiked;
  final String? status;

  @override
  Widget build(BuildContext context) {
    final imgDummy = 'https://pbs.twimg.com/media/EtvfOFTWYAc3j1q.jpg';
    final color = GlobalState.theme().state.secondaryColor;
    final formattedDate = DateFormat('dd/MM/yyyy').format(review.createdAt!);

    return Container(
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 40,
                height: 40,
                child: (imgUrl != null)
                    ? Padding(
                        padding: const EdgeInsets.all(3),
                        child: CircleAvatar(
                          backgroundColor: color,
                          backgroundImage: NetworkImage(imgDummy),
                        ),
                      )
                    : const Icon(
                        Icons.account_circle,
                        size: 39,
                        color: Color(0xFFBDBDBD),
                      ),
              ),
              const SizedBox(
                width: 12,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(
                          child: Text(
                            review.author.toString(),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: FontTheme.poppins14w600black(),
                          ),
                        ),
                        const WidthSpace(10),
                        if (status != null)
                          Tag(
                            label: status!,
                            state: status == 'APPROVED'
                                ? TagStatus.approved
                                : (status == 'WAITING')
                                    ? TagStatus.pending
                                    : TagStatus.rejected,
                          ),
                        if (status == null &&
                            review.rankTop20 != null &&
                            review.rankTop20! > 0 &&
                            review.rankTop20! < 21)
                          TagLeaderboard(
                            rank: review.rankTop20,
                          ),
                      ],
                    ),
                    Text(
                      '${review.authorStudyProgram} ${review.authorGeneration}',
                      style: FontTheme.poppins12w400black(),
                    ),
                  ],
                ),
              ),
              if (review.user != profileRM.state.profile.id)
                PopupMenu(
                  username: review.author.toString(),
                  isAnonymous: review.isAnonym ?? false,
                  review: review,
                ),
              Container(),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          Row(
            children: [
              StarRating(
                rating: review.ratingAverage ?? 0,
              ),
              const SizedBox(
                width: 8,
              ),
              Text(
                'Diulas pada $formattedDate',
                style: FontTheme.poppins12w400black().copyWith(
                  color: BaseColors.gray2,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          if (review.tags?.isNotEmpty ?? false) ...[
            Row(
              children: review.tags!
                  .map(
                    (e) => Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Tag(
                        label: e,
                      ),
                    ),
                  )
                  .toList(),
            ),
            const SizedBox(
              height: 8,
            ),
          ],
          const SizedBox(
            height: 4,
          ),
          Text(
            '''Semester mengambil: ${review.semester == 1 ? 'Ganjil' : 'Genap'} ${review.academicYear}''',
            style: FontTheme.poppins12w700black().copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            review.content.toString(),
            textAlign: TextAlign.justify,
            style: FontTheme.poppins12w500black(),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: onLiked,
                child: Icon(
                  Icons.thumb_up,
                  size: 22,
                  color: review.isLiked ?? false
                      ? BaseColors.primaryColor
                      : BaseColors.gray3,
                ),
              ),
              Container(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  review.likesCount.toString(),
                  style: FontTheme.poppins14w600black().copyWith(
                      // color: likesCountColor,
                      ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class PopupMenu extends StatelessWidget {
  const PopupMenu({
    required this.username,
    required this.review,
    super.key,
    this.isAnonymous = false,
  });

  final String username;
  final bool isAnonymous;
  final ReviewModel review;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<int>(
      padding: EdgeInsets.zero,
      iconSize: 18,
      onSelected: (value) => _onSelected(context, value, review),
      itemBuilder: (context) => [
        _buildItem(
          value: 1,
          icon: Feather.trash_2,
          text: 'Report',
        ),
      ],
    );
  }

  PopupMenuItem<int> _buildItem({
    required int value,
    required IconData icon,
    required String text,
  }) {
    return PopupMenuItem(
      value: value,
      height: 32,
      child: Row(
        children: [
          Icon(
            icon,
            color: BaseColors.mineShaft,
            size: 16,
          ),
          const SizedBox(width: 8),
          Text(
            text,
            style: FontTheme.poppins12w400black().apply(
              color: BaseColors.mineShaft,
            ),
          ),
        ],
      ),
    );
  }

  void _onSelected(BuildContext context, int value, ReviewModel review) {
    switch (value) {
      case 1:
        MixpanelService.track(
          'report_review',
          params: {
            'course_id': review.courseCode.toString(),
            'course_name': review.courseName.toString(),
            'previous_likes': review.likesCount.toString(),
            'score_given_by_review': review.courseReviewCount.toString(),
          },
        );
        LaunchServices.openEmail(
          'team@ristek.cs.ui.ac.id',
          '''
Report User Content for ${isAnonymous ? 'Review id ${review.id}' : username}''',
          'enter report message',
        );
      default:
    }
  }
}
