// providers/game_notifier.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:lucky_money_app/common/models/game/current_game.dart';
import 'package:lucky_money_app/common/models/game/game_model.dart';
import 'package:lucky_money_app/common/models/game/game_state.dart';
import 'package:lucky_money_app/common/models/game/reveal_bomb.dart';
import 'package:lucky_money_app/repo/game_repository.dart';
import 'package:lucky_money_app/providers/user_provider.dart';

// Результат відкриття клітинки
class RevealBombResult {
  final bool success;
  final RevealBomb? revealBomb;

  const RevealBombResult({required this.success, this.revealBomb});
}

class GameNotifier extends AsyncNotifier<GameState> {
  late final GameRepository _gameRepo;

  @override
  Future<GameState> build() async {
    _gameRepo = GameRepository();

    // Завжди завантажуємо свіжі дані при створенні notifier
    return await _loadCurrentGame();
  }

  Future<GameState> _loadCurrentGame() async {
    final result = await _gameRepo.getCurrentGame();

    if (!result.isSuccess) {
      // Якщо гри немає (це нормально) - повертаємо пустий стан
      if (result.error?.statusCode == 404 ||
          result.error?.message == 'Поточної гри не знайдено') {
        return GameState.loaded(null);
      }

      // Інші помилки - повертаємо стан з помилкою
      return GameState.error(result.error!.message);
    }

    return GameState.loaded(result.data);
  }

  // Метод для старту нової гри
  Future<bool> startGame({
    required double betAmount,
    required int minesCount,
    required WidgetRef ref,
  }) async {
    final result = await _gameRepo.gameStart(
      betAmount: betAmount,
      minesCount: minesCount,
    );

    if (!result.isSuccess) {
      state = AsyncData(GameState.error(result.error!.message));
      return false;
    }

    // Оновлюємо баланс після старту гри
    ref.invalidate(balanceProvider);
    ref.invalidate(getHistoryOperationProvider);

    // Завантажуємо нову гру
    await refresh();
    return true;
  }

  // Метод для оновлення поточної гри
  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => _loadCurrentGame());
  }

  // Метод для відкриття позиції
  Future<RevealBombResult> revealPosition(int positionId) async {
    final result = await _gameRepo.revealPosition(positionId: positionId);

    if (!result.isSuccess) {
      // Оновлюємо стан з помилкою
      state = AsyncData(GameState.error(result.error!.message));
      return const RevealBombResult(success: false);
    }

    final revealBomb = result.data!;
    final currentState = state.value;

    // Якщо підірвалися на бомбі - оновлюємо стан з позиціями бомб
    if (revealBomb.isBomb) {
      if (currentState?.game != null) {
        // Створюємо оновлену гру з позиціями бомб та статусом Lost
        final updatedGame = CurrentGame(
          id: currentState!.game!.id,
          betAmount: currentState.game!.betAmount,
          createdAt: currentState.game!.createdAt,
          currentMultiplier: 0,
          currentPayoutAmount: 0,
          minesCount: currentState.game!.minesCount,
          status: GameStatus.lost,
          revealedPositions: revealBomb.minePositions, // Позиції бомб
        );
        // Зберігаємо безпечні клітинки які відкрили до програшу
        state = AsyncData(
          GameState.loaded(
            updatedGame,
            safePositions: currentState.safeRevealedPositions,
          ),
        );
      }
      return RevealBombResult(success: true, revealBomb: revealBomb);
    }

    // Якщо безпечна клітинка - додаємо її до історії
    final updatedSafePositions = Set<int>.from(
      currentState?.safeRevealedPositions ?? {},
    )..add(positionId);

    // Оновлюємо гру
    final gameResult = await _loadCurrentGame();
    state = AsyncData(
      GameState.loaded(gameResult.game, safePositions: updatedSafePositions),
    );

    return RevealBombResult(success: true, revealBomb: revealBomb);
  }

  // Метод для кешауту
  Future<bool> cashout(WidgetRef ref) async {
    final result = await _gameRepo.getCashout();

    if (!result.isSuccess) {
      state = AsyncData(GameState.error(result.error!.message));
      return false;
    }

    // Оновлюємо баланс
    ref.invalidate(balanceProvider);
    ref.invalidate(getHistoryOperationProvider);

    // Оновлюємо стан гри (тепер гри немає)
    state = const AsyncData(GameState(game: null));
    return true;
  }

  // Метод для очищення помилки
  void clearError() {
    final currentState = state.value;
    if (currentState != null && !currentState.hasError) {
      return;
    }
    state = AsyncData(GameState.loaded(currentState?.game));
  }

  // Метод для скидання гри до початкового стану
  void resetToInitial() {
    state = const AsyncData(GameState(game: null));
  }
}

// ВАЖЛИВО: autoDispose - щоб provider знищувався при закритті екрану
final gameNotifierProvider =
    AsyncNotifierProvider.autoDispose<GameNotifier, GameState>(
      () => GameNotifier(),
    );
