import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
  void _incrementCounter() {}

  @override
  Widget build(BuildContext context) {
    var styles = this.widget.config.theme.appTheme.getLayoutColors();
    final String assetName = 'assets/award.svg';
    final Widget svgIcon = SvgPicture.asset(
      assetName,
      semanticsLabel: 'Make it a habit',
      width: 100,
      height: 100,
    );
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text("My Habits"),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(
                  left: 30.0, top: 20.0, right: 30.0, bottom: 20.0),
              child: svgIcon,
            ),
            Text(
              getRandomInspirationalMessage(),
              style: TextStyle(color: styles.primaryTextColor),
            ),
            Container(
              margin: EdgeInsets.only(
                  left: 30.0, top: 20.0, right: 30.0, bottom: 20.0),
              child: Text(
                'Let\'s start a new habit',
                style: TextStyle(
                    color: styles.primaryTextColor.withAlpha(150),
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
