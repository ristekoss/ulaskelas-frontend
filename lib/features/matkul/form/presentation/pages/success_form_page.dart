part of '_pages.dart';

class SuccessFormPage extends StatefulWidget {
  const SuccessFormPage({super.key});

  @override
  _SuccessFormPageState createState() => _SuccessFormPageState();
}

class _SuccessFormPageState extends BaseStateful<SuccessFormPage> {
  @override
  PreferredSizeWidget? buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: BaseColors.white,
      automaticallyImplyLeading: false,
      elevation: 0,
    );
  }

  @override
  ScaffoldAttribute buildAttribute() {
    return ScaffoldAttribute();
  }

  @override
  Widget buildNarrowLayout(BuildContext context, SizingInformation sizeInfo) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              Ilustration.processing,
              width: sizeInfo.screenSize.width * .6,
            ),
            const HeightSpace(24),
            Text(
              'Ulasan Kamu Sedang Ditinjau',
              style: FontTheme.poppins16w700black(),
            ),
            const HeightSpace(8),
            Text(
              'Ulasan kamu sedang ditinjau kembali oleh sistem kami. Kamu '
              'dapat melihat status tinjauan tersebut di riwayat ulasanmu.',
              textAlign: TextAlign.center,
              style: FontTheme.poppins14w400black(),
            ),
            const HeightSpace(48),
            PrimaryButton(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
              text: 'Kembali ke Detail Mata Kuliah',
              onPressed: () {
                nav.pop();
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget buildWideLayout(BuildContext context, SizingInformation sizeInfo) {
    return buildNarrowLayout(context, sizeInfo);
  }

  @override
  void init() {}

  @override
  Future<bool> onBackPressed() async {
    return true;
  }
}
