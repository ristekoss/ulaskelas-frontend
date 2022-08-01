part of '_pages.dart';

class CalculatorPage extends StatefulWidget {
  const CalculatorPage({
    Key? key,
  }) : super(key: key);

  @override
  _CalculatorPageState createState() => _CalculatorPageState();
}

class _CalculatorPageState extends BaseStateful<CalculatorPage> {
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
    return null;
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                'Kalkulator Nilai Mata Kuliah',
                style: FontTheme.poppins14w700black(),
              ),
            ),
            Expanded(
              child: OnBuilder<BookmarkState>.all(
                listenTo: bookmarkRM,
                onIdle: () => WaitingView(),
                onWaiting: () => WaitingView(),
                onError: (dynamic error, refresh) => const Text('error'),
                onData: (data) {
                  final bookmarks = data.bookmarks;
                  if (bookmarks.isEmpty) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          HeightSpace(sizeInfo.screenSize.height * .05),
                          Image.asset(
                            Ilustration.notfound,
                            width: sizeInfo.screenSize.width * .6,
                          ),
                          const HeightSpace(20),
                          Text(
                            'Belum Ada Kalkulator Nilai Tersimpan',
                            style: FontTheme.poppins14w700black().copyWith(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                          const HeightSpace(10),
                          Text(
                            '''
Kamu Belum memiliki kalkulator nilai tersimpan. Silakan tambahkan terlebih dahulu.''',
                            style: Theme.of(context).textTheme.caption,
                            textAlign: TextAlign.center,
                          ),
                          const HeightSpace(30),
                          SecondaryButton(
                            width: double.infinity,
                            text: 'Tambah Mata Kuliah',
                            backgroundColor: BaseColors.purpleHearth,
                            onPressed: () =>
                                nav.goToSearchCourseCalculatorPage(),
                          ),
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
                          bookmark.courseId!,
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
          ],
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
