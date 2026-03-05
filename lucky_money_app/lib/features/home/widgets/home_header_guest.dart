import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeHeaderGuest extends StatelessWidget {
  const HomeHeaderGuest({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        OutlinedButton(
          onPressed: () {
            context.go('/auth-login');
          },
          child: const Text('Увійти'),
        ),
        const SizedBox(width: 8),
        ElevatedButton(
          onPressed: () {
            context.go('/auth-register');
          },
          child: const Text('Реєстрація'),
        ),
        const SizedBox(width: 12),
      ],
    );
  }
}
