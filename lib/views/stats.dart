import 'package:flutter/material.dart';
import 'package:multihabit/util/swipedetector.dart';

class StatsPage extends StatelessWidget {
  const StatsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SwipeDetector(
      onSwipeRight: () => Navigator.of(context).pop(),
      child: const Scaffold(
        body: Center(
          child: Text("Stats Screen"),
        ),
        backgroundColor: Colors.green,
      ),
    );
  }
}