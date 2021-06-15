import 'package:flutter/material.dart';
import 'package:habit/config/index.dart';
import 'package:habit/config/theme.dart';

import 'habits/index.dart';

class Screens extends StatelessWidget {
  Screens({required this.config});
  final AppConfig config;
  @override
  Widget build(BuildContext context) {
    var colorScheme = this.config.theme.appTheme.getLayoutColors();
    return MaterialApp(
      title: 'Habits',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: colorScheme.primarySwatch,
          scaffoldBackgroundColor: colorScheme.backgroundColor,
          appBarTheme: AppBarTheme(
              backgroundColor: colorScheme.navbarBackground,
              titleTextStyle: TextStyle(color: colorScheme.primaryTextColor))),
      home: HabitsScreen(
        config: this.config,
      ),
    );
  }
}
