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
    return Padding(
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
            backgroundColor: Colors.grey[300],
          ),
          const SizedBox(height: 34),
          const ProfileData('Nama', '''
Astrida Nayla'''),
          const ProfileData('Angkatan', '2018'),
          const ProfileData('Jurusan', 'Ilmu Komputer'),
          const Spacer(),
          SecondaryButton(
            width: double.infinity,
            text: 'Keluar',
            backgroundColor: BaseColors.error,
            onPressed: _logout,
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

  Future<void> _logout() async {
    Cleaner().cleanWhenLogout();
    unawaited(nav.replaceToSsoPage());
  }
}
