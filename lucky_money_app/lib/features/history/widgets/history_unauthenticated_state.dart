import 'package:flutter/material.dart';

class HistoryUnauthenticatedState extends StatelessWidget {
  const HistoryUnauthenticatedState({
    super.key,
    required this.onLoginPressed,
    this.onRegisterPressed,
  });

  final VoidCallback onLoginPressed;
  final VoidCallback? onRegisterPressed;

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
              Icons.lock_outline,
              size: 64,
              color: theme.colorScheme.onSurface.withValues(alpha: 0.4),
            ),
            const SizedBox(height: 16),
            Text(
              'Увійди, щоб побачити історію',
              style: theme.textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'Історія операцій доступна лише для авторизованих користувачів',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: onLoginPressed,
                child: const Text('Увійти'),
              ),
            ),
            TextButton(
              onPressed: onRegisterPressed,
              child: const Text('Створити акаунт'),
            ),
          ],
        ),
      ),
    );
  }
}
