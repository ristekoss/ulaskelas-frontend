part of '_widgets.dart';

class RatingComponent extends StatelessWidget {
  const RatingComponent({
    Key? key,
    required this.text,
    required this.starRating,
  }) : super(key: key);

  final String text;
  final StarRating starRating;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 8,
        right: 16,
      ),
      child: Container(
        width: 277,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(
            color: BaseColors.gray3,
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(
              8,
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(
            16,
          ),
          child: Center(
            child: Column(
              children: [
                Text(
                  text,
                  style: FontTheme.poppins12w400black(),
                ),
                const HeightSpace(4),
                OnReactive(
                  () {
                    return starRating;
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
