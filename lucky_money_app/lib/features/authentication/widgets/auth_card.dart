import 'package:flutter/material.dart';
import 'package:lucky_money_app/common/models/authentication_copy.dart';
import 'package:lucky_money_app/common/widgets/box_shadow.dart';
import 'package:lucky_money_app/features/authentication/widgets/auth_form.dart';

class AuthCard extends StatelessWidget {
  const AuthCard({
    super.key,
    required this.mode,
    required this.usernameLabel,
    required this.passwordLabel,
    required this.buttonLabel,
  });
  final AuthMode mode;
  final String usernameLabel;
  final String passwordLabel;
  final String buttonLabel;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      constraints: const BoxConstraints(maxWidth: 700),
      decoration: BoxDecoration(
        color: theme.colorScheme.onPrimary,
        borderRadius: BorderRadius.circular(24),
        boxShadow: containerShadow,
      ),
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: AuthForm(
          mode: mode,
          usernameLabel: usernameLabel,
          passwordLabel: passwordLabel,
          buttonLabel: buttonLabel,
        ),
      ),
    );
  }
}
