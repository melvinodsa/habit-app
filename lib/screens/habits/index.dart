import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:habit/components/buttons/expandable_fab.dart';
import 'package:habit/config/index.dart';
import 'package:habit/constants/inspirational_messages.dart';
import 'package:habit/screens/habits/new_habit/index.dart';

class HabitsScreen extends StatefulWidget {
  HabitsScreen({Key? key, required this.config}) : super(key: key);

  final AppConfig config;

  @override
  _HabitsScreenState createState() => _HabitsScreenState();
}

class _HabitsScreenState extends State<HabitsScreen> {
  void _initiateHabitCreateWizard() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => NewHabitWizardCategory(
                config: this.widget.config,
              ),
          settings: RouteSettings(name: "/habit/new")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("My Habits")),
      body: _buildHabitBody(),
      floatingActionButton:
          _buildFabButton(), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Center _buildHabitBody() {
    return Center(
      child: Container(
        margin:
            EdgeInsets.only(left: 30.0, top: 20.0, right: 30.0, bottom: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _backgroundIcon(),
            _inspirationMessage(),
            _createHabitNudge(),
          ],
        ),
      ),
    );
  }

  Text _createHabitNudge() {
    return Text(
      'Let\'s start a new habit',
      style: TextStyle(fontWeight: FontWeight.bold),
    );
  }

  SvgPicture _backgroundIcon() {
    final String assetName = 'assets/award.svg';
    return SvgPicture.asset(
      assetName,
      semanticsLabel: 'Make it a habit',
      width: 100,
      height: 100,
    );
  }

  Container _inspirationMessage() {
    return Container(
      padding:
          EdgeInsets.only(left: 13.0, top: 15.0, right: 13.0, bottom: 25.0),
      child: Text(
        getRandomInspirationalMessage(),
      ),
    );
  }

  ExpandableFab _buildFabButton() {
    return ExpandableFab(
      children: [
        FloatingActionButton.extended(
          onPressed: _initiateHabitCreateWizard,
          icon: Icon(Icons.add_circle_outline_rounded),
          label: Text("New Habit"),
          heroTag: "newHabit",
        )
      ],
    );
  }
}
