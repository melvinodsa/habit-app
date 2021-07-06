import 'package:intl/intl.dart';

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
  DateTime _today = DateTime.now();
  final _endDateDays = TextEditingController(text: "60");

  @override
  void initState() {
    _today = DateTime(_today.year, _today.month, _today.day);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Almost there")),
      body: _buildBody(),
    );
  }

  @override
  void dispose() {
    _endDateDays.dispose();
    super.dispose();
  }

  void _openDateWizard(bool _isStartDate) async {
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
          _endDateDays.text =
              newDate.difference(this.widget.habit.startDate).inDays.toString();
        }
      });
    }
  }

  void _openPriorityWizard() async {
    await showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
              title: Text(
                "Priority",
                style: TextStyle(
                    color: Theme.of(context).accentTextTheme.headline1?.color),
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
      onTap: () {
        _openDateWizard(true);
      },
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
            _decoratedText(_today.compareTo(this.widget.habit.startDate) == 0
                ? "Today"
                : DateFormat('dd MMM yyyy').format(this.widget.habit.startDate))
          ],
        ),
      ),
    );
  }

  Widget _endWhenInput() {
    return Column(
      children: [
        InkWell(
          onTap: () => {
            setState(() {
              if (this.widget.habit.endDate == null) {
                this.widget.habit.endDate =
                    this.widget.habit.startDate.add(Duration(days: 60));
                _endDateDays.text = "60";
              } else {
                this.widget.habit.endDate = null;
              }
            })
          },
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
                    value: this.widget.habit.endDate != null,
                    onChanged: (value) => {},
                  ),
                )
              ],
            ),
          ),
        ),
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
    return InkWell(
      onTap: _openPriorityWizard,
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
            _decoratedText(this.widget.habit.priority.toEnumString()),
          ],
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
            onTap: () {
              _openDateWizard(false);
            },
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
                        : "endate should be atleast today";
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
}
