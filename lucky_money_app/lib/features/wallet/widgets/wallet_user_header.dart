import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucky_money_app/common/constant/image_constants.dart';
import 'package:lucky_money_app/common/models/wallet_section_copy.dart';
import 'package:lucky_money_app/providers/user_provider.dart';

class WalletUserHeader extends ConsumerWidget {
  const WalletUserHeader({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final wallet = WalletSectionCopy.start();
    final asyncUsername = ref.watch(userProvider);
    String username = '';

    asyncUsername.when(
      loading: () => const CircularProgressIndicator(),
      error: (_, __) => const Text('Щось пішло не так'),
      data: (userResult) {
        if (!userResult.isSuccess) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                behavior: SnackBarBehavior.floating,
                content: Text(userResult.error!.message),
              ),
            );
          });
        } else {
          username = userResult.data!.username;
        }
      },
    );
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
                '@$username',
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
