part of '_pages.dart';

class HomeDaftarMatkulPage extends StatefulWidget {
  const HomeDaftarMatkulPage({
    Key? key,
  }) : super(key: key);

  @override
  _HomeDaftarMatkulPageState createState() => _HomeDaftarMatkulPageState();
}

class _HomeDaftarMatkulPageState extends BaseStateful<HomeDaftarMatkulPage> {
  @override
  PreferredSizeWidget? buildAppBar(BuildContext context) {
    return BaseAppBar(
      label: 'Mata Kuliah Semester 5',
      elevation: 0,
    );
  }

  @override
  ScaffoldAttribute buildAttribute() {
    return ScaffoldAttribute();
  }

  @override
  Widget buildNarrowLayout(BuildContext context, SizingInformation sizeInfo) {
    return SingleChildScrollView(
      child: ListView.separated(
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        itemCount: DummyMatkul.matkul.length,
        separatorBuilder: (c, i) => const HeightSpace(16),
        itemBuilder: (c, i) {
          final matkul = DummyMatkul.matkul[i];
          return CardMatkulHome(model: matkul, onTap: () {});
        },
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
