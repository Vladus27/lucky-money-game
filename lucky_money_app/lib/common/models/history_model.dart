import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

enum HistoryType { deposit, bet, payout }

HistoryType historyTypeFrom(String value) {
  switch (value) {
    case "GameCashout":
      return HistoryType.payout;
    case "GameBet":
      return HistoryType.bet;
    case "Replenishment":
      return HistoryType.deposit;
    default:
      return HistoryType.bet;
  }
}

extension HistoryTypeX on HistoryType {
  String get title {
    switch (this) {
      case HistoryType.deposit:
        return 'Поповнення';
      case HistoryType.bet:
        return 'Ставка';
      case HistoryType.payout:
        return 'Виплата';
    }
  }

  IconData get icon {
    switch (this) {
      case HistoryType.deposit:
        return Icons.arrow_downward;
      case HistoryType.bet:
        return Icons.casino;
      case HistoryType.payout:
        return Icons.arrow_upward;
    }
  }

  Color color(BuildContext context) {
    final theme = Theme.of(context);
    switch (this) {
      case HistoryType.deposit:
        return theme.colorScheme.primary;
      case HistoryType.bet:
        return theme.colorScheme.secondary;
      case HistoryType.payout:
        return Colors.green;
    }
  }
}

class HistoryItem {
  final String id;
  final HistoryType operationType;
  final DateTime date;
  final double amount;
  final double? coefficient;

  const HistoryItem({
    required this.id,
    required this.operationType,
    required this.date,
    required this.amount,
    this.coefficient,
  });

  factory HistoryItem.fromJson(Map<String, dynamic> json) {
    return HistoryItem(
      id: json['id'],
      operationType: historyTypeFrom(json['operationType']),
      date: DateTime.fromMillisecondsSinceEpoch(json['createdAt'] * 1000),
      amount: (json["amount"] as num).toDouble(),
    );
  }
  String get formattedDate {
    return DateFormat('HH:mm dd.MM.yyyy').format(date);
  }
}
