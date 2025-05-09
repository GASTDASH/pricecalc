import 'package:flutter/material.dart';

class NoPricesBanner extends StatelessWidget {
  const NoPricesBanner({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.only(top: 100),
      child: Center(
        child: Column(
          spacing: 24,
          children: [
            Text(
              "Вы пока не добавили ни одного товара",
              style: theme.textTheme.headlineMedium,
              textAlign: TextAlign.center,
            ),
            Icon(Icons.arrow_downward_rounded, size: 64),
          ],
        ),
      ),
    );
  }
}
