import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CardData {
  late String label;
  late Widget icon;
  late Color color;
}

class CardWithIcon implements CardData {
  CardWithIcon(
      {required this.label, required this.iconData, required this.color}) {
    this.icon = Icon(this.iconData, color: this.color);
  }

  late String label;
  final IconData iconData;
  late Color color;
  late Widget icon;
}

class CardWithSvg implements CardData {
  CardWithSvg(
      {required this.label, required this.svgPath, required this.color}) {
    this.icon = SvgPicture.asset(
      this.svgPath,
      semanticsLabel: this.label,
      width: 24,
      height: 24,
      color: this.color,
    );
  }
  late String label;
  final String svgPath;
  late Color color;
  late Widget icon;
}
