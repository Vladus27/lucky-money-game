import 'package:flutter/material.dart';

class WalletEmptyState extends StatelessWidget {
  const WalletEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.nearby_error_sharp,
              size: 64,
              color: theme.colorScheme.surface.withValues(alpha: 0.4),
            ),
            const SizedBox(height: 16),
            Text(
              'Йойки, очікуй',
              style: theme.textTheme.titleMedium!.copyWith(
                color: theme.colorScheme.surface,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'Хобі девелопер скоро цим займеться',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.surface.withValues(alpha: 0.6),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
