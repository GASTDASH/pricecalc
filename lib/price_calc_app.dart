import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pricecalc/core/core.dart';
import 'package:pricecalc/routing/router.dart';

class PriceCalcApp extends StatelessWidget {
  const PriceCalcApp({super.key});

  @override
  Widget build(BuildContext context) {
    final primaryColor = Color(0xFF2A5CFF);

    return BlocProvider(
      create: (context) => ItemsBloc(),
      child: MaterialApp.router(
        title: 'Прайс калькулятор',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: primaryColor,
            primary: primaryColor,
          ),
        ),
        routerConfig: router,
      ),
    );
  }
}
