// Created by Muhamad Fauzi Ridwan on 08/11/21.

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ristek_material_component/ristek_material_component.dart';
import 'package:ulaskelas/core/bases/states/_states.dart';
import 'package:ulaskelas/core/theme/_theme.dart';
import 'package:ulaskelas/features/matkul/search/presentation/widgets/_widgets.dart';
import 'package:ulaskelas/features/profile/presentation/widgets/profile_data.dart';

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
          Icon(
            Icons.account_circle,
            size: 140,
            color: Colors.grey[300],
          ),
          // CircleAvatar(
          //   radius: 100,
          //   backgroundColor: Colors.grey[300],
          // ),
          const SizedBox(height: 34),
          ProfileData(
            'Nama',
            profileRM.state.profile.name.toString(),
          ),
          // TODO(pawpaw): angkatan.
          ProfileData(
            'Angkatan',
            profileRM.state.profile.generation.toString(),
          ),
          ProfileData(
            'Jurusan',
            profileRM.state.profile.studyProgram.toString(),
          ),
          const Expanded(
            child: SizedBox(),
          ),
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
