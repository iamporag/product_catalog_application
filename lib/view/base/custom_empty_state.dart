import 'package:flutter/material.dart';

class CustomEmptyState extends StatelessWidget {
  final IconData? icon;
  final String title;
  final String? subtitle;
  final double iconSize;
  final Widget? action;

  const CustomEmptyState({
    super.key,
    required this.title,
    this.subtitle,
    this.icon,
    this.iconSize = 80,
    this.action,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[
              Icon(icon, size: iconSize, color: Colors.grey.shade400),
              const SizedBox(height: 16),
            ],

            Text(
              title,
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),

            if (subtitle != null) ...[
              const SizedBox(height: 8),
              Text(
                subtitle!,
                textAlign: TextAlign.center,
                style: theme.textTheme.bodySmall,
              ),
            ],

            if (action != null) ...[const SizedBox(height: 20), action!],
          ],
        ),
      ),
    );
  }
}
