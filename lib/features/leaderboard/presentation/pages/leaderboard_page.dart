part of '_pages.dart';

class LeaderboardPage extends StatefulWidget {
  const LeaderboardPage({Key? key}) : super(key: key);

  @override
  _LeaderboardPageState createState() => _LeaderboardPageState();
}

class _LeaderboardPageState extends BaseStateful<LeaderboardPage> {
  @override
  PreferredSizeWidget? buildAppBar(BuildContext context) {
    return BaseAppBar(label: 'Leaderboard');
  }

  @override
  ScaffoldAttribute buildAttribute() {
    return ScaffoldAttribute();
  }

  @override
  Widget buildNarrowLayout(BuildContext context, SizingInformation sizeInfo) {
    return RefreshIndicator(
      key: refreshIndicatorKey,
      onRefresh: retrieveData,
      child: Column(
        children: [
          const HeightSpace(24),
          Text(
            '20 Pengulas Teratas',
            style: FontTheme.poppins14w700black(),
          ),
          OnBuilder<LeaderboardState>.all(
            listenTo: leaderboardRM,
            onIdle: _buildSkeleton,
            onWaiting: _buildSkeleton,
            onError: (dynamic error, refresh) {
              if (error is Failure) {
                return Text(error.message.toString());
              }
              return const Text('Something Error');
            },
            onData: (data) {
              return Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  itemCount: data.leaderboard.length,
                  separatorBuilder: (c, i) => const HeightSpace(12),
                  itemBuilder: (c, i) {
                    final rankData = data.leaderboard[i];
                    return LeaderboardCard(
                      rank: i + 1,
                      model: rankData,
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget buildWideLayout(BuildContext context, SizingInformation sizeInfo) {
    return buildNarrowLayout(context, sizeInfo);
  }

  @override
  void init() {
    StateInitializer(
      rIndicator: refreshIndicatorKey!,
      state: false,
      cacheKey: 'leaderboard-page',
    ).initialize();
  }

  Future<void> retrieveData() async {
    await Future.wait([
      leaderboardRM.setState((s) => s.retrieveData()),
    ]);
  }

  Widget _buildSkeleton(){
    return Expanded(
      child: ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        children: List.generate(
          20,
              (index) => const Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: SkeletonCardLeaderboard(),
          ),
        ),
      ),
    );
  }

  @override
  Future<bool> onBackPressed() async {
    return true;
  }
}
