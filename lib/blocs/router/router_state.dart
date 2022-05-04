import 'package:equatable/equatable.dart';

abstract class RouterState extends Equatable {
  final String _pageID;

  const RouterState({required String pageID})
    : _pageID = pageID;
  
  @override
  List<Object?> get props => [_pageID];
}

class LoginState extends RouterState { const LoginState() : super(pageID: "login"); }
class DashboardState extends RouterState { const DashboardState() : super(pageID: "dashboard"); }
class LogState extends RouterState { const LogState() : super(pageID: "log"); }
class StatsState extends RouterState { const StatsState() : super(pageID: "stats"); }
class LeaderboardState extends RouterState { const LeaderboardState() : super(pageID: "leaderboard"); }
