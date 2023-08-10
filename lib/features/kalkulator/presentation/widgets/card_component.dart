part of '_widgets.dart';

class CardCompononent extends StatelessWidget {
  const CardCompononent({
    required this.id,
    required this.name,
    required this.score,
    required this.weight,
    super.key,
    this.onTap,
  });

  final int id;
  final String name;
  final double score;
  final double weight;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: GestureDetector(
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
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: FontTheme.poppins12w400black(),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Text(
                  score.toStringAsFixed(2),
                  style: FontTheme.poppins12w400black(),
                  textAlign: TextAlign.right,
                ),
              ),
              Expanded(
                child: Text(
                  '${weight.toStringAsFixed(1)}%',
                  style: FontTheme.poppins12w400black(),
                  textAlign: TextAlign.right,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
