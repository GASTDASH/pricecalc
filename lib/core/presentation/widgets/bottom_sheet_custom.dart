import 'package:flutter/material.dart';

class BottomSheetCustom extends StatelessWidget {
  const BottomSheetCustom({
    super.key,
    this.child,
    this.padding,
    this.borderRadius,
  });

  final Widget? child;
  final EdgeInsetsGeometry? padding;
  final BorderRadiusGeometry? borderRadius;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: padding ?? const EdgeInsets.only(top: 200),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        padding: EdgeInsets.all(20).copyWith(bottom: 0),
        decoration: BoxDecoration(
          color: theme.canvasColor,
          borderRadius:
              borderRadius ?? BorderRadius.vertical(top: Radius.circular(32)),
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
