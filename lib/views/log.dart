import 'package:flutter/material.dart';
import 'package:multihabit/main.dart';
import 'package:multihabit/util/swipedetector.dart';
import 'package:multihabit/views/leaderboard.dart';
import 'package:multihabit/views/stats.dart';

class LogPage extends StatelessWidget {
  const LogPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SwipeDetector(
      onSwipeRight: () => Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => const HomePage())),
      onSwipeLeft: () => Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => const StatsPage())),
      onSwipeUp: () => Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => const LeaderboardPage())),
      child: const Scaffold(
        body: Center(
          child: Text("Log Screen"),
        ),
        backgroundColor: Colors.brown,
      ),
    );
  }
}