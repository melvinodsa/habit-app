import 'package:flutter/material.dart';
import 'package:habit/config/index.dart';
import 'package:habit/models/habit.dart';
import 'package:habit/screens/habits/new_habit/habit_details.dart';

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

  void Function() _gotoHabitDetails(TrackProgress progressWith) {
    this.widget.habit.trackProgressWith = progressWith;
    return () => {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => HabitDetails(
                  config: this.widget.config, habit: this.widget.habit),
            ),
          )
        };
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

  Widget _buildNumerical() {
    return _TrackProgressOption(
      context: context,
      buttonText: [
        _SpecialText(label: "With a ", emphasised: false),
        _SpecialText(label: "Numeric", emphasised: true),
        _SpecialText(label: " value", emphasised: false),
      ],
      helperText:
          "If you just want to establish a value as a daily goal or limit for the habit.",
      onPress: _gotoHabitDetails(TrackProgress.WithNumerical),
    );
  }

  Widget _buildYesOrNo() {
    return _TrackProgressOption(
      context: context,
      buttonText: [
        _SpecialText(label: "With a ", emphasised: false),
        _SpecialText(label: "Yes", emphasised: true),
        _SpecialText(label: " or ", emphasised: false),
        _SpecialText(label: "No", emphasised: true)
      ],
      helperText:
          "If you just want to record whether you succeed with the habit or not.",
      onPress: _gotoHabitDetails(TrackProgress.WithYesOrNo),
    );
  }

  Widget _buildQuestion() {
    return Center(
      child: Container(
        margin: EdgeInsets.only(bottom: 40),
        child: Text(
          "How do you want to evaluate your progress?",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class _TrackProgressOption extends StatelessWidget {
  const _TrackProgressOption({
    Key? key,
    required this.context,
    required this.buttonText,
    required this.helperText,
    required this.onPress,
  }) : super(key: key);

  final BuildContext context;
  final List<_SpecialText> buttonText;
  final String helperText;
  final void Function() onPress;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 40),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 20),
            child: SizedBox(
              width: MediaQuery.of(context).size.width - 80,
              child: ElevatedButton(
                  onPressed: onPress,
                  style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.only(top: 20, bottom: 20)),
                  child: RichText(
                      text: TextSpan(
                          children: buttonText
                              .map((i) => i.buildTextSpan())
                              .toList()))),
            ),
          ),
          Text(helperText),
        ],
      ),
    );
  }
}

class _SpecialText {
  _SpecialText({required this.label, required this.emphasised});
  final String label;
  final bool emphasised;

  TextSpan buildTextSpan() {
    return TextSpan(
        text: label,
        style: TextStyle(
            fontSize: emphasised ? 20 : 15,
            fontWeight: emphasised ? FontWeight.bold : FontWeight.normal));
  }
}
