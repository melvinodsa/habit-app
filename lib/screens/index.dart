import 'package:flutter/material.dart';
import 'package:habit/config/index.dart';
import 'package:habit/models/card_data.dart';
import 'package:habit/models/habit.dart';
import 'package:habit/screens/habits/new_habit/habit_frequency.dart';

class Screens extends StatelessWidget {
  Screens({required this.config});
  final AppConfig config;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Habits',
      debugShowCheckedModeBanner: false,
      theme: config.theme,
      home: HabitFrequency(
        config: config,
        habit: Habit(
            category: Category(
                data: CardWithIcon(
                    id: 13,
                    label: 'Work',
                    iconData: Icons.work,
                    color: Colors.brown))),
      ),
    );
  }
}
