import 'package:flutter/material.dart';
import 'package:habit/config/index.dart';
import 'package:habit/models/category_item.dart';

class NewHabitWizardCategory extends StatefulWidget {
  NewHabitWizardCategory({Key? key, required this.config}) : super(key: key);

  final AppConfig config;

  @override
  _NewHabitWizardCategoryState createState() => _NewHabitWizardCategoryState();
}

class _NewHabitWizardCategoryState extends State<NewHabitWizardCategory> {
  List<CategoryItem> list1 = [
    CategoryItem(
      label: 'Quit a bad habit',
      icon: Icons.block,
      color: Colors.red,
    ),
    CategoryItem(label: 'Study', icon: Icons.school, color: Colors.purple),
  ];
  List<CategoryItem> list2 = [
    CategoryItem(
        label: 'Sports', icon: Icons.directions_bike, color: Colors.green),
  ];
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
      children: [list1, list2]
          .map((list) => SizedBox(
                width: MediaQuery.of(context).size.width / 2,
                child: Column(
                  children: list
                      .map((e) => CategoryItemWidget(context: context, data: e))
                      .toList(),
                ),
              ))
          .toList(),
    );
  }
}

class CategoryItemWidget extends StatelessWidget {
  const CategoryItemWidget({
    Key? key,
    required this.context,
    required this.data,
  }) : super(key: key);

  final BuildContext context;
  final CategoryItem data;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 2 - 40,
      margin: EdgeInsets.all(10.0),
      child: Row(
        children: [
          Container(
            width: 2,
            height: 45,
            decoration: BoxDecoration(color: this.data.color),
            child: Text(''),
          ),
          Container(
            width: MediaQuery.of(context).size.width / 2 - 42,
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(5),
                      bottomRight: Radius.circular(5))),
              margin: EdgeInsets.all(0),
              child: InkWell(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(100), topLeft: Radius.zero),
                  splashColor: this.data.color.withAlpha(30),
                  onTap: () {
                    print('Card tapped.');
                  },
                  child: SizedBox(
                    child: Container(
                      padding: EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            this.data.label,
                            style: TextStyle(fontSize: 10),
                          ),
                          Icon(
                            this.data.icon,
                            color: this.data.color,
                          )
                        ],
                      ),
                    ),
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
