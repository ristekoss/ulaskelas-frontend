part of '_widgets.dart';

class StarRating extends StatelessWidget {
  final int starCount;
  final double rating;
  final RatingChangeCallback? onRatingChanged;

  const StarRating({
    Key? key,
    this.starCount = 5,
    this.rating = .0,
    this.onRatingChanged,
  }) : super(key: key);

  Widget buildStar(BuildContext context, int index) {
    Icon icon;
    if (index >= rating) {
      icon = const Icon(
        Icons.star,
        color: BaseColors.gray2,
        size: 16,
      );
    } else if (index > rating - 1 && index < rating) {
      icon = const Icon(
        Icons.star_half,
        color: BaseColors.purpleHearth,
        size: 16,
      );
    } else {
      icon = const Icon(
        Icons.star,
        color: BaseColors.purpleHearth,
        size: 16,
      );
    }
    return InkResponse(
      onTap:
          onRatingChanged == null ? null : () => onRatingChanged!(index + 1.0),
      child: icon,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(
        starCount,
        (index) => buildStar(context, index),
      ),
    );
  }
}

typedef void RatingChangeCallback(double rating);
