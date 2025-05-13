import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pricecalc/features/home/home.dart';
import 'package:pricecalc/features/price_list/price_list.dart';
import 'package:pricecalc/price_calc_app.dart';
import 'package:talker_bloc_logger/talker_bloc_logger.dart';
import 'package:talker_flutter/talker_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter(ConditionAdapter());
  Hive.registerAdapter(PriceAdapter());
  Hive.registerAdapter(CalcItemAdapter());
  await Hive.openBox<Price>('prices');
  await Hive.openBox<CalcItem>('calc_items');

  final talker = Talker();
  Bloc.observer = TalkerBlocObserver(
    talker: talker,
    settings: const TalkerBlocLoggerSettings(
      printStateFullData: true,
      printEventFullData: true,
      printClosings: true,
      printChanges: true,
      printEvents: true,
    ),
  );

  GetIt.I.registerSingleton(talker);
  GetIt.I.registerSingleton(PriceRepository());
  GetIt.I.registerSingleton(CalcItemRepository());

  runApp(const PriceCalcApp());
}
