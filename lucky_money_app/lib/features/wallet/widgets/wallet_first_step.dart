import 'package:flutter/material.dart';
import 'package:lucky_money_app/common/models/wallet_section_copy.dart';
import 'package:lucky_money_app/features/wallet/widgets/wallet_address_input.dart';

class WalletFirstStep extends StatelessWidget {
  const WalletFirstStep({
    super.key,
    required this.stepLabel,
    required this.stepDescription,
    required this.userAddressInputLabel,
    required this.userAddressInputHint,
  });
  final String stepLabel;
  final String stepDescription;
  final String userAddressInputLabel;
  final String userAddressInputHint;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final wallet = WalletSectionCopy.step1();
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          wallet.stepLabel!,
          style: theme.textTheme.labelLarge!.copyWith(
            color: theme.colorScheme.surface.withValues(alpha: .8),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            stepDescription,
            style: theme.textTheme.bodyMedium!.copyWith(
              color: theme.colorScheme.onPrimary.withValues(alpha: .9),
              fontWeight: FontWeight.w300,
            ),
          ),
        ),
        WalletAddressInput(
          userAddressInputHint: userAddressInputHint,
          userAddressInputLabel: userAddressInputLabel,
        ),
      ],
    );
  }
}
