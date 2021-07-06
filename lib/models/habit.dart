import 'card_data.dart';

class Habit {
  Habit({
    required this.category,
    this.trackProgress = TrackProgress.WithNumerical,
    this.name = "",
    this.description = "",
    this.operator = NumericalTrackOperator.Atleast,
    this.goal = 0,
    this.unit = "",
    this.priority = Priority.Normal,
  }) {
    this.frequency = Frequency(type: FrequencyType.Everyday);
    DateTime today = DateTime.now();
    this.startDate = DateTime(today.year, today.month, today.day);
  }
  final Category category;
  TrackProgress trackProgress;
  String name;
  String description;
  NumericalTrackOperator operator;
  int goal;
  String unit;
  late Frequency frequency;
  late DateTime startDate;
  DateTime? endDate;
  Priority priority;
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

enum FrequencyType {
  Everyday,
  DaysOfWeek,
  Periodically,
  Repeat,
}

class Frequency {
  Frequency(
      {required this.type, this.period = 2, this.repeatPer = Repeat.Week}) {
    this.weekdays = [];
  }
  FrequencyType type;
  late List<Weekday> weekdays;
  int period;
  Repeat repeatPer;
}

enum Weekday {
  Sunday,
  Monday,
  Tuesday,
  Wednesday,
  Thursday,
  Friday,
  Saturday,
}

extension ExtensionWeekday on Weekday {
  String toEnumString() {
    switch (this) {
      case Weekday.Sunday:
        return "Sunday";
      case Weekday.Monday:
        return "Monday";
      case Weekday.Tuesday:
        return "Tuesday";
      case Weekday.Wednesday:
        return "Wednesday";
      case Weekday.Thursday:
        return "Thursday";
      case Weekday.Friday:
        return "Friday";
      case Weekday.Saturday:
        return "Saturday";
      default:
        return "Sunday";
    }
  }
}

enum Repeat {
  Week,
  Month,
}

extension RepeatExtension on Repeat {
  String toEnumString() {
    switch (this) {
      case Repeat.Week:
        return "Week";
      case Repeat.Month:
        return "Month";
      default:
        return "Week";
    }
  }
}

enum Priority { High, Normal, Low }

extension PriorityExtension on Priority {
  String toEnumString() {
    switch (this) {
      case Priority.High:
        return "High";
      case Priority.Normal:
        return "Normal";
      case Priority.Low:
        return "Low";
      default:
        return "Normal";
    }
  }
}
