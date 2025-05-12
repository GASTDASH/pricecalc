import 'package:flutter/material.dart';

class ErrorBanner extends StatelessWidget {
  const ErrorBanner({super.key, this.error});

  final String? error;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Column(
        children: [
          Icon(Icons.warning_amber, size: 64),
          Text(
            "Произошла непредвиденная ошибка",
            style: theme.textTheme.bodyLarge,
          ),
          Text(
            error ?? "...",
            style: theme.textTheme.bodyMedium?.copyWith(color: theme.hintColor),
          ),
        ],
      ),
    );
  }
}
