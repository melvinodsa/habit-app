import 'package:flutter/material.dart';
import 'package:habit/config/index.dart';
import 'package:habit/screens/habits/index.dart';

class Screens extends StatelessWidget {
  Screens({required this.config});
  final AppConfig config;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Habits',
      debugShowCheckedModeBanner: false,
      theme: config.theme,
      home: HabitsScreen(
        config: config,
      ),
    );
  }
}
