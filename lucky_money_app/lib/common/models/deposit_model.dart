class Deposit {
  final String treasuryAddress;
  final String networkName;
  final String faucetUrl;
  final String symbol;
  const Deposit({
    required this.faucetUrl,
    required this.networkName,
    required this.treasuryAddress,
    required this.symbol,
  });

  factory Deposit.fromJson(Map<String, dynamic> json) {
    return Deposit(
      faucetUrl: json['faucetUrl'],
      networkName: json['networkName'],
      treasuryAddress: json['treasuryAddress'],
      symbol: json['symbol'],
    );
  }
}
