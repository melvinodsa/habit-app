import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:habit/config/index.dart';
import 'package:habit/models/habit.dart';
import 'package:habit/screens/habits/new_habit/habit_frequency.dart';

class HabitDetails extends StatefulWidget {
  HabitDetails({Key? key, required this.config, required this.habit})
      : super(key: key);

  final AppConfig config;
  final Habit habit;

  @override
  _HabitDetailsState createState() => _HabitDetailsState();
}

class _HabitDetailsState extends State<HabitDetails> {
  bool _isNextButtonEnabled = false;
  final _nameText = TextEditingController();
  final _goalText = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Details")),
      body: _buildBody(),
    );
  }

  @override
  void dispose() {
    _nameText.dispose();
    _goalText.dispose();
    super.dispose();
  }

  bool _areRequiredFieldsAreFilled() {
    if (_nameText.text.isEmpty) {
      return false;
    }
    if (this.widget.habit.name.length == 0) {
      return false;
    }
    if (this.widget.habit.trackProgress == TrackProgress.WithYesOrNo) {
      return true;
    }

    if (_goalText.text.isEmpty) {
      return false;
    }
    return true;
  }

  updateFieldsCheck() {
    setState(() {
      this._isNextButtonEnabled = _areRequiredFieldsAreFilled();
    });
  }

  void Function() _gotoHabitFrequency() {
    return () => {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => HabitFrequency(
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
          controller: _nameText,
          onChanged: (value) {
            this.widget.habit.name = value;
            updateFieldsCheck();
          },
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
        margin: EdgeInsets.only(bottom: 40),
        child: TextFormField(
          onChanged: (value) {
            this.widget.habit.description = value;
          },
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
          controller: _nameText,
          onChanged: (value) {
            this.widget.habit.name = value;
            updateFieldsCheck();
          },
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
                value: NumericalTrackOperator.Atleast.toEnumString(),
                onChanged: (val) => {
                  this.widget.habit.operator =
                      parseNumericalTrackOperator(val.toString()),
                  updateFieldsCheck()
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                ),
                items: [
                  DropdownMenuItem(
                    value: NumericalTrackOperator.Atleast.toEnumString(),
                    child: Text("At least"),
                  ),
                  DropdownMenuItem(
                    value: NumericalTrackOperator.LessThan.toEnumString(),
                    child: Text("Less than"),
                  ),
                  DropdownMenuItem(
                    value: NumericalTrackOperator.Exactly.toEnumString(),
                    child: Text("Exactly"),
                  ),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width / 2 - 90,
              child: TextFormField(
                controller: _goalText,
                onChanged: (value) {
                  Future.delayed(const Duration(milliseconds: 200), () {
                    updateFieldsCheck();
                    if (_goalText.text.isNotEmpty) {
                      this.widget.habit.goal = int.parse(_goalText.text);
                    }
                    setState(() {});
                  });
                },
                keyboardType: TextInputType.number,
                // inputFormatters: <TextInputFormatter>[
                //   FilteringTextInputFormatter.digitsOnly,
                // ],
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
                onChanged: (value) {
                  this.widget.habit.unit = value;
                },
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
        margin: EdgeInsets.only(bottom: 40),
        child: TextFormField(
          onChanged: (value) {
            this.widget.habit.description = value;
          },
          decoration: InputDecoration(
            labelText: 'Description (optional)',
            border: OutlineInputBorder(),
          ),
        ),
      )
    ];
  }

  Widget _buildNextButton() {
    return Container(
        width: MediaQuery.of(context).size.width - 80,
        child: ElevatedButton(
          onPressed: this._isNextButtonEnabled ? _gotoHabitFrequency() : null,
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.only(top: 20, bottom: 20),
            // textStyle: TextStyle(color: theme.disabledColor)
          ),
          child: Text("Next"),
        ));
  }
}
