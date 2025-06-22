import 'package:flutter/material.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class ButtonCustom extends StatelessWidget {
  const ButtonCustom({super.key, this.onTap, this.text = "", this.icon, this.isLoading = false, this.outline = false});

  final void Function()? onTap;
  final String text;
  final IconData? icon;
  final bool isLoading;
  final bool outline;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Shimmer(
      enabled: isLoading,
      child: Material(
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: onTap,
          child: Ink(
            width: double.infinity,
            height: 60,
            decoration: BoxDecoration(
              color:
                  outline
                      ? Colors.transparent
                      : onTap != null
                      ? theme.primaryColor
                      : theme.hintColor.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(16),
              border: outline ? Border.all(color: onTap != null ? theme.primaryColor : theme.hintColor.withValues(alpha: 0.2)) : null,
            ),
            child: Row(
              spacing: icon != null ? 6 : 0,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  text,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontSize: 18,
                    color:
                        outline
                            ? onTap != null
                                ? Colors.black
                                : theme.hintColor.withValues(alpha: 0.2)
                            : Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                icon != null ? Icon(icon, color: Colors.white) : SizedBox.shrink(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
