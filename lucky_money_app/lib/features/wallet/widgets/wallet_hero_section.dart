import 'package:flutter/material.dart';
import 'package:lucky_money_app/features/wallet/widgets/wallet_step_section.dart';

import 'package:lucky_money_app/features/wallet/widgets/wallet_user_header.dart';

class WalletHeroSection extends StatelessWidget {
  const WalletHeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: theme.colorScheme.primary,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(48),
          bottomRight: Radius.circular(48),
        ),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            theme.colorScheme.primary,
            theme.colorScheme.onSurface,
            // theme.colorScheme.onSurface.withValues(alpha: 0.9),
          ],
        ),
      ),
      child: const Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            WalletUserHeader(),
            SizedBox(width: 12),
            WalletStepSection(),
          ],
        ),
      ),
    );
  }
}
