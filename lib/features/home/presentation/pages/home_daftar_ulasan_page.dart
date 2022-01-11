part of '_pages.dart';

class HomeDaftarUlasanPage extends StatefulWidget {
  const HomeDaftarUlasanPage({
    Key? key,
  }) : super(key: key);

  @override
  _HomeDaftarUlasanPageState createState() => _HomeDaftarUlasanPageState();
}

class _HomeDaftarUlasanPageState extends BaseStateful<HomeDaftarUlasanPage> {
  late ScrollController scrollController;
  late Completer<void> completer;

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context) {
    return BaseAppBar(
      label: 'Riwayat Ulasanmu',
      elevation: 0,
    );
  }

  @override
  ScaffoldAttribute buildAttribute() {
    return ScaffoldAttribute();
  }

  Future<void> retrieveData() async {
    await reviewHistoryRM
        .setState((s) => s.retrieveData(QueryReview(byAuthor: true)));
  }

  @override
  Widget buildNarrowLayout(BuildContext context, SizingInformation sizeInfo) {
    return RefreshIndicator(
      key: refreshIndicatorKey,
      onRefresh: retrieveData,
      child: OnBuilder<ReviewHistoryState>.all(
        listenTo: reviewHistoryRM,
        onIdle: () => WaitingView(),
        onWaiting: () => WaitingView(),
        onError: (dynamic error, refresh) => Text(error.toString()),
        onData: (data) {
          if (data.reviewHistories.isEmpty) {
            return const Center(
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                child: EmptyView(
                  title: 'Tidak ada Riwayat Ulasan',
                  description: 'Mulailah untuk menulis ulasan pada matkul!',
                ),
              ),
            );
          }
          return ListView.separated(
            controller: scrollController,
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 10,
            ),
            itemCount: data.hasReachedMax
                ? data.reviewHistories.length
                : data.reviewHistories.length + 1,
            separatorBuilder: (c, i) => const HeightSpace(16),
            itemBuilder: (c, i) {
              if (!data.hasReachedMax && i == data.reviewHistories.length) {
                return const CircleLoading(size: 25);
              }
              final review = data.reviewHistories[i];
              return CardMatkulReview(
                review: review,
                onTap: () {
                  nav.goToDetailMatkulPage(
                    review.course!,
                    review.courseCode!,
                  );
                },
              );
            },
          );
        },
      ),
    );
  }

  @override
  Widget buildWideLayout(BuildContext context, SizingInformation sizeInfo) {
    return buildNarrowLayout(context, sizeInfo);
  }

  @override
  void init() {
    completer = Completer<void>();
    scrollController = ScrollController();
    scrollController.addListener(_onScroll);
  }

  @override
  Future<bool> onBackPressed() async {
    return true;
  }

  void _onScroll() {
    if (_isBottom && !completer.isCompleted && scrollCondition()) {
      onScroll();
    }
  }

  bool scrollCondition() {
    return !reviewHistoryRM.state.hasReachedMax;
  }

  void onScroll() {
    completer.complete();
    final query = QueryReview(byAuthor: true);
    // final query = QuerySearch(q: searchMatkul.state.controller.text);
    reviewHistoryRM.state.retrieveMoreData(query).then((value) {
      completer = Completer<void>();
      reviewHistoryRM.notify();
    }).onError((error, stackTrace) {
      completer = Completer<void>();
    });
  }

  bool get _isBottom {
    if (!scrollController.hasClients) {
      return false;
    }
    final maxScroll = scrollController.position.maxScrollExtent;
    final currentScroll = scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }
}
