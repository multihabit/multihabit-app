import 'package:flutter/material.dart';
import 'package:multihabit/util/swipedetector.dart';

class LeaderboardPage extends StatelessWidget {
  const LeaderboardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SwipeDetector(
      onSwipeDown: () => Navigator.of(context).pop(),
      child: const Scaffold(
        body: Center(
          child: Text("Leaderboard Screen"),
        ),
        backgroundColor: Colors.blue,
      ),
    );
  }
}