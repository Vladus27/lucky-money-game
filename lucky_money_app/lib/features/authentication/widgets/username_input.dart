import 'package:flutter/material.dart';

class UsernameInput extends StatelessWidget {
  const UsernameInput({
    super.key,
    required this.usernameController,
    required this.usernameLabel,
  });
  final TextEditingController usernameController;
  final String usernameLabel;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return TextFormField(
      maxLength: 20,
      controller: usernameController,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Введи нікнейм';
        }
        final regex = RegExp(r'^[a-z0-9_]{3,20}$');
        if (!regex.hasMatch(value)) {
          return 'мін 3 символи: a-z, 0-9 або _';
        }

        return null;
      },
      decoration: InputDecoration(
        icon: const Icon(Icons.person_outline_outlined),
        labelText: usernameLabel,
        filled: true,
        fillColor: theme.colorScheme.surfaceContainer,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: theme.colorScheme.onPrimary),
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: theme.colorScheme.primary),
        ),
      ),
    );
  }
}
