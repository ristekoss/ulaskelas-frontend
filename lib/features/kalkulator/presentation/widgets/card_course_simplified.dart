part of '_widgets.dart';

class CardCourseSimplified extends StatelessWidget {
  const CardCourseSimplified({
    required this.model, super.key,
    this.onTap,
  });

  final CourseModel model;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 12,
        ),
        decoration: BoxDecoration(
          color: BaseColors.white,
          boxShadow: BoxShadowDecorator().defaultShadow(context),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.name.toString(),
                    style: FontTheme.poppins12w400black(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
