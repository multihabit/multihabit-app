import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multihabit/blocs/router/router_cubit.dart';
import 'package:multihabit/util/swipedetector.dart';
import 'package:multihabit/views/leaderboard.dart';
import 'package:multihabit/views/log.dart';

class StatsPage extends StatelessWidget {
  const StatsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SwipeDetector(
      onSwipeRight: () => BlocProvider.of<RouterCubit>(context).goToLog(),
      onSwipeUp: () => BlocProvider.of<RouterCubit>(context).goToLeaderboard(),
      child: const Scaffold(
        body: Center(
          child: Text("Stats Screen"),
        ),
        backgroundColor: Colors.green,
      ),
    );
  }
}