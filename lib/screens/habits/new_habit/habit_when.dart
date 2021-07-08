import 'package:intl/intl.dart';

import 'package:flutter/material.dart';
import 'package:habit/config/index.dart';
import 'package:habit/models/habit.dart';
import 'package:habit/services/habit.dart';

import '../index.dart';

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
  DateTime _today = DateTime.now();
  final _endDateDays = TextEditingController(text: "60");

  @override
  void initState() {
    _today = DateTime(_today.year, _today.month, _today.day);
    super.initState();
  }

  @override
  void dispose() {
    _endDateDays.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Almost there")),
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
              onPressed: this._isNextButtonEnabled
                  ? () {
                      this.widget.habit.save();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HabitsScreen(
                                    config: this.widget.config,
                                  )));
                    }
                  : null,
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.only(top: 20, bottom: 20),
              ),
              child: Text("Save"),
            )),
      ],
    );
  }

  Widget _startWhenInput() {
    final valueWidget = _decoratedText(
        _today.compareTo(this.widget.habit.startDate) == 0
            ? "Today"
            : DateFormat('dd MMM yyyy').format(this.widget.habit.startDate));
    return _buildInputOption(
        _openDateWizard(true), Icons.date_range, "Start date", valueWidget);
  }

  Widget _endWhenInput() {
    final valueWidget = Container(
      child: Switch(
        value: this.widget.habit.endDate != null,
        onChanged: (value) => {},
      ),
    );
    return Column(
      children: [
        _buildInputOption(
            _expandEndDate(), Icons.calendar_today, "Goal date", valueWidget),
        AnimatedContainer(
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          height: this.widget.habit.endDate != null ? 70 : 0,
          child: this.widget.habit.endDate != null
              ? _buildEndDate()
              : Container(
                  height: 0,
                  width: 0,
                ),
        )
      ],
    );
  }

  Widget _priorityInput() {
    final valueWidget =
        _decoratedText(this.widget.habit.priority.toEnumString());
    return _buildInputOption(
        _openPriorityWizard(), Icons.double_arrow, "Priority", valueWidget);
  }

  GestureTapCallback _openDateWizard(bool _isStartDate) {
    return () async {
      final DateTime? newDate = await showDatePicker(
        context: context,
        initialDate: _isStartDate
            ? this.widget.habit.startDate
            : this.widget.habit.endDate!,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 10000)),
        helpText: 'Select a date',
      );
      if (newDate != null) {
        setState(() {
          if (_isStartDate) {
            this.widget.habit.startDate = newDate;
          } else {
            this.widget.habit.endDate = newDate;
            int difference =
                newDate.difference(this.widget.habit.startDate).inDays;
            _endDateDays.text = difference.toString();

            _isNextButtonEnabled = difference >= 0;
            _errorMessage = _isNextButtonEnabled
                ? ""
                : "end date should be atleast the start date";
          }
        });
      }
    };
  }

  GestureTapCallback _expandEndDate() {
    return () => {
          setState(() {
            if (this.widget.habit.endDate == null) {
              this.widget.habit.endDate =
                  this.widget.habit.startDate.add(Duration(days: 60));
              _endDateDays.text = "60";
            } else {
              this.widget.habit.endDate = null;
              _isNextButtonEnabled = true;
              _errorMessage = "";
            }
          })
        };
  }

  GestureTapCallback _openPriorityWizard() {
    return () async {
      await showDialog(
          context: context,
          builder: (context) {
            return SimpleDialog(
                title: Text(
                  "Priority",
                  style: TextStyle(
                      color:
                          Theme.of(context).accentTextTheme.headline1?.color),
                ),
                backgroundColor: Theme.of(context).accentColor,
                children: [
                  ...Priority.values.map(_buildPriorityOption).toList(),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context, false);
                    },
                    child: Container(
                        padding: EdgeInsets.only(top: 15, left: 30, right: 30),
                        decoration: BoxDecoration(
                          color: Theme.of(context).accentColor,
                        ),
                        child: Center(
                            child: Text(
                          "Close",
                          style: TextStyle(
                              color: Theme.of(context)
                                  .accentTextTheme
                                  .button
                                  ?.color),
                        ))),
                  )
                ]);
          });
    };
  }

  InkWell _buildPriorityOption(Priority p) {
    return InkWell(
      onTap: () {
        setState(() {
          this.widget.habit.priority = p;
        });

        Navigator.pop(context, false);
      },
      child: Container(
        padding: EdgeInsets.only(top: 15, bottom: 15, left: 30, right: 30),
        decoration: BoxDecoration(
          color: Theme.of(context).backgroundColor,
        ),
        child: Text(
          p.toEnumString(),
        ),
      ),
    );
  }

  Widget _buildEndDate() {
    return Container(
      padding: EdgeInsets.only(right: 16, left: 68),
      margin: EdgeInsets.only(bottom: 10),
      width: MediaQuery.of(context).size.width - 80,
      child: Row(
        children: [
          InkWell(
            onTap: _openDateWizard(false),
            child: _decoratedText(
                _today.compareTo(this.widget.habit.endDate!) == 0
                    ? "Today"
                    : DateFormat('dd MMM yyyy')
                        .format(this.widget.habit.endDate!)),
          ),
          Container(
            width: 70,
            margin: EdgeInsets.only(left: 20, right: 20),
            child: TextFormField(
              controller: _endDateDays,
              textAlign: TextAlign.center,
              onChanged: (value) {
                Future.delayed(const Duration(milliseconds: 200), () {
                  bool nextBtnEnabled = false;
                  if (_endDateDays.text.isNotEmpty) {
                    int endDateDays = int.parse(_endDateDays.text);
                    this.widget.habit.endDate = this
                        .widget
                        .habit
                        .startDate
                        .add(Duration(days: endDateDays));
                    if (endDateDays >= 0) {
                      nextBtnEnabled = true;
                    }
                  }
                  setState(() {
                    _isNextButtonEnabled = nextBtnEnabled;
                    _errorMessage = _isNextButtonEnabled
                        ? ""
                        : "end date should be atleast the start date";
                  });
                });
              },
              keyboardType: TextInputType.number,
            ),
          ),
          Text("days"),
        ],
      ),
    );
  }

  Container _decoratedText(String text) {
    return Container(
      child: Text(text),
      padding: EdgeInsets.only(top: 10, left: 24, bottom: 10, right: 24),
      decoration: BoxDecoration(
          color: Theme.of(context).accentColor.withAlpha(40),
          border: Border.all(color: Theme.of(context).accentColor),
          borderRadius: BorderRadius.circular(7)),
    );
  }

  Widget _buildInputOption(GestureTapCallback? onTap, IconData icon,
      String label, Widget valueWidget) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                    margin: EdgeInsets.only(right: 10), child: Icon(icon)),
                Text(label),
              ],
            ),
            valueWidget
          ],
        ),
      ),
    );
  }
}
