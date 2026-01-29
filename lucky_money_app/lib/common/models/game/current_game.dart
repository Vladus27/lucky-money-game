enum CurrentGameStatus { active, lost, cashedOut }

CurrentGameStatus gameStatusFrom(String value) {
  switch (value) {
    case "Active":
      return CurrentGameStatus.active;
    case "Lost":
      return CurrentGameStatus.lost;
    case "CashedOut":
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
  final double nextMultiplier;
  final double betAmount;
  final CurrentGameStatus status;
  final DateTime createdAt; //: 1767197528, seconds
  final Set<int> revealedPositions;

  const CurrentGame({
    required this.id,
    required this.betAmount,
    required this.createdAt,
    required this.currentMultiplier,
    required this.currentPayoutAmount,
    required this.nextMultiplier,
    required this.minesCount,
    required this.status,
    required this.revealedPositions,
  });

  factory CurrentGame.fromJson(Map<String, dynamic> json) {
    final rawOpenSafes = json['revealedPositions'] as List;
    return CurrentGame(
      id: json['id'],
      betAmount: json['betAmount'],
      createdAt: DateTime.fromMillisecondsSinceEpoch(json['createdAt'] * 1000),
      currentMultiplier: json['currentMultiplier'],
      currentPayoutAmount: json['currentPayoutAmount'],
      nextMultiplier: json['nextMultiplier'],
      minesCount: json['minesCount'],
      status: gameStatusFrom(json['status']),
      revealedPositions: rawOpenSafes.isEmpty
          ? {}
          : (rawOpenSafes).map((e) => e['positionId'] as int).toSet(),
    );
  }
}
