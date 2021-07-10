import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

abstract class CardData {
  late int id;
  late String label;
  late Widget icon;
  late Color color;
  late CardType cardType;

  Map<String, dynamic> toMap();
  factory CardData.fromMap(Map<String, dynamic> map) {
    final _cardType =
        CardType.values.firstWhere((e) => e.toInt() == map["cardType"]);
    switch (_cardType) {
      case CardType.Icon:
        return CardWithIcon.fromMap(map);
      case CardType.Svg:
        return CardWithSvg.fromMap(map);
      default:
        return CardWithIcon.fromMap(map);
    }
  }
}

enum CardType {
  Icon,
  Svg,
}

extension CardTypeExtn on CardType {
  int toInt() {
    switch (this) {
      case CardType.Icon:
        return 0;
      case CardType.Svg:
        return 1;
      default:
        return 0;
    }
  }
}

class CardWithIcon implements CardData {
  CardWithIcon(
      {required this.id,
      required this.label,
      required this.iconData,
      required this.color}) {
    this.icon = Icon(this.iconData, color: this.color);
    this.cardType = CardType.Icon;
  }

  late int id;
  late String label;
  final IconData iconData;
  late Color color;
  late Widget icon;
  late CardType cardType;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'label': label,
      'color': color.value,
      'cardType': cardType.toInt(),
      'iconData': {
        'codePoint': iconData.codePoint,
        'fontFamily': iconData.fontFamily,
        'fontPackage': iconData.fontPackage,
        'matchTextDirection': iconData.matchTextDirection,
      },
    };
  }

  factory CardWithIcon.fromMap(Map<String, dynamic> map) {
    return CardWithIcon(
      id: map['id'],
      label: map['label'],
      color: Color(map['color']),
      iconData: IconData(
        map['iconData']['codePoint'],
        fontPackage: map['iconData']['fontPackage'],
        fontFamily: map['iconData']['fontFamily'],
        matchTextDirection: map['iconData']['matchTextDirection'],
      ),
    );
  }
}

class CardWithSvg implements CardData {
  CardWithSvg(
      {required this.id,
      required this.label,
      required this.svgPath,
      required this.color}) {
    this.icon = SvgPicture.asset(
      this.svgPath,
      semanticsLabel: this.label,
      width: 24,
      height: 24,
      color: this.color,
    );
    this.cardType = CardType.Svg;
  }
  late int id;
  late String label;
  final String svgPath;
  late Color color;
  late Widget icon;
  late CardType cardType;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'label': label,
      'color': color.value,
      'svgPath': svgPath,
      'cardType': cardType.toInt(),
    };
  }

  factory CardWithSvg.fromMap(Map<String, dynamic> map) {
    return CardWithSvg(
      id: map['id'],
      label: map['label'],
      color: Color(map['color']),
      svgPath: map['svgPath'],
    );
  }
}
