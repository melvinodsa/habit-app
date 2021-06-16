import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:habit/components/buttons/expandable_fab.dart';
import 'package:habit/config/index.dart';
import 'package:habit/config/theme.dart';
import 'package:habit/constants/inspirational_messages.dart';

class HabitsScreen extends StatefulWidget {
  HabitsScreen({Key? key, required this.config}) : super(key: key);

  final AppConfig config;

  @override
  _HabitsScreenState createState() => _HabitsScreenState();
}

class _HabitsScreenState extends State<HabitsScreen> {
  void _actionPressed() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("My Habits")),
      body: _buildHabitBody(),
      floatingActionButton:
          _buildFabButton(), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  ExpandableFab _buildFabButton() {
    return ExpandableFab(
      children: [
        FloatingActionButton.extended(
          onPressed: _actionPressed,
          icon: Icon(Icons.add_circle_outline_rounded),
          label: Text("New Habit"),
        )
      ],
    );
  }

  Center _buildHabitBody() {
    var styles = this.widget.config.theme.appTheme.getLayoutColors();
    final String assetName = 'assets/award.svg';
    final Widget svgIcon = SvgPicture.asset(
      assetName,
      semanticsLabel: 'Make it a habit',
      width: 100,
      height: 100,
    );
    return Center(
      child: Container(
        margin:
            EdgeInsets.only(left: 30.0, top: 20.0, right: 30.0, bottom: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            svgIcon,
            Container(
              padding: EdgeInsets.only(
                  left: 13.0, top: 15.0, right: 13.0, bottom: 25.0),
              child: Text(
                getRandomInspirationalMessage(),
                style: TextStyle(color: styles.primaryTextColor),
              ),
            ),
            Text(
              'Let\'s start a new habit',
              style: TextStyle(
                  color: styles.primaryTextColor.withAlpha(150),
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
