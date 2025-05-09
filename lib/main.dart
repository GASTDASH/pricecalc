import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pricecalc/features/price_list/price_list.dart';
import 'package:pricecalc/price_calc_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter(ConditionAdapter());
  Hive.registerAdapter(PriceAdapter());
  await Hive.openBox<Price>('prices');

  runApp(const PriceCalcApp());
}
