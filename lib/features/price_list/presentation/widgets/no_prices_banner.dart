import 'package:flutter/material.dart';

class NoPricesBanner extends StatelessWidget {
  const NoPricesBanner({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: SizedBox(
        height: 300,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          spacing: 12,
          children: [
            Text("Вы пока не добавили ни одной расценки", style: theme.textTheme.headlineMedium, textAlign: TextAlign.center),
            Icon(Icons.arrow_downward_rounded, size: 64),
          ],
        ),
      ),
    );
  }
}
