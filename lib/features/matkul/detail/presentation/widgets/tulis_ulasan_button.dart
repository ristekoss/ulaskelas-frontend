part of '_widgets.dart';

class TulisUlasanButton extends StatelessWidget {
  const TulisUlasanButton({
    Key? key,
    required this.onTap,
    this.isLoading = false,
  }) : super(key: key);

  final VoidCallback onTap;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 16),
      child: AutoLayoutButton(
        text: 'Tulis Ulasan',
        isLoading: isLoading,
        onTap: onTap,
      ),
    );
  }
}
