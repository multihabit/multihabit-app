import 'package:flutter/material.dart';
import 'package:multihabit/main.dart';
import 'package:multihabit/util/swipedetector.dart';
import 'package:multihabit/views/log.dart';
import 'package:multihabit/views/stats.dart';

class LeaderboardPage extends StatelessWidget {
  const LeaderboardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SwipeDetector(
      onSwipeRight: () => Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => const HomePage())),
      onSwipeDown: () => Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => const LogPage())),
      onSwipeLeft: () => Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => const StatsPage())),
      child: const Scaffold(
        body: Center(
          child: Text("Leaderboard Screen"),
        ),
        backgroundColor: Colors.blue,
      ),
    );
  }
}