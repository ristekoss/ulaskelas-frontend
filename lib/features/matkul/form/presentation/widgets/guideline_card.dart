part of '_widgets.dart';

class GuidelineCard extends StatelessWidget {
  const GuidelineCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      color: BaseColors.primaryColor,
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(12),
            child: ListTile(
              leading: const Icon(
                Icons.lightbulb_outline_rounded,
                size: 30,
                color: BaseColors.white,
              ),
              title: RichText(
                text: TextSpan(
                  style: FontTheme.poppins10w600white(),
                  children: <TextSpan>[
                    const TextSpan(
                      text: 'Sebelum menuliskan review, pastikan kamu sudah '
                          'membaca aturan yang berlaku dalam UlasKelas ',
                    ),
                    TextSpan(
                      text: 'di sini',
                      style: FontTheme.poppins10w600white().copyWith(
                        decoration: TextDecoration.underline,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          nav.goToGuidelinePage();
                        },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
