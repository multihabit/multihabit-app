import 'package:flutter/material.dart';
import 'package:multihabit/util/swipedetector.dart';
import 'package:multihabit/views/log.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage()
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build (BuildContext context) {
    return SwipeDetector(
      onSwipeLeft: () => Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => const LogPage())),
      child: const Scaffold(
        body: Center(
          child: Text("Dashboard"),
        ),
        backgroundColor: Colors.amber,
      ),
    );
  }
}