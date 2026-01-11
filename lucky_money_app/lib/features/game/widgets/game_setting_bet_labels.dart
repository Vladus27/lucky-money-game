import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucky_money_app/providers/game_bet_provider.dart';

class GameSettingBetLabels extends ConsumerWidget {
  const GameSettingBetLabels({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final selectedBet = ref.watch(gameBetProvider);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text('Ставка'),
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.tertiary.withValues(alpha: .3),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            'Баланс: 300 WBT',
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              // color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
        Text(
          '$selectedBet WBT',
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ],
    );
  }
}
