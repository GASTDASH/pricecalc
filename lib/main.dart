import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pricecalc/core/core.dart';
import 'package:pricecalc/price_calc_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter(ConditionAdapter());
  Hive.registerAdapter(ItemAdapter());
  await Hive.openBox<Item>('items');

  runApp(const PriceCalcApp());
}
