import 'package:flutter/material.dart';
import 'package:lucky_money_app/common/models/game/game_model.dart';
import 'package:lucky_money_app/common/widgets/box_shadow.dart';

class GameButtonAct extends StatelessWidget {
  const GameButtonAct({
    super.key,
    required this.gameStatus,
    required this.nextCof,
    required this.handleBet,
  });

  final GameStatus gameStatus;
  final String nextCof;
  final void Function() handleBet;

  @override
  Widget build(BuildContext context) {
    final bool isGameActive = gameStatus == GameStatus.active;

    final String label = isGameActive ? 'кешаут' : 'налаштувати';
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        boxShadow: containerShadow,
      ),
      child: Column(
        children: [
          SizedBox(
            height: 56,
            width: double.infinity,
            child: OutlinedButton(
              onPressed: handleBet,
              child: Text(label.toUpperCase()),
            ),
          ),

          const SizedBox(height: 8),
          if (isGameActive)
            Text(
              'Наступний множник: $nextCof',
              style: theme.textTheme.bodySmall,
            ),
        ],
      ),
    );
  }
}
