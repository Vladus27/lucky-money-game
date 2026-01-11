import 'package:flutter/material.dart';
import 'package:lucky_money_app/features/game/view/example_game_screen.dart';
import 'package:lucky_money_app/features/game/widgets/game_button_act.dart';
import 'package:lucky_money_app/features/game/widgets/game_grid.dart';
import 'package:lucky_money_app/features/game/widgets/game_setting_bottom_sheet.dart';
import 'package:lucky_money_app/features/game/widgets/game_stat_card.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  var _gameStatus = GameStatus.betting;
  final List<int> bets = [10, 50, 100];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(title: const Text('Lucky-money')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            const Row(
              children: [
                Expanded(
                  child: GameStatCard(
                    label: 'множник',
                    value: 'x10.0',
                    icon: Icons.trending_up,
                    isGradientNeeded: false,
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: GameStatCard(
                    label: 'виплата',
                    value: '100.00',
                    icon: Icons.account_balance_wallet,
                    isGradientNeeded: true,
                  ),
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 12),
              child: GameGrid(),
            ),
            GameButtonAct(gameStatus: _gameStatus, handleBet: _handleBet),
          ],
        ),
      ),
    );
  }

  void _handleBet() {
    if (_gameStatus == GameStatus.playing) {
      return _onCashout();
    } else {
      return _showBottomSheet();
    }
  }

  void _onCashout() {}

  void _showBottomSheet() {
    showModalBottomSheet<void>(
      barrierColor: Colors.black.withValues(alpha: 0.9),
      isScrollControlled: true,
      context: context,
      builder: (_) {
        return const GameSettingBottomSheet();
      },
    );
  }
}
