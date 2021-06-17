import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:habit/components/buttons/expandable_fab.dart';
import 'package:habit/config/index.dart';
import 'package:habit/config/theme.dart';
import 'package:habit/constants/inspirational_messages.dart';

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
      body:
          _buildBody(), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Row _buildBody() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(
          children: [
            Container(
                margin: EdgeInsets.only(
                    left: 20.0, top: 20.0, right: 20.0, bottom: 20.0),
                child: Card(
                    child: InkWell(
                        splashColor: Colors.blue.withAlpha(30),
                        onTap: () {
                          print('Card tapped.');
                        },
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width / 2 - 60,
                          child: Container(
                              padding: EdgeInsets.only(
                                  left: 20.0,
                                  top: 10.0,
                                  right: 20.0,
                                  bottom: 10.0),
                              child: Text('Quit a bad habit')),
                        )))),
          ],
        ),
        Column(children: [
          Container(
              margin: EdgeInsets.only(
                  left: 20.0, top: 20.0, right: 20.0, bottom: 20.0),
              child: Card(
                  child: InkWell(
                      splashColor: Colors.blue.withAlpha(30),
                      onTap: () {
                        print('Card tapped.');
                      },
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width / 2 - 60,
                        child: Container(
                            padding: EdgeInsets.only(
                                left: 20.0,
                                top: 10.0,
                                right: 20.0,
                                bottom: 10.0),
                            child: Text('Meditation')),
                      )))),
        ]),
      ],
    );
  }
}
