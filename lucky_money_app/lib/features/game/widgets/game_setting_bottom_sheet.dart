import 'package:flutter/material.dart';
import 'package:lucky_money_app/features/game/widgets/game_setting_bet_labels.dart';
import 'package:lucky_money_app/features/game/widgets/game_setting_inputs.dart';

class GameSettingBottomSheet extends StatelessWidget {
  const GameSettingBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(32),
          topRight: Radius.circular(32),
        ),
      ),
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.only(
          left: 26.0,
          right: 26,
          top: 26,
          bottom: MediaQuery.of(context).viewInsets.bottom + 53,
        ),

        child: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            GameSettingBetLabels(),
            SizedBox(height: 12),
            GameSettingInputs(),
          ],
        ),
      ),
    );
  }
}
