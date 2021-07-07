import 'dart:async';

import 'package:habit/models/habit.dart';
import 'package:localstore/localstore.dart';

extension ExtHabit on Habit {
  Future save() async {
    final _db = Localstore.instance;
    return _db.collection('habits').doc(id).set(toMap());
  }

  Future delete() async {
    final _db = Localstore.instance;
    return _db.collection('habits').doc(id).delete();
  }
}
