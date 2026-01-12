class User {
  final String id;
  final String username;
  final String balance;

  User({required this.id, required this.username, required this.balance});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json["id"],
      username: json["userName"],
      balance: json["balance"] ?? "0",
    );
  }
}
