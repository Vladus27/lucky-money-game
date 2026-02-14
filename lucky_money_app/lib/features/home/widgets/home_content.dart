import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:lucky_money_app/common/constant/home_strings.dart';
import 'package:lucky_money_app/features/home/widgets/home_content_card.dart';
import 'package:lucky_money_app/providers/user_provider.dart';

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
        final isAuthenticated = result.isSuccess;

        return LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: Padding(
                  padding: const EdgeInsets.all(28),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(homeTitle, style: theme.textTheme.titleLarge),
                      const SizedBox(height: 8),
                      Text(homeSubtitle, style: theme.textTheme.titleMedium),
                      const SizedBox(height: 24),
                      Center(
                        child: SizedBox(
                          width: 256,
                          child: HomeContentCard(
                            isAuthenticated: isAuthenticated,
                          ),
                        ),
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
