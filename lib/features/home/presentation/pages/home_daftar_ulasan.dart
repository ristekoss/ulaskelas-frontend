part of '_pages.dart';

class HomeDaftarUlasan extends StatefulWidget {
  const HomeDaftarUlasan({
    Key? key,
  }) : super(key: key);

  @override
  _HomeDaftarUlasanState createState() => _HomeDaftarUlasanState();
}

class _HomeDaftarUlasanState extends BaseStateful<HomeDaftarUlasan> {
  @override
  PreferredSizeWidget? buildAppBar(BuildContext context) {
    return BaseAppBar(
      label: 'Riwayat Ulasanmu',
      elevation: 0,
    );
  }

  @override
  ScaffoldAttribute buildAttribute() {
    // TODO: implement buildAttribute
    return ScaffoldAttribute();
  }

  @override
  Widget buildNarrowLayout(BuildContext context, SizingInformation sizeInfo) {
    // TODO: implement buildNarrowLayout
    return SingleChildScrollView(
      child: ListView.separated(
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        itemCount: DummyUlasan.ulasan.length,
        separatorBuilder: (c, i) => const HeightSpace(16),
        itemBuilder: (c, i) {
          final ulasan = DummyUlasan.ulasan[i];
          return CardMatkulReview(model: ulasan, onTap: () {});
        },
      ),
    );
  }

  @override
  Widget buildWideLayout(BuildContext context, SizingInformation sizeInfo) {
    // TODO: implement buildWideLayout
    return buildNarrowLayout(context, sizeInfo);
  }

  @override
  void init() {}

  @override
  Future<bool> onBackPressed() async {
    return true;
  }
}
