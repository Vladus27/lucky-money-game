import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucky_money_app/providers/bet_validation_result_provider.dart';
import 'package:lucky_money_app/providers/game_bet_provider.dart';
// import 'package:lucky_money_app/providers/game_input_bet_provider.dart';

class GameButtonStart extends ConsumerWidget {
  const GameButtonStart({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final bet = ref.watch(gameBetProvider);
    final validator = ref.read(betValidatorProvider.notifier);

    return OutlinedButton(
      onPressed: () {
        final result = validator.validate(bet);
        validator.updateValidation(bet);
        if (!result.isValid) return;
        Navigator.pop(context);
      },
      child: const Text('ПОЧАТИ ГРУ'),
    );
  }
}
