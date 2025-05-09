import 'package:flutter/material.dart';

class BottomSheetCustom extends StatelessWidget {
  const BottomSheetCustom({super.key, this.child});

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.only(top: 200),
      child: Ink(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: theme.canvasColor,
          borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
        ),
        child: child,
      ),
    );
  }
}

Future<T?> showModalBottomSheetCustom<T>({
  required BuildContext context,
  required Widget Function(BuildContext) builder,
}) => showModalBottomSheet(
  isScrollControlled: true,
  backgroundColor: Colors.transparent,
  context: context,
  builder: builder,
);
