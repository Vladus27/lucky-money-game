import 'package:flutter/material.dart';

import 'package:lucky_money_app/common/models/wallet_section_copy.dart';
import 'package:lucky_money_app/features/wallet/widgets/wallet_balance_card.dart';
import 'package:lucky_money_app/features/wallet/widgets/wallet_header.dart';
import 'package:lucky_money_app/features/wallet/widgets/wallet_hero_section.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorTheme = Theme.of(context).colorScheme;
    return Scaffold(
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
