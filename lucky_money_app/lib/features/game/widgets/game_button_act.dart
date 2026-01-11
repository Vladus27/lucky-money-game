import 'package:flutter/material.dart';
import 'package:lucky_money_app/common/widgets/box_shadow.dart';
import 'package:lucky_money_app/features/game/view/example_game_screen.dart';

class GameButtonAct extends StatelessWidget {
  const GameButtonAct({
    super.key,
    required this.gameStatus,
    required this.handleBet,
  });
  final GameStatus gameStatus;
  final void Function() handleBet;

  @override
  Widget build(BuildContext context) {
    bool isGameStarted = gameStatus == GameStatus.playing;
    final label = isGameStarted ? 'кешаут' : 'налаштувати';
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
          if (isGameStarted)
            Text('Наступний множник: x1.47', style: theme.textTheme.bodySmall),
        ],
      ),
    );
  }
}
