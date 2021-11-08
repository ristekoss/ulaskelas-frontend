// Created by Muhamad Fauzi Ridwan on 08/11/21.

import 'package:flutter/material.dart';
import 'package:ristek_material_component/ristek_material_component.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({
    Key? key,
  }) : super(key: key);

  @override
  _OnboardingPageState createState() => _OnboardingPageState();
}

class _OnboardingPageState extends BaseStateful<OnboardingPage> {
  @override
  void init() {}

  @override
  ScaffoldAttribute buildAttribute() {
    return ScaffoldAttribute();
  }

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context) {
    return null;
  }

  @override
  Widget buildNarrowLayout(
    BuildContext context,
    SizingInformation sizeInfo,
  ) {
    // TODO(Radit): Onboarding content using page view
    return SafeArea(
      child: Container(),
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
