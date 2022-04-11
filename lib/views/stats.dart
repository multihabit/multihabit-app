import 'package:flutter/material.dart';
import 'package:multihabit/util/swipedetector.dart';
import 'package:multihabit/views/leaderboard.dart';
import 'package:multihabit/views/log.dart';

class StatsPage extends StatelessWidget {
  const StatsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SwipeDetector(
      onSwipeRight: () => Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => const LogPage())),
      onSwipeUp: () => Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => const LeaderboardPage())),
      child: const Scaffold(
        body: Center(
          child: Text("Stats Screen"),
        ),
        backgroundColor: Colors.green,
      ),
    );
  }
}