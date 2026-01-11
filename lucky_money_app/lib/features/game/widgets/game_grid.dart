import 'package:flutter/material.dart';
import 'package:lucky_money_app/common/models/game_model.dart';

class GameGrid extends StatefulWidget {
  const GameGrid({super.key});

  @override
  State<GameGrid> createState() => _GameGridState();
}

class _GameGridState extends State<GameGrid> {
  final status = GameStatus.playing;

  void _handleCellClick({required int idx}) {
    print('container taped by ${idx + 1} position');
    if (status != GameStatus.playing) return;
  }

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
          return GestureDetector(
            onTap: () => _handleCellClick(idx: index),
            child: Container(
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
            ),
          );
        },
      ),
    );
  }
}
