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
  final _timePerWeek = TextEditingController(text: "1");
  final _repeatFrequency = TextEditingController(text: "1");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Frequency")),
      body: _buildBody(),
    );
  }

  @override
  void dispose() {
    _timePerWeek.dispose();
    super.dispose();
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

  RadioListTile _everydayOption() {
    return RadioListTile(
      title: Text('Everyday'),
      value: Frequency.Everyday,
      groupValue: _frequency,
      onChanged: (value) {
        setState(() {
          _frequency = value;
        });

        this.widget.habit.frequency = Frequency.Everyday;
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
            });
            this.widget.habit.frequency = Frequency.DaysOfWeek;
          },
        ),
        AnimatedContainer(
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          height: _frequency == Frequency.DaysOfWeek ? 100 : 0,
          child: _frequency == Frequency.DaysOfWeek
              ? _buildDaysOfWeek()
              : Container(
                  height: 0,
                  width: 0,
                ),
        )
      ],
    );
  }

  Widget _periodicOption() {
    return Column(
      children: [
        RadioListTile(
          title: const Text('Some times per period'),
          value: Frequency.Periodically,
          groupValue: _frequency,
          onChanged: (Frequency? value) {
            setState(() {
              _frequency = value;
            });
            this.widget.habit.frequency = Frequency.Periodically;
          },
        ),
        AnimatedContainer(
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          height: _frequency == Frequency.Periodically ? 70 : 0,
          child: _frequency == Frequency.Periodically
              ? _buildPeriodic()
              : Container(
                  height: 0,
                  width: 0,
                ),
        )
      ],
    );
  }

  Widget _repeatOption() {
    return Column(
      children: [
        RadioListTile(
          title: const Text('Repeat'),
          value: Frequency.Repeat,
          groupValue: _frequency,
          onChanged: (Frequency? value) {
            setState(() {
              _frequency = value;
            });
            this.widget.habit.frequency = Frequency.Repeat;
          },
        ),
        AnimatedContainer(
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          height: _frequency == Frequency.Repeat ? 70 : 0,
          child: _frequency == Frequency.Repeat
              ? _buildRepeat()
              : Container(
                  height: 0,
                  width: 0,
                ),
        )
      ],
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

  Widget _buildPeriodic() {
    return Container(
      padding: EdgeInsets.only(right: 16, left: 68),
      margin: EdgeInsets.only(bottom: 10),
      width: MediaQuery.of(context).size.width - 80,
      height: 70,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 40,
            child: TextFormField(
              controller: _timePerWeek,
              textAlign: TextAlign.center,
              onChanged: (value) {
                Future.delayed(const Duration(milliseconds: 200), () {
                  if (_timePerWeek.text.isNotEmpty) {}
                  setState(() {});
                });
              },
              keyboardType: TextInputType.number,
            ),
          ),
          Container(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Text("times per")),
          SizedBox(
            width: 80,
            child: DropdownButtonFormField(
              value: "Week",
              onChanged: (val) => {},
              items: [
                DropdownMenuItem(
                  value: "Week",
                  child: Text("Week"),
                ),
                DropdownMenuItem(
                  value: "Month",
                  child: Text("Month"),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildRepeat() {
    return Container(
      padding: EdgeInsets.only(right: 16, left: 68),
      margin: EdgeInsets.only(bottom: 10),
      width: MediaQuery.of(context).size.width - 80,
      height: 70,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
              padding: EdgeInsets.only(left: 0, right: 20),
              child: Text("Every")),
          SizedBox(
            width: 40,
            child: TextFormField(
              controller: _repeatFrequency,
              textAlign: TextAlign.center,
              onChanged: (value) {
                Future.delayed(const Duration(milliseconds: 200), () {
                  if (_repeatFrequency.text.isNotEmpty) {}
                  setState(() {});
                });
              },
              keyboardType: TextInputType.number,
            ),
          ),
          Container(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Text("day")),
        ],
      ),
    );
  }
}
