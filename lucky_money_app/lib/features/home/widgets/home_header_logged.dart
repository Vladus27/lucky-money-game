import 'package:flutter/material.dart';

class HomeHeaderLogged extends StatelessWidget {
  const HomeHeaderLogged({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    String text = 'VladGamblerasdsdsdsdsdsdda';
    String balance = '0.023423424234230';
    String truncate(String text, int length) {
      return text.length > length ? '${text.substring(0, length)}…' : text;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: theme.colorScheme.onSurface,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2),
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
                        truncate(balance, 14),
                        style: theme.textTheme.labelSmall,
                      ),
                      const SizedBox(width: 8),
                      Text('WBT', style: theme.textTheme.labelMedium),
                    ],
                  ),
                ],
              ),

              IconButton(onPressed: () {}, icon: const Icon(Icons.logout)),
            ],
          ),
        ),
      ),
    );
  }
}
