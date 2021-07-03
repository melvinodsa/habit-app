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
  Frequency? _frequency = Frequency.Everyday;
  bool _isDaysOfWeekVisible = false;
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
    return Container(
      margin: EdgeInsets.only(bottom: 40),
      child: Column(
        children: [
          _everydayOption(),
          _daysOfWeekOption(),
          _periodicOption(),
          _repeatOption(),
        ],
      ),
    );
  }

  ListTile _repeatOption() {
    return ListTile(
      title: const Text('Repeat'),
      leading: Radio<Frequency>(
        value: Frequency.Repeat,
        groupValue: _frequency,
        onChanged: (Frequency? value) {
          setState(() {
            _frequency = value;
            _isDaysOfWeekVisible = false;
          });
          this.widget.habit.frequency = Frequency.Repeat;
        },
      ),
    );
  }

  ListTile _periodicOption() {
    return ListTile(
      title: const Text('Some times per period'),
      leading: Radio<Frequency>(
        value: Frequency.Periodically,
        groupValue: _frequency,
        onChanged: (Frequency? value) {
          setState(() {
            _frequency = value;
            _isDaysOfWeekVisible = false;
          });
          this.widget.habit.frequency = Frequency.Periodically;
        },
      ),
    );
  }

  Widget _daysOfWeekOption() {
    return Column(
      children: [
        ListTile(
          title: const Text('Some days of the week'),
          leading: Radio<Frequency>(
            value: Frequency.DaysOfWeek,
            groupValue: _frequency,
            onChanged: (Frequency? value) {
              setState(() {
                _frequency = value;
                _isDaysOfWeekVisible = true;
              });
              this.widget.habit.frequency = Frequency.DaysOfWeek;
            },
          ),
        ),
        AnimatedSwitcher(
          duration: Duration(milliseconds: 100),
          child: _isDaysOfWeekVisible
              ? _buildDaysOfWeek()
              : Container(
                  height: 0,
                  width: 0,
                ),
        )
      ],
    );
  }

  ListTile _everydayOption() {
    return ListTile(
      title: const Text('Everyday'),
      leading: Radio<Frequency>(
        value: Frequency.Everyday,
        groupValue: _frequency,
        onChanged: (Frequency? value) {
          setState(() {
            _frequency = value;
            _isDaysOfWeekVisible = false;
          });
          this.widget.habit.frequency = Frequency.Everyday;
        },
      ),
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

  Widget _buildDaysOfWeek() {
    return Wrap(
      children: [
        _buildDayOfWeek('Monday'),
        _buildDayOfWeek('Tuesday'),
        _buildDayOfWeek('Wednesday'),
        _buildDayOfWeek('Thursday'),
        _buildDayOfWeek('Friday'),
        _buildDayOfWeek('Saturday'),
        _buildDayOfWeek('Sunday'),
      ],
    );
  }

  SizedBox _buildDayOfWeek(String _day) {
    return SizedBox(
      width: 180,
      child: CheckboxListTile(
        value: false,
        controlAffinity: ListTileControlAffinity.leading,
        title: Text(_day),
        onChanged: (bool? value) {
          setState(() {});
        },
      ),
    );
  }
}
