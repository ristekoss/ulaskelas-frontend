// Created by Muhamad Fauzi Ridwan on 08/11/21.

import 'package:flutter/material.dart';
import 'package:ristek_material_component/ristek_material_component.dart';
import 'package:ulaskelas/core/theme/_theme.dart';
import 'package:ulaskelas/services/_services.dart';

import 'core/bases/states/_states.dart';
import 'core/constants/_constants.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({
    Key? key,
  }) : super(key: key);

  @override
  _OnboardingPageState createState() => _OnboardingPageState();
}

class _OnboardingPageState extends BaseStateful<OnboardingPage> {
  final PageController pageController = PageController();
  int pageIndex = 0;

  List<String> titles = [
    'Selamat datang di UlasKelas!',
    'Lihat Ulasan Dari Temanmu',
    'Berikan Ulasanmu',
  ];

  List<String> descriptions = [
    '''
UlasKelas merupakan aplikasi ulasan untuk mata kuliah Fasilkom UI. Dengan aplikasi ini, kamu tidak perlu lagi kebingungan dalam memilih kelas!''',
    '''
Di UlasKelas, kamu bisa melihat ulasan untuk mata kuliah Fasilkom UI dari teman-temanmu yang sudah mengambil.''',
    '''
Kamu juga dapat memberikan ulasan terhadap mata kuliah yang sudah kamu ambil. Ulasanmu dapat dilihat oleh seluruh teman-temanmu di Fasilkom UI.''',
  ];

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
    final width = sizeInfo.screenSize.width;
    final height = sizeInfo.screenSize.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: BaseColors.gray5,
        elevation: 0,
        actions: [
          if (pageIndex != 2)
            Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.only(right: width / 20),
              child: InkWell(
                onTap: nav.replaceToSsoPage,
                child: Text(
                  'Lewati',
                  style: FontTheme.poppins14w600black().copyWith(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
            ),
        ],
      ),
      body: PageView.builder(
          controller: pageController,
          onPageChanged: (value) {
            setState(() {
              pageIndex = value;
            });
          },
          itemCount: titles.length,
          itemBuilder: (context, index) {
            return OnboardingPageBody(
              index: index,
              height: height,
              width: width,
              title: titles[index],
              description: descriptions[index],
              image: 'assets/images/ilust_onboard${index + 1}.png',
            );
          }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          DotIndicator(
            currentIndex: pageIndex,
            length: 3,
          ),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: width / 15,
              vertical: height / 30,
            ),
            child: AutoLayoutButton(
              text: (pageIndex == 2) ? 'Mulai' : 'Selanjutnya',
              backgroundColor: BaseColors.purpleHearth,
              onTap: () async {
                if (pageIndex < 2) {
                  await pageController.nextPage(
                    duration: const Duration(milliseconds: 250),
                    curve: Curves.easeIn,
                  );
                } else {
                  await Pref.saveBool(PreferencesKeys.onBoard, value: true);
                  await nav.replaceToSsoPage();
                }
              },
            ),
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

class OnboardingPageBody extends StatelessWidget {
  const OnboardingPageBody({
    Key? key,
    required this.index,
    required this.height,
    required this.width,
    required this.title,
    required this.description,
    required this.image,
  }) : super(key: key);

  final int index;
  final double height;
  final double width;
  final String title;
  final String description;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: height / 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 5,
            child: Container(
              padding: EdgeInsets.only(
                top: height / 30,
                bottom: height / 20,
                left: width / 6,
                right: width / 6,
              ),
              color: BaseColors.gray5,
              child: Image.asset(image),
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              padding: EdgeInsets.only(
                left: width / 15,
                right: width / 15,
                top: height / 16,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    title,
                    style: FontTheme.poppins18w700black(),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: height / 53.33,
                  ),
                  Text(
                    description,
                    style: FontTheme.poppins14w400black(),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
