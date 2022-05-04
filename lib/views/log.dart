import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multihabit/blocs/router/router_cubit.dart';
import 'package:multihabit/util/swipedetector.dart';
import 'package:multihabit/views/dashboard.dart';
import 'package:multihabit/views/leaderboard.dart';
import 'package:multihabit/views/stats.dart';

class LogPage extends StatelessWidget {
  const LogPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SwipeDetector(
      onSwipeRight: () => BlocProvider.of<RouterCubit>(context).goToDashboard(),
      onSwipeLeft: () => BlocProvider.of<RouterCubit>(context).goToStats(),
      onSwipeUp: () => BlocProvider.of<RouterCubit>(context).goToLeaderboard(),
      child: const Scaffold(
        body: Center(
          child: Text("Log Screen"),
        ),
        backgroundColor: Colors.brown,
      ),
    );
  }
}
