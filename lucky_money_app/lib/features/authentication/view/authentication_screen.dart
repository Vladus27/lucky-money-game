import 'package:flutter/material.dart';

import 'package:lucky_money_app/common/models/authentication_copy.dart';
import 'package:lucky_money_app/features/authentication/widgets/auth_card.dart';
import 'package:lucky_money_app/features/authentication/widgets/auth_footer.dart';
import 'package:lucky_money_app/features/authentication/widgets/auth_header.dart';

class AuthenticationScreen extends StatefulWidget {
  const AuthenticationScreen({super.key, required this.initialMode});
  final AuthMode initialMode;

  @override
  State<AuthenticationScreen> createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  late AuthMode _mode;

  @override
  void initState() {
    _mode = widget.initialMode;
    super.initState();
  }

  void _toggleMode() {
    setState(() {
      _mode = _mode == AuthMode.login ? AuthMode.register : AuthMode.login;
    });
  }

  @override
  Widget build(BuildContext context) {
    final copy = AuthenticationCopy.of(_mode);

    final theme = Theme.of(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AuthHeader(appBarTitle: copy.appBarTitle),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 28.0, vertical: 24),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(copy.label, style: theme.textTheme.titleLarge),
            const SizedBox(height: 48),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 24.0),
              child: AuthCard(
                mode: widget.initialMode,
                usernameLabel: copy.username,
                passwordLabel: copy.password,
                buttonLabel: copy.buttonLabel,
              ),
            ),
            AuthFooter(
              question: copy.question,
              questionButton: copy.questionButton,
              toogleMode: _toggleMode,
            ),
          ],
        ),
      ),
    );
  }
}
