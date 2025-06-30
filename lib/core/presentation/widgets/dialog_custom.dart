import 'package:flutter/material.dart';

class DialogCustom extends StatelessWidget {
  const DialogCustom({super.key, this.title, this.text, this.child});

  final String? title;
  final String? text;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          color: theme.scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(18),
        ),
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: 200, maxWidth: 400),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title ?? "",
                  style: theme.textTheme.headlineMedium,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 12),
                Text(
                  text ?? "",
                  style: theme.textTheme.bodyLarge,
                  textAlign: TextAlign.center,
                ),
                child != null ? SizedBox(height: 24) : SizedBox.shrink(),
                child ?? SizedBox.shrink(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
