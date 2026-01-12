import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucky_money_app/common/constant/home_strings.dart';

import 'package:lucky_money_app/common/constant/image_constants.dart';
import 'package:lucky_money_app/common/widgets/box_shadow.dart';
import 'package:lucky_money_app/providers/auth_provider.dart';
// import 'package:lucky_money_app/repo/secure_storage_service.dart';

class HomeContent extends ConsumerWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncUser = ref.watch(userProvider); // слухаємо користувача

    final theme = Theme.of(context);

    return asyncUser.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (_, __) => const Center(child: Text('Помилка')),
      data: (result) {
        // if (!result.isSuccess) {
        //   // Тут обробляємо помилку
        //   final message = result.error?.message ?? 'Невідома помилка';
        //   WidgetsBinding.instance.addPostFrameCallback((_) {
        //     ScaffoldMessenger.of(context).showSnackBar(
        //       SnackBar(
        //         behavior: SnackBarBehavior.floating,
        //         content: Text(message),
        //       ),
        //     );
        //   });

        //   // return const Center(child: Text('Будь ласка, авторизуйтесь'));
        // }
        final isAuthenticated = result.isSuccess;

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(homeTitle, style: theme.textTheme.titleLarge),
              const SizedBox(height: 8),
              Text(homeSubtitle, style: theme.textTheme.titleMedium),
              const SizedBox(height: 24),
              Center(
                child: SizedBox(
                  width: 256,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(32),
                      boxShadow: containerShadow,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(24),
                            child: Image.asset(gameLogo, fit: BoxFit.cover),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 12,
                            ),
                            child: SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                onPressed: isAuthenticated
                                    ? () {
                                        Navigator.pushNamed(
                                          context,
                                          '/my-gane',
                                        );
                                      }
                                    : null,
                                child: const Text(homeLabelBtn),
                              ),
                            ),
                          ),
                          const Text(
                            homeLabelCard,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
