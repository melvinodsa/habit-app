import 'card_data.dart';

class Habit {
  Habit({required this.category});
  final Category category;
  late TrackProgress trackProgressWith;
}

class Category {
  Category({required this.data});
  final CardData data;
}

enum TrackProgress {
  WithYesOrNo,
  WithNumerical,
}
