import 'package:flutter/material.dart';
import 'package:lucky_money_app/common/constant/image_constants.dart';

class HomeHeader extends StatelessWidget implements PreferredSizeWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    String text = 'VladGamblerasdsdsdsdsdsdda';
    String truncate(String text, int length) {
      return text.length > length ? '${text.substring(0, length)}…' : text;
    }

    bool isLogined = 1 == 1;
    Widget content = isLogined
        ? Padding(
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
                          truncate(text, 15),
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.labelLarge,
                        ),
                        Row(
                          children: [
                            Text(
                              truncate('0.023423424234230', 14),
                              style: theme.textTheme.labelSmall,
                            ),
                            const SizedBox(width: 8),
                            Text('WBT', style: theme.textTheme.labelMedium),
                          ],
                        ),
                      ],
                    ),
                    // SizedBox(width: 8),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.logout),
                    ),
                  ],
                ),
              ),
            ),
          )
        : Row(
            children: [
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/auth-login');
                },
                child: const Text('Увійти'),
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/auth-register');
                },
                child: const Text('Реєстрація'),
              ),
              const SizedBox(width: 12),
            ],
          );

    return AppBar(
      toolbarHeight: kToolbarHeight + 42,
      leadingWidth: 96,
      leading: Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: const EdgeInsets.only(left: 12.0),
          child: Image.asset(
            appLogo,
            height: double.infinity,
            fit: BoxFit.contain,
          ),
        ),
      ),
      actions: [content],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 42);
}
