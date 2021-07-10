import 'package:flutter/material.dart';
import 'package:habit/components/cards/card.dart';
import 'package:habit/config/index.dart';
import 'package:habit/models/card_data.dart';
import 'package:habit/models/habit.dart';
import 'package:habit/screens/habits/new_habit/track_progress.dart';

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

  void Function() _gotoTrackProgress(Category category) {
    return () => {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => TrackHabitProgress(
                    config: this.widget.config,
                    habit: Habit(category: category)),
                settings: RouteSettings(name: "/habit/new/trackprogress")),
          )
        };
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
                    .map((e) => CardWidget(
                        context: context,
                        data: e,
                        onPress: _gotoTrackProgress(Category(data: e))))
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
    id: 1,
    label: 'Quit a bad habit',
    iconData: Icons.block,
    color: Colors.red,
  ),
  CardWithIcon(
      id: 2,
      label: 'Study',
      iconData: Icons.school,
      color: Colors.purple.shade900),
  CardWithIcon(
      id: 3,
      label: 'Enterainment',
      iconData: Icons.movie,
      color: Colors.green.shade700),
  CardWithIcon(
      id: 4,
      label: 'Health',
      iconData: Icons.add_box_outlined,
      color: Colors.teal),
  CardWithIcon(
      id: 5, label: 'Home', iconData: Icons.home, color: Colors.orange),
  CardWithIcon(
      id: 6, label: 'Art', iconData: Icons.brush, color: Colors.redAccent),
  CardWithIcon(
      id: 7,
      label: 'Finance',
      iconData: Icons.attach_money,
      color: Colors.teal.shade900),
];
List<CardData> _list2 = [
  CardWithSvg(
      id: 8,
      label: 'Meditation',
      svgPath: 'assets/meditation.svg',
      color: Colors.purple),
  CardWithIcon(
      id: 9,
      label: 'Sports',
      iconData: Icons.directions_bike,
      color: Colors.blueGrey),
  CardWithIcon(
      id: 10,
      label: 'Social',
      iconData: Icons.message,
      color: Colors.greenAccent),
  CardWithIcon(
      id: 11,
      label: 'Nutrition',
      iconData: Icons.food_bank_outlined,
      color: Colors.yellow.shade700),
  CardWithIcon(
      id: 12,
      label: 'Outdoor',
      iconData: Icons.terrain,
      color: Colors.orangeAccent.shade400),
  CardWithIcon(
      id: 13, label: 'Work', iconData: Icons.work, color: Colors.brown),
  CardWithIcon(
      id: 14, label: 'Other', iconData: Icons.more, color: Colors.black),
];

List<List<CardData>> _combinedList = [_list1, _list2];
