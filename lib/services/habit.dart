import 'dart:async';

import 'package:habit/models/habit.dart';
import 'package:localstore/localstore.dart';

extension HabitService on Habit {
  Future save() async {
    final _db = Localstore.instance;
    final id = _db.collection('habits').doc().id;
    this.id = id;
    return await _db.collection('habits').doc(id).set(toMap());
  }

  Future delete() async {
    final _db = Localstore.instance;
    return _db.collection('habits').doc(id).delete();
  }

  static Future<List<Habit>?> fetchAll() async {
    final _db = Localstore.instance;
    final habits = await _db.collection('habits').get();
    return habits?.values.map((e) => Habit.fromMap(e)).toList();
  }
}
