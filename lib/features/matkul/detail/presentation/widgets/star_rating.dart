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
    Widget icon;
    if (index >= rating) {
      icon = Icon(
        Icons.star_rounded,
        color: BaseColors.gray3,
        size: starSize,
      );
    } else if (index > rating - 1) {
      icon = HalfFilledIcon(
        icon: Icons.star_rounded,
        color: BaseColors.purpleHearth,
        size: starSize,
      );
    } else {
      icon = Icon(
        Icons.star_rounded,
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

typedef RatingChangeCallback = void Function(double rating);

class HalfFilledIcon extends StatelessWidget {
  final IconData icon;
  final double size;
  final Color color;

  const HalfFilledIcon({
    Key? key,
    required this.icon,
    required this.size,
    required this.color,
  }): super(key: key);

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcATop,
      shaderCallback: (Rect rect) {
        return LinearGradient(
          stops: const [0, 0.5, 0.5],
          colors: [color, color, color.withOpacity(0)],
        ).createShader(rect);
      },
      child: SizedBox(
        width: size,
        height: size,
        child: Icon(
          icon,
          size: size,
          color: BaseColors.gray3,
        ),
      ),
    );
  }
}
