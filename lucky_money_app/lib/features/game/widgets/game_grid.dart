import 'package:flutter/material.dart';

class GameGrid extends StatelessWidget {
  const GameGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        border: BoxBorder.all(width: 8, color: theme.colorScheme.secondary),
        color: theme.colorScheme.onSurface,
      ),

      child: GridView.builder(
        padding: const EdgeInsets.all(16),
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),

        itemCount: 9,

        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, // 3 колонки
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: 1, //  квадрат
        ),
        itemBuilder: (context, index) {
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: index == 6
                  ? theme.colorScheme.secondary
                  : theme.colorScheme.surface.withValues(alpha: .1),
            ),
            alignment: Alignment.center,

            child: Text(
              '${index + 1}',
              style: const TextStyle(color: Colors.white, fontSize: 20),
            ),
          );
        },
      ),
    );
  }
}
