// Created by Muhamad Fauzi Ridwan on 07/11/21.

part of '_widgets.dart';

class CardCourse extends StatelessWidget {
  const CardCourse({
    required this.model, super.key,
    this.onTap,
  });

  final CourseModel model;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
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
            Container(
              height: 50,
              width: 50,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: theme.colorScheme.primary.withOpacity(.15),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Text(
                  model.shortName.toString(),
                  style: FontTheme.poppins14w700black().copyWith(
                    color: theme.colorScheme.primary,
                  ),
                ),
              ),
            ),
            const WidthSpace(12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.name.toString(),
                    style: FontTheme.poppins14w700black().copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const HeightSpace(4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        model.codeDesc.toString(),
                        style: FontTheme.poppins12w400black(),
                      ),
                      Text(
                        '${model.reviewCount} Ulasan',
                        style: FontTheme.poppins12w400black().copyWith(
                          color: BaseColors.gray2,
                        ),
                      ),
                    ],
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
