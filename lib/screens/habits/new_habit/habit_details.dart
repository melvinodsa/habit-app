import 'package:flutter/material.dart';
import 'package:habit/config/index.dart';
import 'package:habit/models/habit.dart';

class HabitDetails extends StatefulWidget {
  HabitDetails({Key? key, required this.config, required this.habit})
      : super(key: key);

  final AppConfig config;
  final Habit habit;

  @override
  _HabitDetailsState createState() => _HabitDetailsState();
}

class _HabitDetailsState extends State<HabitDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Details")),
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
        ],
      ),
    );
  }

  Widget _buildQuestion() {
    return Center(
      child: Container(
        margin: EdgeInsets.only(bottom: 40),
        child: Text(
          "Define your habit",
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
    var inputs = this.widget.habit.trackProgress == TrackProgress.WithYesOrNo
        ? _buildYesOrNoInputs()
        : _buildNumericalInputs();
    return Column(
      children: inputs,
    );
  }

  List<Widget> _buildYesOrNoInputs() {
    var theme = Theme.of(context);
    return [
      Container(
        margin: EdgeInsets.only(bottom: 30),
        child: TextFormField(
          decoration: InputDecoration(
            labelText: 'Habit',
            border: OutlineInputBorder(),
          ),
        ),
      ),
      Container(
        margin: EdgeInsets.only(bottom: 30),
        child: Text(
          "e.g., Buy groceries in the morning.",
          style: TextStyle(color: theme.textTheme.caption?.color),
        ),
      ),
      Container(
        margin: EdgeInsets.only(bottom: 30),
        child: TextFormField(
          decoration: InputDecoration(
            labelText: 'Description (optional)',
            border: OutlineInputBorder(),
          ),
        ),
      ),
    ];
  }

  List<Widget> _buildNumericalInputs() {
    var theme = Theme.of(context);
    return [
      Container(
        margin: EdgeInsets.only(bottom: 30),
        child: TextFormField(
          decoration: InputDecoration(
            labelText: 'Habit',
            border: OutlineInputBorder(),
          ),
        ),
      ),
      Container(
        width: MediaQuery.of(context).size.width - 80,
        margin: EdgeInsets.only(bottom: 30),
        child: Row(
          children: [
            Container(
              width: MediaQuery.of(context).size.width / 2 - 90,
              margin: EdgeInsets.only(right: 10),
              child: DropdownButtonFormField(
                value: "At least",
                onChanged: (val) => {},
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                ),
                items: [
                  DropdownMenuItem(
                    value: "At least",
                    child: Text("At least"),
                  ),
                  DropdownMenuItem(
                    value: "Less than",
                    child: Text("Less than"),
                  ),
                  DropdownMenuItem(
                    value: "Exactly",
                    child: Text("Exactly"),
                  ),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width / 2 - 90,
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: 'Goal',
                  border: OutlineInputBorder(),
                ),
              ),
            )
          ],
        ),
      ),
      Container(
        width: MediaQuery.of(context).size.width - 80,
        margin: EdgeInsets.only(bottom: 30),
        child: Row(
          children: [
            Container(
              width: MediaQuery.of(context).size.width / 2 - 80,
              margin: EdgeInsets.only(right: 10),
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: 'Unit (optional)',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Text("a day.")
          ],
        ),
      ),
      Container(
          margin: EdgeInsets.only(bottom: 30),
          child: Text(
            "e.g., Eat healthy. Exactly 2000 Kcal. a day.",
            style: TextStyle(color: theme.textTheme.caption?.color),
          )),
      Container(
        margin: EdgeInsets.only(bottom: 30),
        child: TextFormField(
          decoration: InputDecoration(
            labelText: 'Description (optional)',
            border: OutlineInputBorder(),
          ),
        ),
      )
    ];
  }
}
