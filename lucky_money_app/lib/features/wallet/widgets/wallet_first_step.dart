import 'package:flutter/material.dart';
import 'package:lucky_money_app/features/wallet/widgets/wallet_address_input.dart';

class WalletFirstStep extends StatelessWidget {
  const WalletFirstStep({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Крок 1. З'єднання",
          style: theme.textTheme.labelLarge!.copyWith(
            color: theme.colorScheme.surface.withValues(alpha: .8),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Введи адресу гаманця, з якого будеш здійснювати поповнення',
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
