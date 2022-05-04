import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multihabit/blocs/router/router_cubit.dart';
import 'package:multihabit/util/swipedetector.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({Key? key}) : super(key: key);

  @override
  Widget build (BuildContext context) {
    return SwipeDetector(
      onSwipeLeft: () => BlocProvider.of<RouterCubit>(context).goToLog(),
      onSwipeUp: () => BlocProvider.of<RouterCubit>(context).goToLeaderboard(),
      child: const Scaffold(
        body: Center(
          child: Text("Dashboard"),
        ),
        backgroundColor: Colors.amber
      ),
    );
  }
}
