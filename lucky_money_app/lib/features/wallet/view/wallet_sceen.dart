import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:lucky_money_app/common/models/wallet_section_copy.dart';
import 'package:lucky_money_app/features/wallet/widgets/wallet_balance_card.dart';
import 'package:lucky_money_app/features/wallet/widgets/wallet_header.dart';
import 'package:lucky_money_app/features/wallet/widgets/wallet_hero_section.dart';
import 'package:lucky_money_app/providers/user_provider.dart';

class WalletScreen extends ConsumerWidget {
  const WalletScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorTheme = Theme.of(context).colorScheme;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ref.invalidate(balanceProvider);
        },
        child: const Icon(Icons.refresh_outlined),
      ),
      appBar: const WalletHeader(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const WalletHeroSection(),
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                WalletBalanceCard(
                  wallet: WalletSection.totalBalance,
                  colorHead: colorTheme.primary,
                ),
                WalletBalanceCard(
                  wallet: WalletSection.inGameBalance,
                  colorHead: colorTheme.secondary,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
