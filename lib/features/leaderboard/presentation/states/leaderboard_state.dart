part of '_states.dart';

class LeaderboardState {
  LeaderboardState() {
    final remoteDataSource = LeaderboardRemoteDataSourceImpl();
    _repo = LeaderboardRepositoryImpl(
      remoteDataSource,
    );
  }

  late LeaderboardRepository _repo;
  List<LeaderboardModel>? _leaderboard;
  List<LeaderboardModel> get leaderboard => _leaderboard ?? List.empty();

  Future<void> retrieveData() async {
    final resp = await _repo.getTop20Leaderboard();
    resp.fold((failure) => throw failure, (result) {
      _leaderboard = result.data;
    });
  }
}
