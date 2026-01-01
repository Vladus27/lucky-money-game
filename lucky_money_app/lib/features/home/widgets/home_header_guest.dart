import 'package:flutter/material.dart';

class HomeHeaderGuest extends StatelessWidget {
  const HomeHeaderGuest({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        OutlinedButton(
          onPressed: () {
            Navigator.pushNamed(context, '/auth-login');
          },
          child: const Text('Увійти'),
        ),
        const SizedBox(width: 8),
        ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(context, '/auth-register');
          },
          child: const Text('Реєстрація'),
        ),
        const SizedBox(width: 12),
      ],
    );
  }
}
