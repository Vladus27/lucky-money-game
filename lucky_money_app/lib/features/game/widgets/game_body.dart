import 'package:flutter/material.dart';
import 'package:lucky_money_app/common/models/game/current_game.dart';
import 'package:lucky_money_app/features/game/widgets/game_grid.dart';
import 'package:lucky_money_app/features/game/widgets/game_stat_card.dart';

class GameBody extends StatelessWidget {
  const GameBody({super.key, required this.game});
  final CurrentGame? game;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: GameStatCard.multiplier(
                value: game?.currentMultiplier.toString(),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: GameStatCard.payOut(
                value: game?.currentPayoutAmount.toString(),
              ),
            ),
          ],
        ),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 12),
          child: GameGrid(),
        ),
      ],
    );
  }
}
