part of '_widgets.dart';

class CardCalculator extends StatelessWidget {
  const CardCalculator({
    required this.model, super.key,
    this.onTap,
  });

  final CalculatorModel model;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          Container(
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
                        model.courseName.toString(),
                        style: FontTheme.poppins14w700black().copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const HeightSpace(4),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            _getFinalScoreAndGrade(model.totalScore!),
                            style: FontTheme.poppins12w400black(),
                          ),
                          Text(
                            '${model.totalPercentage?.toStringAsFixed(2)}%',
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
        ],
      ),
    );
  }
  String _getFinalScoreAndGrade(double score) {
    var grade = 'E';
    if (score >= 85) {
      grade = 'A';
    } else if (score >= 80) {
      grade = 'A-';
    } else if (score >= 75) {
      grade = 'B+';
    } else if (score >= 70) {
      grade = 'B';
    } else if (score >= 65) {
      grade = 'B-';
    } else if (score >= 60) {
      grade = 'C+';
    } else if (score >= 55) {
      grade = 'C';
    } else if (score >= 40) {
      grade = 'D';
    }
    return '$grade (${score.toStringAsFixed(2)})';
  }
}
