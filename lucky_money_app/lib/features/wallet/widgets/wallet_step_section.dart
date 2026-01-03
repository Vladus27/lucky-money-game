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
        const WalletFirstStep(
          stepLabel: "Крок 1. З'єднання",
          stepDescription:
              "Введи адресу гаманця, з якого будеш здійснювати поповнення",
        ),
        const SizedBox(height: 24),
        WalletStepCard(
          stepNum: '1',
          stepLabel: 'Крок 2. Отримання токенів',
          stepDescription: 'Натисни кнопку нижче, щоб відкрити official faucet',
          stepContent: WalletFaucetBlock(openLink: () {}),
        ),
        const SizedBox(height: 24),
        const WalletStepCard(
          stepNum: '2',
          stepLabel: 'Крок 3. Поповнити баланс',
          stepDescription: 'Надішли отриманні токени за адресою нижче',
          stepContent: WalletTreasuryBlock(),
        ),
        const SizedBox(height: 12),
      ],
    );
  }
}
