import 'package:flutter/material.dart';
import 'package:lucky_money_app/common/models/wallet_section_copy.dart';

class WalletBalanceCard extends StatelessWidget {
  const WalletBalanceCard({
    super.key,
    required this.wallet,
    required this.colorHead,
  });
  final WalletSection wallet;
  final Color colorHead;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final walletCopy = WalletSectionCopy.of(wallet);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: 70,
            width: 150,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withValues(alpha: 0.5),
                  spreadRadius: 0,
                  blurRadius: 4,
                  offset: const Offset(0, 4),
                ),
                BoxShadow(
                  color: Colors.grey.withValues(alpha: 0.5),
                  spreadRadius: 0,
                  blurRadius: .8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  // padding: const EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                    color: colorHead,
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(12),
                    ),
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(
                        walletCopy.balancelabel!,
                        style: theme.textTheme.labelLarge!.copyWith(
                          color: colorHead == theme.colorScheme.secondary
                              ? theme.colorScheme.onSurface
                              : theme.colorScheme.surface,
                        ),
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(walletCopy.balance!),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
