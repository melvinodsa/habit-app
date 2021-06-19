import 'package:flutter/material.dart';
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
  CardData(
    label: 'Quit a bad habit',
    icon: Icons.block,
    color: Colors.red,
  ),
  CardData(label: 'Study', icon: Icons.school, color: Colors.purple),
];
List<CardData> _list2 = [
  CardData(label: 'Sports', icon: Icons.directions_bike, color: Colors.green),
];

List<List<CardData>> _combinedList = [_list1, _list2];
