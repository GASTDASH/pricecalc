import 'package:flutter/material.dart';
import 'package:pricecalc/features/condition/condition.dart';
import 'package:uuid/uuid.dart';

class ConditionRepository extends ChangeNotifier {
  ConditionRepository(List<Condition> value) : _value = value;

  final List<Condition> _value;
  List<Condition> get value => _value;

  void addCondition() {
    _value.add(Condition(uuid: Uuid().v4()));
    notifyListeners();
  }

  void removeCondition(Condition condition) {
    _value.remove(condition);
    notifyListeners();
  }

  void updateCondition(Condition condition) {
    int index = _value.indexWhere((c) => c.uuid == condition.uuid);

    _value[index] = condition;
  }
}
