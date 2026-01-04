import 'package:flutter/material.dart';

class WalletTreasuryBlock extends StatelessWidget {
  const WalletTreasuryBlock({
    super.key,
    required this.treasuryLabel,
    required this.treasuryAddress,
  });
  final String treasuryLabel;
  final String treasuryAddress;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.secondary,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 2),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(treasuryLabel, style: theme.textTheme.bodySmall),
                Text(
                  treasuryAddress,
                  style: theme.textTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            IconButton(onPressed: () {}, icon: const Icon(Icons.copy_rounded)),
          ],
        ),
      ),
    );
  }
}
