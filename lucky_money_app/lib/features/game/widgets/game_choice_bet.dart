import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucky_money_app/providers/bet_validation_result_provider.dart';
import 'package:lucky_money_app/providers/game_bet_provider.dart';

class GameChoiceBet extends ConsumerWidget {
  const GameChoiceBet({
    super.key,
    required this.bet,
    required this.balance,
    required this.betController,
  });

  final double balance;
  final double bet;
  final TextEditingController betController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    final betNotifier = ref.read(gameBetProvider.notifier);
    final selectedBet = ref.watch(gameBetProvider);

    final isAvailable = balance >= bet;
    // Показуємо як вибрану тільки якщо вона доступна
    final isSelected = isAvailable && selectedBet == bet;

    return ChoiceChip(
      label: SizedBox(
        width: double.infinity,
        child: Text(
          '$bet',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: isSelected
                ? theme.colorScheme.surface
                : theme.colorScheme.onSurface,
          ),
        ),
      ),
      selected: isSelected,
      selectedColor: theme.colorScheme.primary,
      checkmarkColor: theme.colorScheme.surface,
      onSelected: isAvailable
          ? (selected) {
              if (selected) {
                betController.text = bet.toString();
                betNotifier.setBet(bet);
                ref
                    .read(betValidatorProvider.notifier)
                    .updateValidation(bet, balance);
              } else {
                betController.clear();
                betNotifier.setBet(0);
                ref
                    .read(betValidatorProvider.notifier)
                    .updateValidation(null, balance);
              }
            }
          : null,
    );
  }
}
