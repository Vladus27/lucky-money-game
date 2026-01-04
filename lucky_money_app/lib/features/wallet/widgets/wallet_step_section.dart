import 'package:flutter/material.dart';
import 'package:lucky_money_app/common/models/wallet_section_copy.dart';

import 'package:lucky_money_app/features/wallet/widgets/wallet_card_step.dart';
import 'package:lucky_money_app/features/wallet/widgets/wallet_faucet_block.dart';
import 'package:lucky_money_app/features/wallet/widgets/wallet_first_step.dart';
import 'package:lucky_money_app/features/wallet/widgets/wallet_treasury_block.dart';

class WalletStepSection extends StatelessWidget {
  const WalletStepSection({super.key});

  @override
  Widget build(BuildContext context) {
    final walletStep1 = WalletSectionCopy.step1();
    final walletStep2 = WalletSectionCopy.step2();
    final walletStep3 = WalletSectionCopy.step3();
    return Column(
      children: [
        WalletFirstStep(
          stepLabel: walletStep1.stepLabel!,
          stepDescription: walletStep1.stepDescription!,
          userAddressInputLabel: walletStep1.userAddressInputLabel!,
          userAddressInputHint: walletStep1.userAddressInputHint!,
        ),
        const SizedBox(height: 24),
        WalletStepCard(
          stepNum: walletStep2.stepNum!,
          stepLabel: walletStep2.stepLabel!,
          stepDescription: walletStep2.stepDescription!,
          stepContent: WalletFaucetBlock(
            faucetLabel: walletStep2.faucetLabel!,
            openLink: () {},
          ),
        ),
        const SizedBox(height: 24),
        WalletStepCard(
          stepNum: walletStep3.stepNum!,
          stepLabel: walletStep3.stepLabel!,
          stepDescription: walletStep3.stepDescription!,
          stepContent: WalletTreasuryBlock(
            treasuryLabel: walletStep3.treasuryLabel!,
            treasuryAddress: walletStep3.treasuryAddress!,
          ),
        ),
        const SizedBox(height: 12),
      ],
    );
  }
}
