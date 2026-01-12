import 'package:flutter/material.dart';
import 'package:lucky_money_app/features/authentication/widgets/password_requirement_item.dart';

class PasswordRequirements extends StatelessWidget {
  final String password;

  const PasswordRequirements({super.key, required this.password});

  bool get hasMinLength => password.length >= 8 && password.length <= 128;
  bool get hasLetter => RegExp(r'[A-Za-z]').hasMatch(password);
  bool get hasDigit => RegExp(r'\d').hasMatch(password);
  bool get hasOnlyAllowedChars => RegExp(r'^[A-Za-z\d]*$').hasMatch(password);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PasswordRequirementItem(
          isValid: hasMinLength,
          text: 'Від 8 до 128 символів',
        ),
        const SizedBox(height: 6),
        PasswordRequirementItem(
          isValid: hasLetter,
          text: 'Містить щонайменше одну літеру',
        ),
        const SizedBox(height: 6),
        PasswordRequirementItem(
          isValid: hasDigit,
          text: 'Містить щонайменше одну цифру',
        ),
        const SizedBox(height: 6),
        PasswordRequirementItem(
          isValid: hasOnlyAllowedChars,
          text: 'Без пробілів і спеціальних символів',
        ),
      ],
    );
  }
}
