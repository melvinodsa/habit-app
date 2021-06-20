import 'card_data.dart';

class Habit {
  Habit(
      {required this.category,
      this.trackProgress = TrackProgress.WithNumerical});
  final Category category;
  TrackProgress trackProgress;
}

class Category {
  Category({required this.data});
  final CardData data;
}

enum TrackProgress {
  WithYesOrNo,
  WithNumerical,
}
