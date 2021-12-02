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
      child: FutureBuilder(
        future: http.get(
          Uri.parse(
              'http://ulaskelas-dev.ap-southeast-1.elasticbeanstalk.com/api/account'),
          headers: Pref.getHeaders(),
        ),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text("Something went wrong"));
          }

          // if (snapshot.hasData && !snapshot.data!.exists) {
          //   return Center(child: Text("Document does not exist"));
          // }

          if (snapshot.hasData) {
            return loadedProfilePage((snapshot.data as Response).body);
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
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

  String getAngkatan(String npm) {
    return '20${npm.substring(0, 2)}';
  }

  Widget loadedProfilePage(String jsonString) {
    final Map<String, dynamic> userData = jsonDecode(jsonString);
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        const SizedBox(height: 42),
        const Icon(
          Icons.account_circle,
          size: 150,
          color: const Color(0xFFBDBDBD),
        ),
        const SizedBox(height: 34),
        ProfileData('Nama', userData['data']['name']),
        ProfileData('Angkatan', getAngkatan(userData['data']['npm'])),
        ProfileData('Jurusan', userData['data']['study_program']),
        const Spacer(),
        SecondaryButton(
          width: double.infinity,
          text: 'Keluar',
          backgroundColor: BaseColors.error,
          onPressed: _logout,
        ),
      ],
    );
  }
}
