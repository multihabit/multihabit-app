import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multihabit/blocs/router/router_cubit.dart';
import 'package:multihabit/util/swipedetector.dart';
import 'package:multihabit/views/dashboard.dart';
import 'package:multihabit/views/log.dart';
import 'package:multihabit/views/stats.dart';

class LeaderboardPage extends StatelessWidget {
  const LeaderboardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SwipeDetector(
      onSwipeRight: () => BlocProvider.of<RouterCubit>(context).goToDashboard(),
      onSwipeDown: () => BlocProvider.of<RouterCubit>(context).goToLog(),
      onSwipeLeft: () => BlocProvider.of<RouterCubit>(context).goToStats(),
      child: const Scaffold(
        body: Center(
          child: Text("Leaderboard Screen"),
        ),
        backgroundColor: Colors.blue,
      ),
    );
  }
}
