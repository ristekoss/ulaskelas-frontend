// Created by Muhamad Fauzi Ridwan on 08/11/21.

part of '_pages.dart';

class BookmarksPage extends StatefulWidget {
  const BookmarksPage({
    Key? key,
  }) : super(key: key);

  @override
  _BookmarksPageState createState() => _BookmarksPageState();
}

class _BookmarksPageState extends BaseStateful<BookmarksPage> {
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
      label: 'Mata Kuliah Tersimpan',
    );
  }

  MatkulModel model = MatkulModel(
    name: 'Sistem Interaksi',
    reviews: 8,
    shortName: 'SI',
    matkulType: 'Ilkom SI',
    matkulTypeValue: 'Ilkom SI',
    sks: '3 SKS',
  );

  @override
  Widget buildNarrowLayout(
    BuildContext context,
    SizingInformation sizeInfo,
  ) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 10,
        ),
        child: ListView.separated(
          itemCount: 5,
          itemBuilder: (context, index) => CardBookmark(model: model),
          separatorBuilder: (BuildContext context, int index) =>
              SizedBox(height: 16),
        ),
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
