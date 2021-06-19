import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'card_data.dart';

class Habit {
  Habit({required this.category});
  final Category category;
}

class Category {
  Category({required this.data});
  final CardData data;
}
