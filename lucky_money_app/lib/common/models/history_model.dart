import 'package:flutter/material.dart';

enum HistoryType { deposit, bet, payout }

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
  final HistoryType type;
  final DateTime date;
  final double amount;
  final double? coefficient;

  const HistoryItem({
    required this.type,
    required this.date,
    required this.amount,
    this.coefficient,
  });
}
