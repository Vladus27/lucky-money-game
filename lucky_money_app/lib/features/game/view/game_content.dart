import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:lucky_money_app/common/models/game/current_game.dart';
import 'package:lucky_money_app/common/models/game/game_model.dart';
import 'package:lucky_money_app/common/models/game/game_state.dart';
import 'package:lucky_money_app/features/game/widgets/game_button_act.dart';
import 'package:lucky_money_app/features/game/widgets/game_grid.dart';
import 'package:lucky_money_app/features/game/widgets/game_setting_bottom_sheet.dart';
import 'package:lucky_money_app/features/game/widgets/game_stat_card.dart';
import 'package:lucky_money_app/features/history/widgets/history_adaptive_view.dart';
import 'package:lucky_money_app/providers/game_provider.dart';

class GameContent extends ConsumerWidget {
  const GameContent({super.key, required this.gameState});
  final GameState gameState;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentGame = gameState.game;

    // Визначаємо статус гри
    final gameStatus = currentGame?.status ?? GameStatus.cashedOut;

    // Якщо гри немає - показуємо інтерфейс для старту нової гри
    if (currentGame == null) {
      return HistoryAdaptiveView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const Row(
                children: [
                  Expanded(child: GameStatCard.multiplier(value: null)),
                  SizedBox(width: 12),
                  Expanded(child: GameStatCard.payOut(value: null)),
                ],
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 12),
                child: GameGrid(),
              ),
              GameButtonAct(
                gameStatus: GameStatus.cashedOut,
                nextCof: '1.0',
                handleBet: () => _showBottomSheet(context, ref),
              ),
            ],
          ),
        ),
      );
    }

    // Є активна гра або завершена - показуємо актуальні дані
    return SingleChildScrollView(
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: GameStatCard.multiplier(
                  value: currentGame.currentMultiplier.toStringAsFixed(2),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: GameStatCard.payOut(
                  value: currentGame.currentPayoutAmount.toStringAsFixed(2),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          const GameGrid(),
          GameButtonAct(
            gameStatus: gameStatus,
            nextCof: _getNextMultiplier(currentGame),
            handleBet: () => _handleBet(context, ref, gameStatus),
          ),
        ],
      ),
    );
  }

  String _getNextMultiplier(CurrentGame game) {
    // Для програної або кешаутнутої гри показуємо 0
    if (game.status == GameStatus.lost || game.status == GameStatus.cashedOut) {
      return '0.00';
    }

    // Для активної гри - наступний множник
    // Якщо у тебе є nextMultiplier в CurrentGame - використай його
    // Наразі використовую currentMultiplier * 2 як приклад
    return (game.currentMultiplier * 2).toStringAsFixed(2);
  }

  void _handleBet(BuildContext context, WidgetRef ref, GameStatus status) {
    if (status == GameStatus.active) {
      _onCashout(context, ref);
    } else {
      _showBottomSheet(context, ref);
    }
  }

  Future<void> _onCashout(BuildContext context, WidgetRef ref) async {
    // Зберігаємо суму виплати ДО кешауту
    final currentPayoutAmount =
        ref.read(gameNotifierProvider).value?.game?.currentPayoutAmount ?? 0;

    final success = await ref.read(gameNotifierProvider.notifier).cashout(ref);

    if (context.mounted && success) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.green,
          content: Text(
            '🎉 Вітаємо! Ви виграли ${currentPayoutAmount.toStringAsFixed(2)} грн!',
          ),
        ),
      );
    }
  }

  void _showBottomSheet(BuildContext context, WidgetRef ref) {
    showModalBottomSheet<void>(
      barrierColor: Colors.black.withValues(alpha: 0.9),
      isScrollControlled: true,
      context: context,
      builder: (_) => const GameSettingBottomSheet(),
    );
  }
}
