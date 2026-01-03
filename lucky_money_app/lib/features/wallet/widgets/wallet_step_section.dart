import 'package:flutter/material.dart';

import 'package:lucky_money_app/features/wallet/widgets/wallet_card_step.dart';
import 'package:lucky_money_app/features/wallet/widgets/wallet_faucet_block.dart';
import 'package:lucky_money_app/features/wallet/widgets/wallet_first_step.dart';
import 'package:lucky_money_app/features/wallet/widgets/wallet_treasury_block.dart';

class WalletStepSection extends StatelessWidget {
  const WalletStepSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const WalletFirstStep(),
        const SizedBox(height: 24),
        WalletStepCard(
          stepNum: '1',
          stepLabel: 'stepLabel',
          stepDescription: 'stepDescription',
          stepContent: WalletFaucetBlock(openLink: () {}),
        ),
        const SizedBox(height: 24),
        const WalletStepCard(
          stepNum: '2',
          stepLabel: 'stepLabel',
          stepDescription: 'stepDescription',
          stepContent: WalletTreasuryBlock(),
        ),
        const SizedBox(height: 12),
      ],
    );
  }
}
