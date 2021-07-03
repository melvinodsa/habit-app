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

  RadioListTile _repeatOption() {
    return RadioListTile(
      title: const Text('Repeat'),
      value: Frequency.Repeat,
      groupValue: _frequency,
      onChanged: (value) {
        setState(() {
          _frequency = value;
          _isDaysOfWeekVisible = false;
        });
        this.widget.habit.frequency = Frequency.Repeat;
      },
    );
  }

  RadioListTile _periodicOption() {
    return RadioListTile(
      title: const Text('Some times per period'),
      value: Frequency.Periodically,
      groupValue: _frequency,
      onChanged: (value) {
        setState(() {
          _frequency = value;
          _isDaysOfWeekVisible = false;
        });
        this.widget.habit.frequency = Frequency.Periodically;
      },
    );
  }

  Widget _daysOfWeekOption() {
    return Column(
      children: [
        RadioListTile(
          title: const Text('Some days of the week'),
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
        AnimatedSwitcher(
          duration: Duration(milliseconds: 300),
          transitionBuilder: _daysOfWeekTransitionBuilder,
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

  RadioListTile _everydayOption() {
    return RadioListTile(
      title: Text('Everyday'),
      value: Frequency.Everyday,
      groupValue: _frequency,
      onChanged: (value) {
        setState(() {
          _frequency = value;
          _isDaysOfWeekVisible = false;
        });
        this.widget.habit.frequency = Frequency.Everyday;
      },
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
        _buildDayOfWeek('Sunday'),
        _buildDayOfWeek('Monday'),
        _buildDayOfWeek('Tuesday'),
        _buildDayOfWeek('Wednesday'),
        _buildDayOfWeek('Thursday'),
        _buildDayOfWeek('Friday'),
        _buildDayOfWeek('Saturday'),
      ],
    );
  }

  Widget _daysOfWeekTransitionBuilder(
      Widget child, Animation<double> animation) {
    final offsetAnimation =
        Tween<Offset>(begin: Offset(0.0, -0.5), end: Offset(0.0, 0.0))
            .animate(animation);
    return SlideTransition(
      position: offsetAnimation,
      child: child,
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
