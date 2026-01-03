import 'package:flutter/material.dart';
import 'package:lucky_money_app/common/constant/image_constants.dart';

class WalletUserHeader extends StatelessWidget {
  const WalletUserHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
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
              const Text('Привіт,', style: TextStyle(color: Colors.white)),
              Text(
                '@VladGamler',
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
