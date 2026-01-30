import 'package:lucky_money_app/common/models/game/game_model.dart';

GameStatus gameStatusFrom(String value) {
  switch (value) {
    case "Active":
      return GameStatus.active;
    case "Lost":
      return GameStatus.lost;
    case "CashedOut":
      return GameStatus.cashedOut;
    default:
      return GameStatus.lost;
  }
}

class CurrentGame {
  final String id;
  final int minesCount;
  final double currentPayoutAmount; // money you get if you cashout now
  final double currentMultiplier;
  // final double nextMultiplier;
  final double betAmount;
  final GameStatus status;
  final DateTime createdAt; //: 1767197528, seconds
  final Set<int> revealedPositions;

  const CurrentGame({
    required this.id,
    required this.betAmount,
    required this.createdAt,
    required this.currentMultiplier,
    required this.currentPayoutAmount,
    // required this.nextMultiplier,
    required this.minesCount,
    required this.status,
    required this.revealedPositions,
  });

  factory CurrentGame.fromJson(Map<String, dynamic> json) {
    final rawOpenSafes = json['revealedPositions'] as List;
    return CurrentGame(
      id: json['id'],
      betAmount: (json['betAmount'] as num).toDouble(),
      createdAt: DateTime.fromMillisecondsSinceEpoch(json['createdAt'] * 1000),
      currentMultiplier: (json['currentMultiplier'] as num).toDouble(),
      currentPayoutAmount: (json['currentPayoutAmount'] as num).toDouble(),
      // nextMultiplier: (json['nextMultiplier'] as num).toDouble(),
      minesCount: json['minesCount'],
      status: gameStatusFrom(json['status']),
      revealedPositions: rawOpenSafes.isEmpty
          ? {}
          : (rawOpenSafes).map((e) => e['positionId'] as int).toSet(),
    );
  }
}
