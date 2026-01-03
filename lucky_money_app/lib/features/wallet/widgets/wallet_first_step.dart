import 'package:flutter/material.dart';
import 'package:lucky_money_app/features/wallet/widgets/wallet_address_input.dart';

class WalletFirstStep extends StatelessWidget {
  const WalletFirstStep({
    super.key,
    required this.stepLabel,
    required this.stepDescription,
  });
  final String stepLabel;
  final String stepDescription;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          stepLabel,
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
        const WalletAddressInput(),
      ],
    );
  }
}
