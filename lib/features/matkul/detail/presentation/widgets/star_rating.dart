part of '_widgets.dart';

class StarRating extends StatelessWidget {
  final int starCount;
  final double rating;
  final RatingChangeCallback? onRatingChanged;
  final double starSize;
  final double paddingSize;

  const StarRating({
    Key? key,
    this.starCount = 5,
    this.rating = .0,
    this.onRatingChanged,
    this.starSize = 16,
    this.paddingSize = 0,
  }) : super(key: key);

  Widget buildStar(BuildContext context, int index) {
    Icon icon;
    if (index >= rating) {
      icon = Icon(
        Icons.star,
        color: BaseColors.gray3,
        size: starSize,
      );
    } else if (index > rating - 1 && index < rating) {
      icon = Icon(
        Icons.star_half,
        color: BaseColors.purpleHearth,
        size: starSize,
      );
    } else {
      icon = Icon(
        Icons.star,
        color: BaseColors.purpleHearth,
        size: starSize,
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
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(
        starCount,
        (index) => buildStar(context, index),
      ),
    );
  }
}

typedef void RatingChangeCallback(double rating);
