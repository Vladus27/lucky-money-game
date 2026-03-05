import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:lucky_money_app/features/game/view/game_content.dart';
import 'package:lucky_money_app/features/game/widgets/game_error_state.dart';
import 'package:lucky_money_app/providers/game_provider.dart';

class GameScreen extends ConsumerWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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

            return GameContent(gameState: state);
          },
        ),
      ),
    );
  }
}
