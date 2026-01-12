import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucky_money_app/providers/auth_provider.dart';
import 'package:lucky_money_app/repo/secure_storage_service.dart';

class HomeHeaderLogged extends ConsumerWidget {
  const HomeHeaderLogged({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final asyncUser = ref.watch(userProvider);
    final asyncBalance = ref.watch(balanceProvider);

    final theme = Theme.of(context);

    // String balance = '0.023423424234230'; //temp
    String truncate(String text, int length) {
      return text.length > length ? '${text.substring(0, length)}…' : text;
    }

    return asyncUser.when(
      loading: () => const CircularProgressIndicator(),
      error: (_, __) => const Text('Фатальна помилка'),
      data: (result) {
        if (!result.isSuccess) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                behavior: SnackBarBehavior.floating,
                content: Text(result.error!.message),
              ),
            );
          });

          return const SizedBox();
        }
        final user = result.data!;
        return asyncBalance.when(
          loading: () => const CircularProgressIndicator(),
          error: (_, __) => const Text('Помилка балансу'),
          data: (balanceResult) {
            String balanceText = '—';
            if (!balanceResult.isSuccess) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    behavior: SnackBarBehavior.floating,
                    content: Text(balanceResult.error!.message),
                  ),
                );
              });
            } else {
              balanceText = balanceResult.data!;
            }
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: theme.colorScheme.onSurface,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8.0,
                    vertical: 2,
                  ),
                  child: Row(
                    children: [
                      SizedBox(
                        height: 32,
                        width: 32,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: theme.colorScheme.primary,
                          ),
                          child: const Icon(Icons.person_outline_rounded),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            truncate(user.username, 15),
                            overflow: TextOverflow.ellipsis,
                            style: theme.textTheme.labelLarge,
                          ),
                          Row(
                            children: [
                              Text(
                                truncate(balanceText, 14),
                                style: theme.textTheme.labelSmall,
                              ),
                              const SizedBox(width: 8),
                              Text('WBT', style: theme.textTheme.labelMedium),
                            ],
                          ),
                        ],
                      ),

                      IconButton(
                        onPressed: () async {
                          final store = SecureStorageService();
                          await store.deleteToken();
                          ref.invalidate(userProvider);
                        },
                        icon: const Icon(Icons.logout),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
