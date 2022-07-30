part of '_widgets.dart';

class TulisUlasanButton extends StatelessWidget {
  const TulisUlasanButton({
    Key? key,
    required this.onTap,
    this.isLoading = false,
    this.text = 'Tulis Ulasan',
  }) : super(key: key);

  final VoidCallback onTap;
  final bool isLoading;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 16),
      child: AutoLayoutButton(
        text: text,
        isLoading: isLoading,
        onTap: onTap,
      ),
    );
  }
}
