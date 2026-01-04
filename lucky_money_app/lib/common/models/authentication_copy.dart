import 'package:lucky_money_app/common/constant/login_strings.dart' as login;
import 'package:lucky_money_app/common/constant/register_strings.dart'
    as register;

enum AuthMode { login, register }

class AuthenticationCopy {
  final String appBarTitle;
  final String label;
  final String buttonLabel;
  final String question;
  final String questionButton;
  String username = 'Username';
  String password = 'Password';

  AuthenticationCopy({
    required this.appBarTitle,
    required this.label,
    required this.buttonLabel,
    required this.question,
    required this.questionButton,
  });

  static AuthenticationCopy of(AuthMode mode) {
    return mode == AuthMode.login
        ? AuthenticationCopy.login()
        : AuthenticationCopy.register();
  }

  factory AuthenticationCopy.login() => AuthenticationCopy(
    appBarTitle: login.appBarTitle,
    label: login.label,
    buttonLabel: login.buttonLabel,
    question: login.question,
    questionButton: login.questionButton,
  );

  factory AuthenticationCopy.register() => AuthenticationCopy(
    appBarTitle: register.appBarTitle,
    label: register.label,
    buttonLabel: register.buttonLabel,
    question: register.question,
    questionButton: register.questionButton,
  );
}
