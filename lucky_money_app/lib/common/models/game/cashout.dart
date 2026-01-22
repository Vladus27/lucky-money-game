class Cashout {
  final double amount;
  final double multiplier;
  const Cashout({required this.amount, required this.multiplier});

  factory Cashout.fromJson(Map<String, dynamic> json) {
    return Cashout(
      amount: json['amount'] as double,
      multiplier: json['multiplier'] as double,
    );
  }
}
