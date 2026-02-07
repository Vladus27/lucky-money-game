import 'package:flutter/material.dart';

class GameButtonStart extends StatelessWidget {
  const GameButtonStart({
    super.key,
    required this.onSubmit,
    this.isLoading = false,
  });

  final void Function()? onSubmit;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: isLoading ? null : onSubmit,
      child: isLoading
          ? const SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(strokeWidth: 2),
            )
          : const Text('ПОЧАТИ ГРУ'),
    );
  }
}
