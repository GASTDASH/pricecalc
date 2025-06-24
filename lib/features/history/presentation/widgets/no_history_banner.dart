import 'package:flutter/material.dart';

class NoHistoryBanner extends StatelessWidget {
  const NoHistoryBanner({super.key});

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
            Text(
              "У вас пока нет сохранённых расчётов",
              style: theme.textTheme.headlineMedium,
              textAlign: TextAlign.center,
            ),
            Icon(Icons.history_toggle_off, size: 64),
          ],
        ),
      ),
    );
  }
}
