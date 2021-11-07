// Created by Muhamad Fauzi Ridwan on 24/08/21.

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:houmi/core/bases/widgets/core/_base.dart';
import 'package:houmi/core/bases/widgets/custom/_custom.dart';
import 'package:houmi/core/bases/widgets/spacer/_spacer.dart';
import 'package:houmi/core/screen/_screen.dart';
import 'package:houmi/core/theme/_theme.dart';

import 'core/bases/states/_states.dart';
import 'core/bases/widgets/bar/_bar.dart';
import 'features/authentication/presentation/pages/_pages.dart';
import 'features/news/presentation/pages/_pages.dart';

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
    // TODO fauzi: Navigator per page
    _children = <Widget>[
      Scaffold(
        body: ListView(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 10,
          ),
          children: [
            const HeightSpace(40),
            const Text(
              'Welcome',
              textAlign: TextAlign.center,
            ),
            ElevatedButton(
              onPressed: () async {
                await GlobalState.auth().state.instance.signOut();
                await nav
                    .pushReplacement<void, void>(const AuthenticationPage());
              },
              child: Text(
                'Logout',
                style: FontTheme.ubuntu14w500white(),
              ),
            ),
          ],
        ),
      ),
      const Scaffold(),
      const Scaffold(),
      const NewsPage(),
    ];
    _selectedIndex = 0;
  }

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context) {
    return HoumiAppBar(
      title: 'Welcome!',
      implyLeading: false,
      centerTitle: false,
      actions: [
        IconButton(
          onPressed: () => nav.goToNotification(),
          icon: const Icon(
            Icons.notifications,
            color: HoumiColors.black100,
          ),
        ),
        IconButton(
          onPressed: () {
            //  TODO syabib: go to profile page
          },
          icon: const Icon(
            Icons.person_pin,
            color: HoumiColors.black100,
          ),
        ),
      ],
    );
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
    return _children[_selectedIndex];
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

  Widget _convexNavigation() {
    return HoumiBottomNavigationBar(
      initialActiveIndex: _selectedIndex,
      onTap: (int index) {
        setState(() => _selectedIndex = index);
      },
    );
  }

  @override
  Future<bool> onBackPressed() async {
    return true;
  }
}
