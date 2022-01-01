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
        child: OnReactive(() {
          final bookmarks = bookmarkRM.state.bookmarks;
          if (bookmarks.isEmpty) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                HeightSpace(sizeInfo.screenSize.height * .1),
                Image.asset(
                  Ilustration.notfound,
                  width: sizeInfo.screenSize.width * .6,
                ),
                const HeightSpace(20),
                Text(
                  'Belum Ada Mata Kuliah Tersimpan',
                  style: FontTheme.poppins14w700black().copyWith(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                const HeightSpace(10),
                Text(
                  '''
Kamu Belum memiliki Mata kuliah tersimpan. Silakan tambahkan terlebih dahulu.''',
                  style: Theme.of(context).textTheme.caption,
                  textAlign: TextAlign.center,
                ),
                const HeightSpace(40),
              ],
            );
          }
          return ListView.separated(
            itemCount: bookmarkRM.state.bookmarks.length,
            itemBuilder: (context, index) {
              final bookmark = bookmarks[index];
              final data = searchMatkul.state.matkuls
                  .where((element) => element.name == bookmark);
              return CardBookmark(model: data.first);
            },
            separatorBuilder: (BuildContext context, int index) =>
                const SizedBox(height: 16),
          );
        }),
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
