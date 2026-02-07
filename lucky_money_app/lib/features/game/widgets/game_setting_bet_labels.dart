import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucky_money_app/providers/game_bet_provider.dart';
import 'package:lucky_money_app/providers/user_provider.dart';

class GameSettingBetLabels extends ConsumerWidget {
  const GameSettingBetLabels({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String loadingBalance = '--.--';
    final selectedBet = ref.watch(gameBetProvider);
    final asyncBalance = ref.watch(balanceProvider);

    return asyncBalance.when(
      loading: () => _buildRow(context, selectedBet, loadingBalance),
      error: (error, stack) {
        // Показуємо snackbar з помилкою (але не блокуємо UI)
        WidgetsBinding.instance.addPostFrameCallback((_) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              behavior: SnackBarBehavior.floating,
              content: Text('Помилка балансу: ${error.toString()}'),
            ),
          );
        });
        return _buildRow(
          context,
          selectedBet,
          '--.--',
        ); // Показуємо дефолтний баланс при помилці
      },
      data: (balanceResult) {
        if (!balanceResult.isSuccess) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                behavior: SnackBarBehavior.floating,
                content: Text(balanceResult.error!.message),
              ),
            );
          });
          return _buildRow(context, selectedBet, loadingBalance);
        } else {
          return _buildRow(
            context,
            selectedBet,
            balanceResult.data!,
          ); // Показуємо реальний баланс
        }
      },
    );
    // return _buildRow(context, selectedBet, loadingBalance);
  }

  Widget _buildRow(
    BuildContext context,
    double selectedBet,
    String balanceText,
  ) {
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
            'Баланс: $balanceText WBT',

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
