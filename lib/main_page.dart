// Created by Muhamad Fauzi Ridwan on 24/08/21.

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ristek_material_component/ristek_material_component.dart';
import 'package:ulaskelas/features/matkul/search/presentation/pages/_pages.dart';
import 'package:ulaskelas/features/profile/presentation/pages/_pages.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends BaseStateful<MainPage> {
  late int _selectedIndex;
  late List<Widget> _children;

  @override
  void init() {
    // TODO(fauzi): Navigator per page
    _children = <Widget>[
      const Scaffold(),
      const MatkulPage(),
      const Scaffold(),
      const ProfilePage(),
    ];
    _selectedIndex = 0;
  }

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context) {
    return null;
  }

  @override
  ScaffoldAttribute buildAttribute() {
    return ScaffoldAttribute(
      bottomNavigation: _convexNavigation(),
    );
  }

  @override
  Widget buildNarrowLayout(
    BuildContext context,
    SizingInformation sizeInfo,
  ) {
    return SafeArea(
      child: _children[_selectedIndex],
    );
  }

  @override
  Widget buildWideLayout(
    BuildContext context,
    SizingInformation sizeInfo,
  ) {
    return buildNarrowLayout(
      context,
      sizeInfo,
    );
  }

  Widget? _convexNavigation() {
    return RistekBotNavBar(
      initialActiveIndex: _selectedIndex,
      onTap: (int index) {
        setState(() => _selectedIndex = index);
      },
      items: const [
        RistekBotNavItem(
          icon: Icons.home,
          text: 'Beranda',
        ),
        RistekBotNavItem(
          icon: Icons.list_alt,
          text: 'Matkul',
        ),
        RistekBotNavItem(
          icon: Icons.bookmark,
          text: 'Tersimpan',
        ),
        RistekBotNavItem(
          icon: Icons.account_circle,
          text: 'Profil',
        ),
      ],
    );
  }

  @override
  Future<bool> onBackPressed() async {
    return true;
  }
}
