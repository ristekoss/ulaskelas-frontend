// Created by Muhamad Fauzi Ridwan on 08/11/21.

part of '_pages.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    required this.onSeeAllCourse,
    Key? key,
  }) : super(key: key);

  final VoidCallback onSeeAllCourse;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends BaseStateful<HomePage> {
  @override
  void init() {}

  @override
  ScaffoldAttribute buildAttribute() {
    return ScaffoldAttribute();
  }

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: BaseColors.white,
      title: Container(
        width: MediaQuery.of(context).size.width / 3,
        padding: const EdgeInsets.only(left: 10),
        child: Image.asset(
          ImageConst.primaryLogo,
          fit: BoxFit.fitWidth,
        ),
      ),
      centerTitle: false,
      elevation: 0,
    );
  }

  @override
  Widget buildNarrowLayout(
    BuildContext context,
    SizingInformation sizeInfo,
  ) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(
              left: 20,
              right: 20,
              bottom: 10,
            ),
            alignment: Alignment.centerLeft,
            child: Text(
              'Hi, Raihan Fikriansyah!',
              style: FontTheme.poppins20w700black(),
            ),
          ),
          Container(
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(6)),
                border: Border.all(color: BaseColors.primary, width: 2)),
            margin: const EdgeInsets.all(20),
            child: InkWell(
              onTap: () => widget.onSeeAllCourse.call(),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.list_alt_outlined,
                          color: BaseColors.primaryColor,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Lihat Semua Mata Kuliah',
                          style: FontTheme.poppins14w400purple(),
                        )
                      ],
                    ),
                    Icon(
                      Icons.keyboard_arrow_right,
                      color: BaseColors.primaryColor,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: SizedBox(
              height: 40,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Mata Kuliah Semester 5',
                    style: FontTheme.poppins14w700black(),
                  ),
                  InkWell(
                    onTap: () => nav.goToHomeDaftarMatkul(),
                    child: Text(
                      'Lihat Semua',
                      style: FontTheme.poppins13w400purple(),
                    ),
                  )
                ],
              ),
            ),
          ),
          ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 10,
            ),
            itemCount: 3,
            separatorBuilder: (c, i) => const HeightSpace(16),
            itemBuilder: (c, i) {
              final matkul = DummyMatkul.matkul[i];
              if (matkul.semester == 5) {
                return CardMatkulHome(model: matkul, onTap: () {});
              }
              return Container(
                height: 0,
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: SizedBox(
              height: 40,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Riwayat Ulasanmu',
                    style: FontTheme.poppins14w700black(),
                  ),
                  InkWell(
                    onTap: () => nav.goToHomeDaftarUlasan(),
                    child: Text(
                      'Lihat Semua',
                      style: FontTheme.poppins13w400purple(),
                    ),
                  )
                ],
              ),
            ),
          ),
          ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 10,
            ),
            itemCount: 3,
            separatorBuilder: (c, i) => const HeightSpace(16),
            itemBuilder: (c, i) {
              final ulasan = DummyUlasan.ulasan[i];
              return CardMatkulReview(model: ulasan, onTap: () {});
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget buildWideLayout(
    BuildContext context,
    SizingInformation sizeInfo,
  ) {
    return buildNarrowLayout(context, sizeInfo);
  }

  @override
  Future<bool> onBackPressed() async {
    return true;
  }
}
