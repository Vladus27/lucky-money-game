enum CurrentGameStatus { active, lost, cashedOut }

CurrentGameStatus gameStatusFromInt(int value) {
  switch (value) {
    case 0:
      return CurrentGameStatus.active;
    case 1:
      return CurrentGameStatus.lost;
    case 2:
      return CurrentGameStatus.cashedOut;
    default:
      return CurrentGameStatus.lost;
  }
}

class CurrentGame {
  final String id;
  final int minesCount;
  final double currentPayoutAmount; // money you get if you cashout now
  final double currentMultiplier;
  final double betAmount;
  final CurrentGameStatus status; // 0, - Active = 0, Lost = 1, CashedOut = 2
  final DateTime createdAt; //: 1767197528, seconds
  final Set<int>? revealedPositions;

  const CurrentGame({
    required this.id,
    required this.betAmount,
    required this.createdAt,
    required this.currentMultiplier,
    required this.currentPayoutAmount,
    required this.minesCount,
    required this.status,
    required this.revealedPositions,
  });

  factory CurrentGame.fromJson(Map<String, dynamic> json) {
    final rawMines = json['minePositions'];
    return CurrentGame(
      id: json['id'],
      betAmount: json['betAmount'],
      createdAt: DateTime.fromMillisecondsSinceEpoch(json['createdAt'] * 1000),
      currentMultiplier: json['currentMultiplier'],
      currentPayoutAmount: json['currentPayoutAmount'],
      minesCount: json['minesCount'],
      status: gameStatusFromInt(json['status']),
      revealedPositions: rawMines == null
          ? {}
          : (rawMines as List).map((e) => e['positionId'] as int).toSet(),
    );
  }
}
