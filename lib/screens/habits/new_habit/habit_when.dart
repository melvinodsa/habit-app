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
        children: [
          _startWhenInput(),
          _endWhenInput(),
          _priorityInput(),
        ],
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

  Widget _startWhenInput() {
    return InkWell(
      onTap: () => {},
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                    margin: EdgeInsets.only(right: 10),
                    child: Icon(Icons.date_range)),
                Text("Start date"),
              ],
            ),
            Container(
              child: Text("Today"),
              padding:
                  EdgeInsets.only(top: 10, left: 24, bottom: 10, right: 24),
              decoration: BoxDecoration(
                  color: Theme.of(context).accentColor.withAlpha(40),
                  border: Border.all(color: Theme.of(context).accentColor),
                  borderRadius: BorderRadius.circular(7)),
            )
          ],
        ),
      ),
    );
  }

  Widget _endWhenInput() {
    return InkWell(
      onTap: () => {},
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                    margin: EdgeInsets.only(right: 10),
                    child: Icon(Icons.calendar_today)),
                Text("Goal date"),
              ],
            ),
            Container(
              child: Switch(
                value: false,
                onChanged: (value) => {},
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _priorityInput() {
    return InkWell(
      onTap: () => {},
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                    margin: EdgeInsets.only(right: 10),
                    child: Icon(Icons.double_arrow)),
                Text("Priority"),
              ],
            ),
            Container(
              child: Text("Normal"),
              padding:
                  EdgeInsets.only(top: 10, left: 20, bottom: 10, right: 20),
              decoration: BoxDecoration(
                  color: Theme.of(context).accentColor.withAlpha(40),
                  border: Border.all(color: Theme.of(context).accentColor),
                  borderRadius: BorderRadius.circular(7)),
            )
          ],
        ),
      ),
    );
  }
}
