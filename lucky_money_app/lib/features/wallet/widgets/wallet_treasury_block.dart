import 'package:flutter/material.dart';

class WalletTreasuryBlock extends StatelessWidget {
  const WalletTreasuryBlock({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: double.infinity,
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
                Text(
                  'Treasury Address (Sepolia)',
                  style: theme.textTheme.bodySmall,
                ),
                Text(
                  '0x742d...44e',
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
