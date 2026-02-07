// common/models/game/game_state.dart
import 'package:lucky_money_app/common/models/game/current_game.dart';

class GameState {
  final CurrentGame? game;
  final String? errorMessage;
  final bool hasError;
  final Set<int> safeRevealedPositions; // Історія безпечних відкритих клітинок

  const GameState({
    this.game,
    this.errorMessage,
    this.hasError = false,
    this.safeRevealedPositions = const {},
  });

  factory GameState.initial() => const GameState();

  factory GameState.loaded(CurrentGame? game, {Set<int>? safePositions}) =>
      GameState(game: game, safeRevealedPositions: safePositions ?? {});

  factory GameState.error(String message) =>
      GameState(hasError: true, errorMessage: message);

  bool get hasGame => game != null;
  bool get isNoGame => game == null && !hasError;

  GameState copyWith({
    CurrentGame? game,
    String? errorMessage,
    bool? hasError,
    Set<int>? safeRevealedPositions,
  }) {
    return GameState(
      game: game ?? this.game,
      errorMessage: errorMessage ?? this.errorMessage,
      hasError: hasError ?? this.hasError,
      safeRevealedPositions:
          safeRevealedPositions ?? this.safeRevealedPositions,
    );
  }
}
