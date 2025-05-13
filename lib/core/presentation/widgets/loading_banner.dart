import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';

class LoadingBanner extends StatelessWidget {
  const LoadingBanner({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      spacing: 8,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: SizedBox(
            width: 150,
            height: 150,
            child: LoadingIndicator(
              indicatorType: Indicator.ballSpinFadeLoader,
            ),
          ),
        ),
        Text("Пожалуйста, подождите...", style: theme.textTheme.titleLarge),
      ],
    );
  }
}
