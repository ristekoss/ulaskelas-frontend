part of '_widgets.dart';

class TulisUlasanButton extends StatelessWidget {
  const TulisUlasanButton({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 12, left: 24, right: 24, bottom: 24),
      decoration: const BoxDecoration(
        color: BaseColors.white,
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.05),
            blurRadius: 4,
            offset: Offset(0, -2),
          )
        ],
      ),
      child: AutoLayoutButton(
        text: 'Tulis Ulasan',
        onTap: onTap,
      ),
    );
  }
}
