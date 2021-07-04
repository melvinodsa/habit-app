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
  FrequencyType? _frequency = FrequencyType.Everyday;
  final _timePerWeek = TextEditingController(text: "1");
  final _repeatFrequency = TextEditingController(text: "2");
  bool _isNextButtonEnabled = true;
  String _errorMessage = "";
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

  void Function() _gotoWhenScreen() {
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

  Widget _buildNextButton() {
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
              onPressed: this._isNextButtonEnabled ? _gotoWhenScreen() : null,
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.only(top: 20, bottom: 20),
              ),
              child: Text("Next"),
            )),
      ],
    );
  }

  RadioListTile _everydayOption() {
    return RadioListTile(
      title: Text('Everyday'),
      value: FrequencyType.Everyday,
      groupValue: _frequency,
      onChanged: (value) {
        setState(() {
          _frequency = value;
          _isNextButtonEnabled = true;
          _errorMessage = "";
        });

        this.widget.habit.frequency.type = FrequencyType.Everyday;
      },
    );
  }

  Widget _daysOfWeekOption() {
    return Column(
      children: [
        RadioListTile(
          title: const Text('Some days of the week'),
          value: FrequencyType.DaysOfWeek,
          groupValue: _frequency,
          onChanged: (FrequencyType? value) {
            setState(() {
              _frequency = value;
              _isNextButtonEnabled =
                  this.widget.habit.frequency.weekdays.isNotEmpty;
              _errorMessage =
                  _isNextButtonEnabled ? "" : "Select atleast a day";
            });
            this.widget.habit.frequency.type = FrequencyType.DaysOfWeek;
          },
        ),
        AnimatedContainer(
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          height: _frequency == FrequencyType.DaysOfWeek ? 100 : 0,
          child: _frequency == FrequencyType.DaysOfWeek
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
          value: FrequencyType.Periodically,
          groupValue: _frequency,
          onChanged: (FrequencyType? value) {
            setState(() {
              _frequency = value;
              _isNextButtonEnabled = true;
              _errorMessage = "";
            });
            this.widget.habit.frequency.type = FrequencyType.Periodically;
            this.widget.habit.frequency.period = 1;
            this.widget.habit.frequency.repeatPer = Repeat.Week;
          },
        ),
        AnimatedContainer(
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          height: _frequency == FrequencyType.Periodically ? 70 : 0,
          child: _frequency == FrequencyType.Periodically
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
          value: FrequencyType.Repeat,
          groupValue: _frequency,
          onChanged: (FrequencyType? value) {
            setState(() {
              _frequency = value;
              _isNextButtonEnabled = true;
              _errorMessage = "";
            });
            this.widget.habit.frequency.type = FrequencyType.Repeat;
            this.widget.habit.frequency.period = 2;
          },
        ),
        AnimatedContainer(
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          height: _frequency == FrequencyType.Repeat ? 70 : 0,
          child: _frequency == FrequencyType.Repeat
              ? _buildRepeat()
              : Container(
                  height: 0,
                  width: 0,
                ),
        )
      ],
    );
  }

  Widget _buildDaysOfWeek() {
    return Wrap(
      children: Weekday.values.map((e) => _buildDayOfWeek(e)).toList(),
    );
  }

  SizedBox _buildDayOfWeek(Weekday _day) {
    return SizedBox(
      width: 180,
      child: CheckboxListTile(
        value: this.widget.habit.frequency.weekdays.contains(_day),
        controlAffinity: ListTileControlAffinity.leading,
        title: Text(_day.toEnumString()),
        onChanged: (bool? value) {
          setState(() {
            if (value == null || !value) {
              this.widget.habit.frequency.weekdays.remove(_day);
            } else {
              this.widget.habit.frequency.weekdays.add(_day);
            }
            _isNextButtonEnabled =
                this.widget.habit.frequency.weekdays.isNotEmpty;
            _errorMessage = _isNextButtonEnabled ? "" : "Select atleast a day";
          });
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
                  bool nextBtnEnabled = false;
                  if (_timePerWeek.text.isNotEmpty) {
                    int period = int.parse(_timePerWeek.text);
                    if (period >= 1) {
                      this.widget.habit.frequency.period = period;
                      nextBtnEnabled = true;
                    }
                  }
                  setState(() {
                    _isNextButtonEnabled = nextBtnEnabled;
                    _errorMessage = _isNextButtonEnabled
                        ? ""
                        : "frequency should be atleast 1";
                  });
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
              value: Repeat.Week,
              onChanged: (Repeat? val) => {
                if (val is Repeat)
                  {
                    setState(() {
                      this.widget.habit.frequency.repeatPer = val;
                    })
                  }
              },
              items: Repeat.values
                  .map((e) => DropdownMenuItem(
                        value: e,
                        child: Text(e.toEnumString()),
                      ))
                  .toList(),
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
                  bool nextBtnEnabled = false;
                  if (_repeatFrequency.text.isNotEmpty) {
                    int period = int.parse(_repeatFrequency.text);
                    if (period >= 2) {
                      this.widget.habit.frequency.period = period;
                      nextBtnEnabled = true;
                    }
                  }
                  setState(() {
                    _isNextButtonEnabled = nextBtnEnabled;
                    _errorMessage = _isNextButtonEnabled
                        ? ""
                        : "frequency should be atleast 2";
                  });
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
