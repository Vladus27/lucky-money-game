import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucky_money_app/common/models/game/current_game.dart';
import 'package:lucky_money_app/common/models/game/game_model.dart';
import 'package:lucky_money_app/common/models/game/game_state.dart';

import 'package:lucky_money_app/features/game/widgets/game_button_act.dart';
import 'package:lucky_money_app/features/game/widgets/game_error_state.dart';
import 'package:lucky_money_app/features/game/widgets/game_grid.dart';
import 'package:lucky_money_app/features/game/widgets/game_setting_bottom_sheet.dart';
import 'package:lucky_money_app/features/game/widgets/game_stat_card.dart';
import 'package:lucky_money_app/providers/game_provider.dart';
import 'package:lucky_money_app/providers/user_provider.dart';
import 'package:lucky_money_app/repo/game_repository.dart';

class GameScreen extends ConsumerStatefulWidget {
  const GameScreen({super.key});

  @override
  ConsumerState<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends ConsumerState<GameScreen> {
  @override
  void initState() {
    super.initState();
    // При ініціалізації екрану provider автоматично завантажить дані
    // через метод build() в GameNotifier
  }

  @override
  Widget build(BuildContext context) {
    final gameState = ref.watch(gameNotifierProvider);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(title: const Text('Lucky-money')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: gameState.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stack) => GameErrorState(message: error.toString()),
          data: (state) {
            // Показуємо snackbar з помилкою, але не блокуємо UI
            if (state.hasError) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    behavior: SnackBarBehavior.floating,
                    content: Text(state.errorMessage!),
                    action: SnackBarAction(
                      label: 'OK',
                      onPressed: () {
                        ref.read(gameNotifierProvider.notifier).clearError();
                      },
                    ),
                  ),
                );
              });

              // Якщо це критична помилка (не тільки "гри немає")
              if (state.game == null) {
                return GameErrorState(message: state.errorMessage!);
              }
            }

            return _GameContent(gameState: state);
          },
        ),
      ),
    );
  }
}

class _GameContent extends ConsumerWidget {
  final GameState gameState;

  const _GameContent({required this.gameState});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentGame = gameState.game;

    // Якщо гри немає - показуємо інтерфейс для старту нової гри
    if (currentGame == null) {
      return Column(
        children: [
          const Row(
            children: [
              Expanded(child: GameStatCard.multiplier()),
              const SizedBox(width: 12),
              Expanded(child: GameStatCard.payOut()),
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
      );
    }

    // Є активна гра
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: GameStatCard.multiplier(
                value: currentGame.currentMultiplier.toString(),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: GameStatCard.payOut(
                value: currentGame.currentPayoutAmount.toString(),
              ),
            ),
          ],
        ),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 12),
          child: GameGrid(),
        ),
        GameButtonAct(
          gameStatus: currentGame.status,
          nextCof: "currentGame.nextMultiplier?.toString() ?? '0'",
          handleBet: () => _handleBet(context, ref, currentGame.status),
        ),
      ],
    );
  }

  void _handleBet(BuildContext context, WidgetRef ref, GameStatus status) {
    if (status == GameStatus.active) {
      _onCashout(context, ref);
    } else {
      _showBottomSheet(context, ref);
    }
  }

  Future<void> _onCashout(BuildContext context, WidgetRef ref) async {
    final success = await ref.read(gameNotifierProvider.notifier).cashout(ref);

    if (context.mounted && success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          behavior: SnackBarBehavior.floating,
          content: Text('Виплата успішна!'),
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
    ).then((_) {
      // Після закриття bottom sheet оновлюємо стан гри
      // (на випадок якщо користувач створив нову гру)
      ref.read(gameNotifierProvider.notifier).refresh();
    });
  }
}
