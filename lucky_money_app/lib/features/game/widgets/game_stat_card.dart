import 'package:flutter/material.dart';
import 'package:lucky_money_app/common/widgets/box_shadow.dart';

class GameStatCard extends StatelessWidget {
  const GameStatCard({
    super.key,
    required this.label,
    required this.value,
    required this.icon,
    required this.isGradientNeeded,
  });
  const GameStatCard.payOut({
    super.key,
    this.label = 'виплата',
    String? value,
    this.icon = Icons.account_balance_wallet,
    this.isGradientNeeded = true,
  }) : value = value ?? '0.0';
  const GameStatCard.multiplier({
    super.key,
    this.label = 'множник',
    String? value,
    this.icon = Icons.trending_up,
    this.isGradientNeeded = false,
  }) : value = value ?? 'x0.0';

  final String label;
  final IconData icon;
  final String value;
  final bool isGradientNeeded;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isGradientNeeded
            ? null
            : theme.colorScheme.onSurface.withValues(alpha: .8),
        borderRadius: BorderRadius.circular(12),
        gradient: isGradientNeeded
            ? LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  theme.colorScheme.primary,
                  theme.colorScheme.onSurface,
                  // theme.colorScheme.onSurface.withValues(alpha: 0.9),
                ],
              )
            : null,
        boxShadow: containerShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            label.toUpperCase(),
            style: theme.textTheme.bodyLarge!.copyWith(
              color: theme.colorScheme.surface,
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(icon, color: theme.colorScheme.primary),
              const SizedBox(width: 8),
              Text(value, style: theme.textTheme.labelMedium),
            ],
          ),
        ],
      ),
    );
  }
}
