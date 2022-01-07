// Created by Muhamad Fauzi Ridwan on 08/11/21.

part of '_pages.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    required this.onSeeAllCourse,
    Key? key,
  }) : super(key: key);

  final VoidCallback onSeeAllCourse;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends BaseStateful<HomePage> {
  @override
  void init() {
    if (!currentTermCourseRM.state.hasCourse) {}

    StateInitializer(
      rIndicator: refreshIndicatorKey!,
      state: bookmarkRM.state.getCondition(),
      cacheKey: bookmarkRM.state.cacheKey!,
    ).initialize();
  }

  Future<void> retrieveData() async {
    await Future.wait([
      reviewHistoryRM
          .setState((s) => s.retrieveData(QueryReview(byAuthor: true))),
      currentTermCourseRM.setState((s) => s.retrieveData()),
    ]);
  }

  @override
  ScaffoldAttribute buildAttribute() {
    return ScaffoldAttribute();
  }

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: BaseColors.white,
      title: Container(
        width: MediaQuery.of(context).size.width / 3,
        padding: const EdgeInsets.only(left: 10),
        child: Image.asset(
          ImageConst.primaryLogo,
          fit: BoxFit.fitWidth,
        ),
      ),
      centerTitle: false,
      elevation: 0,
    );
  }

  @override
  Widget buildNarrowLayout(
    BuildContext context,
    SizingInformation sizeInfo,
  ) {
    return RefreshIndicator(
      key: refreshIndicatorKey,
      onRefresh: retrieveData,
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(
                left: 20,
                right: 20,
                bottom: 10,
              ),
              alignment: Alignment.centerLeft,
              child: OnReactive(
                () => Text(
                  'Hi, ${profileRM.state.profile.name ?? 'Something Error'}!',
                  style: FontTheme.poppins20w700black(),
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(6)),
                border: Border.all(color: BaseColors.primary, width: 2),
              ),
              margin: const EdgeInsets.all(20),
              child: InkWell(
                onTap: () => widget.onSeeAllCourse.call(),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.list_alt_outlined,
                            color: BaseColors.primaryColor,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Lihat Semua Mata Kuliah',
                            style: FontTheme.poppins14w400purple(),
                          )
                        ],
                      ),
                      Icon(
                        Icons.keyboard_arrow_right,
                        color: BaseColors.primaryColor,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: SizedBox(
                height: 40,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    // TODO(pawpaw): current semester on profile.
                    Text(
                      'Mata Kuliah Semester ${profileRM.state.profile.term}',
                      style: FontTheme.poppins14w700black(),
                    ),
                    InkWell(
                      onTap: () => nav.goToHomeDaftarMatkul(),
                      child: Text(
                        'Lihat Semua',
                        style: FontTheme.poppins13w400purple(),
                      ),
                    )
                  ],
                ),
              ),
            ),
            OnBuilder<CurrentTermCourseState>.all(
              listenTo: currentTermCourseRM,
              onIdle: () => const Text('Waiting'),
              onWaiting: () => const CircleLoading(),
              onError: (dynamic error, refresh) {
                if (error is Failure) {
                  return Text(error.message.toString());
                }
                return const Text('Something Error');
              },
              onData: (data) {
                return ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  itemCount: data.summaries.length,
                  separatorBuilder: (c, i) => const HeightSpace(16),
                  itemBuilder: (c, i) {
                    final course = data.summaries[i];
                    return CardCourse(
                      model: course,
                      onTap: () {},
                    );
                  },
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: SizedBox(
                height: 40,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Riwayat Ulasanmu',
                      style: FontTheme.poppins14w700black(),
                    ),
                    InkWell(
                      onTap: () => nav.goToHomeDaftarUlasan(),
                      child: Text(
                        'Lihat Semua',
                        style: FontTheme.poppins13w400purple(),
                      ),
                    )
                  ],
                ),
              ),
            ),
            OnBuilder<ReviewHistoryState>.all(
              listenTo: reviewHistoryRM,
              onIdle: () => const Text('Waiting'),
              onWaiting: () => const CircleLoading(),
              onError: (dynamic error, refresh) {
                if (error is Failure) {
                  return Text(error.message.toString());
                }
                return const Text('Something Error');
              },
              onData: (data) {
                if (data.reviewHistories.isEmpty) {
                  return Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            'Tidak ada riwayat ulasan',
                            style: FontTheme.poppins12w500black(),
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ),
                    ],
                  );
                }
                return ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  itemCount: data.summaries.length,
                  separatorBuilder: (c, i) => const HeightSpace(16),
                  itemBuilder: (c, i) {
                    final review = data.summaries[i];
                    return CardMatkulReview(review: review, onTap: () {});
                  },
                );
              },
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
}
