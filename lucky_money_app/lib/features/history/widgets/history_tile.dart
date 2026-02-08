import 'package:flutter/material.dart';
import 'package:lucky_money_app/common/models/history_model.dart';

class HistoryTile extends StatelessWidget {
  const HistoryTile({super.key, required this.item});

  final HistoryItem item;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ListTile(
      leading: CircleAvatar(
        backgroundColor: item.operationType
            .color(context)
            .withValues(alpha: 0.1),
        child: Icon(
          item.operationType.icon,
          color: item.operationType.color(context),
        ),
      ),
      title: Text(item.operationType.title, style: theme.textTheme.bodyLarge),
      subtitle: Text(item.formattedDate, style: theme.textTheme.bodySmall),
      trailing: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '${item.amount > 0 ? '+' : ''}${item.amount}',
            style: theme.textTheme.bodyLarge?.copyWith(
              color: item.amount >= 0
                  ? theme.colorScheme.tertiary
                  : theme.colorScheme.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
          if (item.coefficient != null)
            Text('x${item.coefficient}', style: theme.textTheme.bodySmall),
        ],
      ),
    );
  }
}
