import 'package:flutter/material.dart';
import 'package:lucky_money_app/common/constant/image_constants.dart';
import 'package:lucky_money_app/common/models/wallet_section_copy.dart';

class WalletUserHeader extends StatelessWidget {
  const WalletUserHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final wallet = WalletSectionCopy.start();
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(appLogo, height: 48, fit: BoxFit.contain),
          const SizedBox(width: 8),

          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                wallet.helloLabel!,
                style: const TextStyle(color: Colors.white),
              ),
              Text(
                wallet.username!,
                style: theme.textTheme.titleMedium!.copyWith(
                  fontWeight: FontWeight.w700,
                  color: theme.colorScheme.surface,
                ),
              ),
            ],
          ),
          const SizedBox(width: 12),
        ],
      ),
    );
  }
}
