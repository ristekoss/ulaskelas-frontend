part of '_widgets.dart';

class ReviewCard extends StatelessWidget {
  const ReviewCard({
    Key? key,
    required this.review,
    this.imgUrl,
    this.onLiked,
    this.status,
  }) : super(key: key);

  final ReviewModel review;
  final String? imgUrl;
  final VoidCallback? onLiked;
  final String? status;

  @override
  Widget build(BuildContext context) {
    final imgDummy = 'https://pbs.twimg.com/media/EtvfOFTWYAc3j1q.jpg';
    final color = GlobalState.theme().state.secondaryColor;
    // final formattedDate = DateFormat('dd/MM/yyyy').format(reviewedOn);

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
                        Flexible(
                          child: Text(
                            review.author.toString(),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: FontTheme.poppins14w600black(),
                          ),
                        ),
                        if (status == null)
                          Container()
                        else
                          Tag(
                            label: status!,
                            state: status == 'Approved'
                                ? TagStatus.approved
                                : (status == 'Pending')
                                    ? TagStatus.pending
                                    : TagStatus.rejected,
                          ),
                      ],
                    ),
                    // Text('$major $year', style: FontTheme.poppins12w400black())
                  ],
                ),
              )
            ],
          ),
          const SizedBox(
            height: 8,
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
            height: 12,
          ),
          Text(
            'Semester mengambil: classTakenOn',
            style: FontTheme.poppins12w500black().copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            review.content.toString(),
            textAlign: TextAlign.justify,
            style: FontTheme.poppins12w400black(),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Diulas pada formattedDate',
                style: FontTheme.poppins10w400black().copyWith(
                  color: const Color(0xFF828282),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // TODO(Any): change color &
                  GestureDetector(
                    onTap: onLiked,
                    child: Icon(
                      Icons.thumb_up,
                      size: 22,
                      // color: thumbIconColor,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      review.likesBy!.length.toString(),
                      style: FontTheme.poppins14w600black().copyWith(
                          // color: likesCountColor,
                          ),
                    ),
                  )
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
