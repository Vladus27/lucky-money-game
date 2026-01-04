import 'package:flutter/material.dart';
import 'package:lucky_money_app/common/models/authentication_copy.dart';
import 'package:lucky_money_app/features/authentication/widgets/password_input.dart';
import 'package:lucky_money_app/features/authentication/widgets/username_input.dart';

class AuthForm extends StatefulWidget {
  const AuthForm({
    super.key,
    required this.mode,
    required this.buttonLabel,
    required this.usernameLabel,
    required this.passwordLabel,
  });
  final AuthMode mode;
  final String usernameLabel;
  final String passwordLabel;
  final String buttonLabel;

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isPasswordVisible = false;

  void _tooglePasswordVisible() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
    });
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Form(
      key: _formKey,
      child: Column(
        children: [
          Text('Заповни усі поля', style: theme.textTheme.titleMedium),
          const SizedBox(height: 12),
          UsernameInput(
            usernameController: _usernameController,
            usernameLabel: widget.usernameLabel,
          ),
          const SizedBox(height: 8),
          PasswordInput(
            passwordController: _passwordController,
            passwordLabel: widget.passwordLabel,
            isPasswordVisible: _isPasswordVisible,
            tooglePasswordVisible: _tooglePasswordVisible,
          ),

          const SizedBox(height: 8),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _submit,
              child: Text(widget.buttonLabel),
            ),
          ),
        ],
      ),
    );
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    final username = _usernameController.text.trim();
    final password = _passwordController.text.trim();

    // тут буде виклик use case / auth service
    debugPrint('Username: $username, password: $password');
  }
}
