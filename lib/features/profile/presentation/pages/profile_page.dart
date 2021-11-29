// Created by Muhamad Fauzi Ridwan on 08/11/21.

part of '_pages.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({
    Key? key,
  }) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends BaseStateful<ProfilePage> {
  @override
  void init() {}

  @override
  ScaffoldAttribute buildAttribute() {
    return ScaffoldAttribute();
  }

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context) {
    return BaseAppBar(
      hasLeading: false,
      label: 'Profil Pengguna',
    );
  }

  @override
  Widget buildNarrowLayout(
    BuildContext context,
    SizingInformation sizeInfo,
  ) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 10,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              const SizedBox(height: 42),
              CircleAvatar(
                radius: 100,
                backgroundColor: Colors.grey[400],
                child: Stack(
                  children: [
                    Container(
                      width: 200,
                      height: 200,
                      color: Colors.white,
                    ),
                    Icon(
                      Icons.account_circle,
                      size: 200,
                      color: Colors.grey[400],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 34),
              const ProfileData('Nama',
                  'Astrida Nayla Fauzia Nama Sangatlah Panjang Panjang sekali huaaaaa'),
              const ProfileData('Angkatan', '2018'),
              const ProfileData('Jurusan', 'Ilmu Komputer'),
              const SizedBox(height: 150),
              KeluarButton(() {}),
            ],
          ),
        )
      ],
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

  Widget titleAndData(String title, String data) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      child: Row(
        children: [
          SizedBox(
            width: 97,
            child: Text(
              title,
              style: FontTheme.poppins12w700black(),
            ),
          ),
          Expanded(
            child: Text(
              data,
              style: FontTheme.poppins12w400black(),
            ),
          )
        ],
      ),
    );
  }
}
