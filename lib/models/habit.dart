import 'card_data.dart';

class Habit {
  Habit(
      {required this.category,
      this.trackProgress = TrackProgress.WithYesOrNo,
      this.name = "",
      this.description = ""});
  final Category category;
  TrackProgress trackProgress;
  String name;
  String description;
}

class Category {
  Category({required this.data});
  final CardData data;
}

enum TrackProgress {
  WithYesOrNo,
  WithNumerical,
}
