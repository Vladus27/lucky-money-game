class RevealBomb {
  final bool isBomb;
  final double currentMultiplier;
  final double currentCashoutAmount;
  final Set<int> minePositions;
  final double nextMultiplier;

  const RevealBomb({
    required this.isBomb,
    required this.currentMultiplier,
    required this.currentCashoutAmount,
    required this.minePositions,
    required this.nextMultiplier,
  });

  factory RevealBomb.fromJson(Map<String, dynamic> json) {
    final rawMines = json['minePositions'];
    return RevealBomb(
      isBomb: json['isBomb'] as bool,
      currentMultiplier: json['currentMultiplier'] as double,
      currentCashoutAmount: json['currentCashoutAmount'] as double,
      minePositions: rawMines == null
          ? {}
          : (rawMines as List).map((e) => e['positionId'] as int).toSet(),
      nextMultiplier: json["nextMultiplier"],
    );
  }
}
