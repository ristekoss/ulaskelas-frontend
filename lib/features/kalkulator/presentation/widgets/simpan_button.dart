part of '_widgets.dart';

class SimpanButton extends StatelessWidget {
  const SimpanButton({
    required this.onTap, required this.text, super.key,
    this.isLoading = false,
  });

  final VoidCallback onTap;
  final String text;
  final bool isLoading;

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
        text: text,
        isLoading: isLoading,
        onTap: onTap,
      ),
    );
  }
}
