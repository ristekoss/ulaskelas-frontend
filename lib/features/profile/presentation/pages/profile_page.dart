// Created by Muhamad Fauzi Ridwan on 08/11/21.

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ristek_material_component/ristek_material_component.dart';
import 'package:ulaskelas/core/bases/states/_states.dart';
import 'package:ulaskelas/core/theme/_theme.dart';
import 'package:ulaskelas/features/matkul/search/presentation/widgets/_widgets.dart';
import 'package:ulaskelas/features/profile/presentation/widgets/profile_data.dart';
import 'package:ulaskelas/services/_services.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({
    super.key,
  });

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
        children: [
          Expanded(
            child: ListView(
              children: <Widget>[
                const SizedBox(height: 42),
                Icon(
                  Icons.account_circle,
                  size: 140,
                  color: Colors.grey[300],
                ),
                const SizedBox(height: 24),
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
              ],
            ),
          ),
          Center(
            child: InkWell(
              onTap: () {
                nav.goToBookmarksPage();
              },
              child: Text(
                'Mata Kuliah Tersimpan',
                style: FontTheme.poppins14w500black().copyWith(
                  color: BaseColors.purpleHearth,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          const HeightSpace(24),
          Center(
            child: InkWell(
              onTap: () {
                nav.goToHomeDaftarUlasan();
                MixpanelService.track('view_all_reviews');
              },
              child: Text(
                'Riwayat Ulasan',
                style: FontTheme.poppins14w500black().copyWith(
                  color: BaseColors.purpleHearth,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          const HeightSpace(24),
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
