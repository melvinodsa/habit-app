import 'package:flutter/material.dart';
import 'package:habit/config/index.dart';
import 'package:habit/models/habit.dart';

class HabitFrequency extends StatefulWidget {
  HabitFrequency({Key? key, required this.config, required this.habit})
      : super(key: key);

  final AppConfig config;
  final Habit habit;

  @override
  _HabitFrequencyState createState() => _HabitFrequencyState();
}

class _HabitFrequencyState extends State<HabitFrequency> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Frequency")),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Container(
      margin: EdgeInsets.all(40),
      child: Column(
        children: [
          _buildQuestion(),
          _buildInputs(),
          _buildNextButton(),
        ],
      ),
    );
  }

  Widget _buildQuestion() {
    return Center(
      child: Container(
        margin: EdgeInsets.only(bottom: 40),
        child: Text(
          "How often do you want to do it?",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildInputs() {
    return Column(
      children: [],
    );
  }

  Widget _buildNextButton() {
    return Container(
      width: MediaQuery.of(context).size.width - 80,
      child: ElevatedButton(
        onPressed: () => {},
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.only(top: 20, bottom: 20),
        ),
        child: Text("Next"),
      ),
    );
  }
}
