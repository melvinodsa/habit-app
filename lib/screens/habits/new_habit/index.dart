import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:habit/components/cards/card.dart';
import 'package:habit/config/index.dart';
import 'package:habit/models/card_data.dart';

class NewHabitWizardCategory extends StatefulWidget {
  NewHabitWizardCategory({Key? key, required this.config}) : super(key: key);

  final AppConfig config;

  @override
  _NewHabitWizardCategoryState createState() => _NewHabitWizardCategoryState();
}

class _NewHabitWizardCategoryState extends State<NewHabitWizardCategory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Select a category")),
      body: _buildBody(),
    );
  }

  Row _buildBody() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: _combinedList
          .map(
            (list) => SizedBox(
              width: MediaQuery.of(context).size.width / 2,
              child: Column(
                children: list
                    .map((e) => CardWidget(context: context, data: e))
                    .toList(),
              ),
            ),
          )
          .toList(),
    );
  }
}

List<CardData> _list1 = [
  CardWithIcon(
    label: 'Quit a bad habit',
    iconData: Icons.block,
    color: Colors.red,
  ),
  CardWithIcon(
      label: 'Study', iconData: Icons.school, color: Colors.purple.shade900),
  CardWithIcon(
      label: 'Enterainment',
      iconData: Icons.movie,
      color: Colors.green.shade700),
  CardWithIcon(
      label: 'Health', iconData: Icons.add_box_outlined, color: Colors.teal),
  CardWithIcon(label: 'Home', iconData: Icons.home, color: Colors.orange),
  CardWithIcon(label: 'Art', iconData: Icons.brush, color: Colors.redAccent),
  CardWithIcon(
      label: 'Finance',
      iconData: Icons.attach_money,
      color: Colors.teal.shade900),
];
List<CardData> _list2 = [
  CardWithSvg(
      label: 'Meditation',
      svgPath: 'assets/meditation.svg',
      color: Colors.purple),
  CardWithIcon(
      label: 'Sports', iconData: Icons.directions_bike, color: Colors.blueGrey),
  CardWithIcon(
      label: 'Social', iconData: Icons.message, color: Colors.greenAccent),
  CardWithIcon(
      label: 'Nutrition',
      iconData: Icons.food_bank_outlined,
      color: Colors.yellow.shade700),
  CardWithIcon(
      label: 'Outdoor',
      iconData: Icons.terrain,
      color: Colors.orangeAccent.shade400),
  CardWithIcon(label: 'Work', iconData: Icons.work, color: Colors.brown),
  CardWithIcon(label: 'Other', iconData: Icons.more, color: Colors.black),
];

List<List<CardData>> _combinedList = [_list1, _list2];
