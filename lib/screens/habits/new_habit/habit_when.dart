import 'package:flutter/material.dart';
import 'package:habit/config/index.dart';
import 'package:habit/models/habit.dart';

class HabitWhen extends StatefulWidget {
  HabitWhen({Key? key, required this.config, required this.habit})
      : super(key: key);

  final AppConfig config;
  final Habit habit;

  @override
  _HabitWhenState createState() => _HabitWhenState();
}

class _HabitWhenState extends State<HabitWhen> {
  bool _isNextButtonEnabled = true;
  String _errorMessage = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Almost there")),
      body: _buildBody(),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget _buildBody() {
    return Container(
      margin: EdgeInsets.all(40),
      child: Column(
        children: [
          _buildQuestion(),
          _buildInputs(),
          _buildSaveButton(),
        ],
      ),
    );
  }

  Widget _buildQuestion() {
    return Center(
      child: Container(
        margin: EdgeInsets.only(bottom: 40),
        child: Text(
          "When do you want to do it?",
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
    return Container(
      margin: EdgeInsets.only(bottom: 40),
      child: Column(
        children: [],
      ),
    );
  }

  Widget _buildSaveButton() {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(bottom: 20),
          child: Text(
            _errorMessage,
            style: TextStyle(color: Colors.redAccent),
          ),
        ),
        Container(
            width: MediaQuery.of(context).size.width - 80,
            child: ElevatedButton(
              onPressed: this._isNextButtonEnabled ? () => {} : null,
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.only(top: 20, bottom: 20),
              ),
              child: Text("Save"),
            )),
      ],
    );
  }
}
