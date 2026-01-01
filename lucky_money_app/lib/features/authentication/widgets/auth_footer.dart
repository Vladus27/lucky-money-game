import 'package:flutter/material.dart';

class AuthFooter extends StatelessWidget {
  const AuthFooter({
    super.key,
    required this.question,
    required this.questionButton,
    required this.toogleMode,
  });
  final String question;
  final String questionButton;
  // final VoidCallback onPressed;
  final void Function() toogleMode;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(question),
        TextButton(onPressed: toogleMode, child: Text(questionButton)),
      ],
    );
  }
}
