// Created by Muhamad Fauzi Ridwan on 08/11/21.

part of '_pages.dart';

class ReviewMatkulPage extends StatefulWidget {
  const ReviewMatkulPage({super.key});

  @override
  _ReviewMatkulPageState createState() => _ReviewMatkulPageState();
}

class _ReviewMatkulPageState extends BaseStateful<ReviewMatkulPage> {
  // TODO(bim): create form key

  @override
  void init() {}

  @override
  ScaffoldAttribute buildAttribute() {
    return ScaffoldAttribute();
  }

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context) {
    return BaseAppBar(
      label: 'Tulis Ulasan',
    );
  }

  @override
  Widget buildNarrowLayout(
    BuildContext context,
    SizingInformation sizeInfo,
  ) {
    // TODO(bim): create form view
    return Column(
      children: [
        TulisUlasanButton(
          onTap: () {},
        ),
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
}
