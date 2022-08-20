part of '_repositories.dart';

class LeaderboardRepositoryImpl implements LeaderboardRepository {
  LeaderboardRepositoryImpl(
    this._remoteDataSource,
  );

  final LeaderboardRemoteDataSource _remoteDataSource;

  @override
  Future<Decide<Failure, Parsed<List<LeaderboardModel>>>>
      getTop20Leaderboard() {
    return apiCall(
      _remoteDataSource.getTop20Leaderboard(),
    );
  }
}
