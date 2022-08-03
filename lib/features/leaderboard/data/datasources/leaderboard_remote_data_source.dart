part of '_datasources.dart';

abstract class LeaderboardRemoteDataSource {
  Future<Parsed<List<LeaderboardModel>>> getTop20Leaderboard();
}

class LeaderboardRemoteDataSourceImpl implements LeaderboardRemoteDataSource {

  @override
  Future<Parsed<List<LeaderboardModel>>> getTop20Leaderboard() async {
    final list = <LeaderboardModel>[];
    final url = Endpoints.leaderboard;
    final resp = await getIt(url);

    for (final data in resp.dataBodyIterable) {
      list.add(LeaderboardModel.fromJson(data));
    }

    return resp.parse(list);
  }

}
