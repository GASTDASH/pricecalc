import 'package:flutter/material.dart';

class SettingCard extends StatelessWidget {
  const SettingCard({
    super.key,
    this.onTap,
    required this.title,
    required this.icon,
  });

  final void Function()? onTap;
  final String title;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Material(
      elevation: 2,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Ink(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                spacing: 14,
                children: [
                  Icon(icon, size: 42),
                  Text(title, style: theme.textTheme.titleLarge),
                ],
              ),
              Icon(Icons.chevron_right_rounded),
            ],
          ),
        ),
      ),
    );
  }
}
