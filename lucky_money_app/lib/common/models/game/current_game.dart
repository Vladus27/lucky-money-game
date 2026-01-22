class CurrentGame {
  final String id;
  final double minesCount;
  final double currentPayoutAmount; // money you get if you cashout now
  final double currentMultiplier;
  final double betAmount;
  final double status; // 0, - Active = 0, Lost = 1, CashedOut = 2
  final int createdAt; //: 1767197528, seconds
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
      createdAt: json['createdAt'],
      currentMultiplier: json['currentMultiplier'],
      currentPayoutAmount: json['currentPayoutAmount'],
      minesCount: json['minesCount'],
      status: json['status'],
      revealedPositions: rawMines == null
          ? null
          : (rawMines as List).map((e) => e['positionId'] as int).toSet(),
    );
  }
}
