import 'package:flutter/material.dart';
import 'package:habit/models/card_data.dart';

class CardWidget extends StatelessWidget {
  const CardWidget({
    Key? key,
    required this.context,
    required this.data,
    required this.onPress,
  }) : super(key: key);

  final BuildContext context;
  final CardData data;
  final void Function() onPress;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 2 - 40,
      margin: EdgeInsets.all(10.0),
      child: Row(
        children: [
          _leftLightBar(),
          _card(context),
        ],
      ),
    );
  }

  Container _card(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 2 - 42,
      child: Card(
        shape: _rightOnlyBorderRadius(),
        margin: EdgeInsets.all(0),
        child: _cardBody(),
      ),
    );
  }

  InkWell _cardBody() {
    return InkWell(
        splashColor: this.data.color.withAlpha(30),
        onTap: this.onPress,
        child: _cardBodyContent());
  }

  Container _cardBodyContent() {
    return Container(
      padding: EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            this.data.label,
            style: TextStyle(fontSize: 10),
          ),
          this.data.icon,
        ],
      ),
    );
  }

  Container _leftLightBar() {
    return Container(
      width: 2,
      height: 45,
      decoration: BoxDecoration(color: this.data.color),
      child: Text(''),
    );
  }
}

RoundedRectangleBorder _rightOnlyBorderRadius() {
  return RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
          topRight: Radius.circular(5), bottomRight: Radius.circular(5)));
}
