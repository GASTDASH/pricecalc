import 'package:flutter/material.dart';

class NoCalcItemsBanner extends StatelessWidget {
  const NoCalcItemsBanner({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SliverToBoxAdapter(
      child: SizedBox(
        height: 300,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          spacing: 12,
          children: [
            Text(
              "Добавьте свой первый предмет для подсчёта",
              style: theme.textTheme.headlineMedium,
              textAlign: TextAlign.center,
            ),
            Text("Создать прайс можно на втором экране"),
            Icon(Icons.arrow_downward_rounded, size: 64),
          ],
        ),
      ),
    );
  }
}
