part of '_repositories.dart';


abstract class LeaderboardRepository {
  Future<Decide<Failure, Parsed<List<LeaderboardModel>>>> getTop20Leaderboard();
}
