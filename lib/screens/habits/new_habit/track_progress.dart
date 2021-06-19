import 'package:flutter/material.dart';
import 'package:habit/config/index.dart';
import 'package:habit/models/habit.dart';

class TrackHabitProgress extends StatefulWidget {
  TrackHabitProgress({Key? key, required this.config, required this.habit})
      : super(key: key);

  final AppConfig config;
  final Habit habit;

  @override
  _TrackHabitProgressState createState() => _TrackHabitProgressState();
}

class _TrackHabitProgressState extends State<TrackHabitProgress> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Track progress")),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Container(
      margin: EdgeInsets.all(40),
      child: Column(
        children: [
          _buildQuestion(),
          _buildYesOrNo(),
          _buildNumerical(),
        ],
      ),
    );
  }

  Column _buildNumerical() {
    return Column(
      children: [
        ElevatedButton(
            onPressed: () => {print("pressed okay")},
            child: Text("With a NUMERIC value")),
        Text(
            "If you just want to establish a value as a daily goal or limit for the habit"),
      ],
    );
  }

  Column _buildYesOrNo() {
    return Column(
      children: [
        ElevatedButton(
            onPressed: () => {print("pressed okay")},
            child: Text("With a YES or NO")),
        Text(
            "If you just want to record whether you succeed with the habit or not."),
      ],
    );
  }

  Widget _buildQuestion() {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: Text(
        "How do you want to evaluate your progress?",
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
