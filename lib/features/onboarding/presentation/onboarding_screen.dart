import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:introduction_screen/introduction_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  void onDone() async {
    await Hive.box('settings').put('onboarding', false);
    gotoHome();
  }

  void gotoHome() => context.go("/home");

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return IntroductionScreen(
      showBackButton: true,
      next: Text("Далее"),
      back: Text("Назад"),
      done: Text("Начать", style: TextStyle(fontWeight: FontWeight.bold)),
      doneStyle: FilledButton.styleFrom(
        backgroundColor: theme.primaryColor,
        foregroundColor: Colors.white,
      ),
      onDone: onDone,
      pages: [
        PageViewModel(
          title: "Добро пожаловать",
          body:
              "Приветствуем Вас в приложении Прайс-Калькулятор, созданного для упрощения расчётов стоимости заказа по заготовленным ценам товаров",
          image: Image.asset("assets/images/calc.png", height: 200),
        ),
        PageViewModel(
          title: "Удобство использования",
          body:
              "Приложение имеет минималистичный и неперегруженный интерфейс, в котором сможет разобраться любой пользователь",
          image: SvgPicture.asset("assets/images/price_list.svg", height: 200),
        ),
        PageViewModel(
          title: "Начните уже сейчас",
          body:
              "Создайте свой первый прайс-лист и начните обслуживать клиентов с удобством и скоростью",
          image: SvgPicture.asset("assets/images/price_calc.svg", height: 200),
        ),
      ],
    );
  }
}
