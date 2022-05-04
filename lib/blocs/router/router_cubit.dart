import "package:flutter_bloc/flutter_bloc.dart";

import "package:multihabit/blocs/router/router_state.dart";

export "package:multihabit/blocs/router/router_state.dart";

class RouterCubit extends Cubit<RouterState> {
  RouterCubit() : super(const DashboardState());

  void goToLogin() => emit(const LoginState());
  void goToDashboard() => emit(const DashboardState());
  void goToStats() => emit (const StatsState());
  void goToLog() => emit (const LogState());
  void goToLeaderboard() => emit (const LeaderboardState());
}
