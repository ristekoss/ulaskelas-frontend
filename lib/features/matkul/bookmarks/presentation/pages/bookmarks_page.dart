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
  void init() {
    StateInitializer(
      rIndicator: refreshIndicatorKey!,
      state: bookmarkRM.state.getCondition(),
      cacheKey: bookmarkRM.state.cacheKey!,
    ).initialize();
  }

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
      child: RefreshIndicator(
        key: refreshIndicatorKey,
        onRefresh: retrieveData,
        child: OnBuilder<BookmarkState>.all(
          listenTo: bookmarkRM,
          onIdle: () => WaitingView(),
          onWaiting: () => WaitingView(),
          onError: (dynamic error, refresh) => const Text('error'),
          onData: (data) {
            final bookmarks = data.bookmarks;
            if (bookmarks.isEmpty) {
              return Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
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
                ),
              );
            }
            return ListView.separated(
              padding: const EdgeInsets.all(20),
              itemCount: bookmarkRM.state.bookmarks.length,
              itemBuilder: (context, index) {
                final bookmark = bookmarks[index];
                // TODO(paw): set course_id
                return CardBookmark(
                  model: bookmark,
                  onTap: () => nav.goToDetailMatkulPage(
                    bookmark.hashCode,
                    bookmark.courseCode!,
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) =>
                  const SizedBox(height: 16),
            );
          },
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

  void onScroll() {}

  Future<void> retrieveData() async {
    await bookmarkRM.setState((s) => s.retrieveData(QueryBookmark()));
  }

  bool scrollCondition() {
    throw UnimplementedError();
  }
}
