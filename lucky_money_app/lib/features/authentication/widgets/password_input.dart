import 'package:flutter/material.dart';

class PasswordInput extends StatelessWidget {
  const PasswordInput({
    super.key,
    required this.passwordController,
    required this.passwordLabel,
    required this.isPasswordVisible,
    required this.tooglePasswordVisible,
  });
  final TextEditingController passwordController;
  final String passwordLabel;
  final bool isPasswordVisible;
  final void Function() tooglePasswordVisible;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return TextFormField(
      keyboardType: TextInputType.text,
      controller: passwordController,
      obscureText: !isPasswordVisible,
      decoration: InputDecoration(
        icon: const Icon(Icons.password_outlined),
        hintText: 'Enter your password',
        labelText: passwordLabel,
        suffixIcon: IconButton(
          icon: Icon(
            isPasswordVisible ? Icons.visibility : Icons.visibility_off,
          ),
          onPressed: tooglePasswordVisible,
        ),
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
