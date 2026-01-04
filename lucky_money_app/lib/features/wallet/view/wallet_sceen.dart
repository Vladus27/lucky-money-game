import 'package:flutter/material.dart';

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
                  cardLabel: 'БАЛАНС (WBT)',
                  cardBalance: '1500.00',
                  colorHead: colorTheme.primary,
                ),
                WalletBalanceCard(
                  cardLabel: 'У ГРІ',
                  cardBalance: 'comming soon...',
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
