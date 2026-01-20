import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucky_money_app/common/models/wallet_section_copy.dart';

import 'package:lucky_money_app/features/wallet/widgets/wallet_card_step.dart';
import 'package:lucky_money_app/features/wallet/widgets/wallet_empty_state.dart';
import 'package:lucky_money_app/features/wallet/widgets/wallet_faucet_block.dart';
import 'package:lucky_money_app/features/wallet/widgets/wallet_first_step.dart';
import 'package:lucky_money_app/features/wallet/widgets/wallet_treasury_block.dart';
import 'package:lucky_money_app/providers/user_provider.dart';

class WalletStepSection extends ConsumerWidget {
  const WalletStepSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final walletStep1 = WalletSectionCopy.step1();
    final walletStep2 = WalletSectionCopy.step2();
    final walletStep3 = WalletSectionCopy.step3();

    final asyncDepositData = ref.watch(getDepositDataProvider);

    return asyncDepositData.when(
      loading: () => Center(
        child: CircularProgressIndicator(
          color: Theme.of(context).colorScheme.surface,
        ),
      ),
      error: (error, stackTrace) => const Center(
        child: Text('Виникла помилка при отриманні даних для поповнення '),
      ),
      data: (depositResult) {
        if (!depositResult.isSuccess) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                behavior: SnackBarBehavior.floating,
                content: Text(depositResult.error!.message),
              ),
            );
          });
          return const WalletEmptyState();
        } else {
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
                  treasuryAddress: depositResult.data!.treasuryAddress,
                ),
              ),
              const SizedBox(height: 12),
            ],
          );
        }
      },
    );
  }
}
