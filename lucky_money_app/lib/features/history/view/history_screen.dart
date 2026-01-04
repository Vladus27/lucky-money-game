import 'package:flutter/material.dart';
import 'package:lucky_money_app/common/models/history_model.dart';
import 'package:lucky_money_app/features/history/widgets/history_empty_state.dart';
import 'package:lucky_money_app/features/history/widgets/history_tile.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final history = [
      HistoryItem(
        type: HistoryType.deposit,
        date: DateTime.now().subtract(const Duration(days: 1)),
        amount: 500,
      ),
      HistoryItem(
        type: HistoryType.bet,
        date: DateTime.now().subtract(const Duration(hours: 3)),
        amount: -100,
      ),
      HistoryItem(
        type: HistoryType.payout,
        date: DateTime.now(),
        amount: 250,
        coefficient: 2.5,
      ),
    ];

    if (history.isNotEmpty) {
      return HistoryEmptyState(
        onDepositPressed: () {
          Navigator.pushNamed(context, '/wallet');
        },
      );
    }

    return ListView.builder(
      itemCount: history.length,
      itemBuilder: (context, index) {
        return HistoryTile(item: history[index]);
      },
    );
  }
}
