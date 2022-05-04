import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multihabit/blocs/router/router_cubit.dart';
import 'package:multihabit/views/dashboard.dart';
import 'package:multihabit/views/leaderboard.dart';
import 'package:multihabit/views/log.dart';
import 'package:multihabit/views/login_view.dart';
import 'package:multihabit/views/mainview.dart';
import 'package:multihabit/views/stats.dart';

import '../blocs/auth/auth_bloc.dart';

class RootRouterDelegate extends RouterDelegate<RouterState> {
  final GlobalKey<NavigatorState> _navigatorKey;
  final RouterCubit _cubit;

  RootRouterDelegate({
    required GlobalKey<NavigatorState> navigatorKey, 
    required RouterCubit cubit})
    : _navigatorKey = navigatorKey,
      _cubit = cubit;
  
  GlobalKey<NavigatorState> get navigatorKey => _navigatorKey;

  @override
  Widget build(BuildContext context) {
    AuthBloc _authBloc = BlocProvider.of<AuthBloc>(context);
    return Navigator(
      key: navigatorKey,
      pages: List<Page>.from([
        MaterialPage(
          key: const ValueKey<String>("mainView"),
          child: MainView(),
        ),
        if(_authBloc.state is! AuthenticatedState)
          const MaterialPage(
            key: ValueKey<String>("loginView"),
            child: LoginView()),
      ]),
      onPopPage: _onPopPageParser,
    );
  }

  bool _onPopPageParser(Route<dynamic> route, dynamic result) {
    if (!route.didPop(result)) return false;
    if (result != 'fromLogin') popRoute();
    return true;
  }

  @override
  Future<bool> popRoute() async {
    if (_cubit.state is! DashboardState) {
      _cubit.goToDashboard();
      return true;
    }

    return await _confirmAppExit();
  }

  Future<bool> _confirmAppExit() async {
    return await showDialog<bool>(
      context: navigatorKey.currentContext!,
      builder: (context) {
        return AlertDialog(
          title: const Text("Exit App"),
          content: const Text("Are you sure you want to exit the app?"),
          actions: [
            TextButton(
              child: const Text("Cancel"),
              onPressed: () => Navigator.pop(context, true),
            ),
            TextButton(
              child: const Text("Confirm"),
              onPressed: () => Navigator.pop(context, false),
            )
          ]
        );
      }
    ) ?? true;
  }

  @override
  void addListener(VoidCallback listener) {}

  @override
  void removeListener(VoidCallback listener) {}

  @override
  Future<void> setNewRoutePath(RouterState configuration) async {}
}
