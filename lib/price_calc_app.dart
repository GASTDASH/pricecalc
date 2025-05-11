import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pricecalc/features/price_list/price_list.dart';
import 'package:pricecalc/routing/router.dart';

class PriceCalcApp extends StatelessWidget {
  const PriceCalcApp({super.key});

  @override
  Widget build(BuildContext context) {
    final primaryColor = Color(0xFF2A5CFF);

    return BlocProvider(
      create: (context) => PriceBloc(GetIt.I<PriceRepository>()),
      child: MaterialApp.router(
        title: 'Прайс калькулятор',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: primaryColor,
            primary: primaryColor,
          ),
          textTheme: GoogleFonts.montserratTextTheme(),
        ),
        routerConfig: router,
      ),
    );
  }
}
