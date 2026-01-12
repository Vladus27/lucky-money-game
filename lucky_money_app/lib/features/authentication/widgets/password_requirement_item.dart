import 'package:flutter/material.dart';

class PasswordRequirementItem extends StatelessWidget {
  final bool isValid;
  final String text;

  const PasswordRequirementItem({
    super.key,
    required this.isValid,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    final colorTheme = Theme.of(context).colorScheme;
    return Row(
      children: [
        Icon(
          isValid ? Icons.check_circle : Icons.radio_button_unchecked,
          size: 18,
          color: isValid ? colorTheme.tertiary : Colors.grey,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 13,
              color: isValid ? colorTheme.tertiary : Colors.grey,
            ),
          ),
        ),
      ],
    );
  }
}
