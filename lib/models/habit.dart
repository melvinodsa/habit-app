import 'card_data.dart';

class Habit {
  Habit({
    required this.category,
    this.trackProgress = TrackProgress.WithNumerical,
    this.name = "",
    this.description = "",
    this.operator = NumericalTrackOperator.Atleast,
    this.goal = 0,
    this.goalSet = false,
    this.unit = "",
  });
  final Category category;
  TrackProgress trackProgress;
  String name;
  String description;
  NumericalTrackOperator operator;
  int goal;
  bool goalSet;
  String unit;
}

class Category {
  Category({required this.data});
  final CardData data;
}

enum TrackProgress {
  WithYesOrNo,
  WithNumerical,
}

enum NumericalTrackOperator {
  Atleast,
  LessThan,
  Exactly,
}

NumericalTrackOperator parseNumericalTrackOperator(String value) {
  if (value == "0") {
    return NumericalTrackOperator.Exactly;
  }
  if (value == "-1") {
    return NumericalTrackOperator.LessThan;
  }
  return NumericalTrackOperator.Atleast;
}

extension ExtensionOperator on NumericalTrackOperator {
  String toEnumString() {
    switch (this) {
      case NumericalTrackOperator.Exactly:
        return "0";
      case NumericalTrackOperator.LessThan:
        return "-1";
      default:
        return "1";
    }
  }
}
