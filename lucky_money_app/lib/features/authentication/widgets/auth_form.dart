import 'package:flutter/material.dart';
import 'package:lucky_money_app/common/models/authentication_copy.dart';
import 'package:lucky_money_app/features/authentication/widgets/password_input.dart';
import 'package:lucky_money_app/features/authentication/widgets/username_input.dart';
import 'package:lucky_money_app/repo/user_repository.dart';

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

  String? error;
  bool _isPasswordVisible = false;
  bool _isLoading = false;

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
              onPressed: _isLoading ? null : _submit,
              child: _isLoading
                  ? const CircularProgressIndicator()
                  : Text(widget.buttonLabel),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    final user = UserRepository();

    final username = _usernameController.text.trim();
    final password = _passwordController.text.trim();

    setState(() {
      _isLoading = true;
    });
    if (widget.mode == AuthMode.login) {
      error = await user.loginUser(username: username, password: password);
    } else {
      error = await user.registerUser(username: username, password: password);
    }

    setState(() {
      _isLoading = false;
    });

    if (mounted) {
      if (error != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(error!),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
        return;
      }
      Navigator.pop(context);
    }
    debugPrint('Username: $username, password: $password');
  }
}
