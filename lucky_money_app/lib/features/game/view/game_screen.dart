import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucky_money_app/common/models/game/current_game.dart';
import 'package:lucky_money_app/common/models/game/game_model.dart';

import 'package:lucky_money_app/features/game/widgets/game_button_act.dart';
import 'package:lucky_money_app/features/game/widgets/game_error_state.dart';
import 'package:lucky_money_app/features/game/widgets/game_grid.dart';
import 'package:lucky_money_app/features/game/widgets/game_setting_bottom_sheet.dart';
import 'package:lucky_money_app/features/game/widgets/game_stat_card.dart';
import 'package:lucky_money_app/providers/game_provider.dart';
import 'package:lucky_money_app/providers/user_provider.dart';
import 'package:lucky_money_app/repo/game_repository.dart';

class GameScreen extends ConsumerStatefulWidget {
  const GameScreen({super.key});

  @override
  ConsumerState<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends ConsumerState<GameScreen> {
  final _game = GameRepository();
  bool _isLoading = false;
  Map<String, dynamic> isError = {'error': false, 'message': ''};
  GameStatus _gameStatus = GameStatus.cashedOut;
  CurrentGame? _currentGame;

  Future<void> _getCurrentGame() async {
    setState(() {
      _isLoading = true;
    });

    final currentGame = await _game.getCurrentGame();

    if (!currentGame.isSuccess) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            behavior: SnackBarBehavior.floating,
            content: Text(currentGame.error!.message),
          ),
        );
      });
      if (currentGame.error!.statusCode != 200) {
        setState(() {
          isError['error'] = true;
          isError['message'] = currentGame.error!.message;
          _isLoading = false;
        });
        return;
      }
    }

    if (currentGame.data == null) {
      setState(() {
        _gameStatus = GameStatus.cashedOut;
        _isLoading = false;
      });
      return;
    }

    _currentGame = currentGame.data;
    setState(() {
      _gameStatus = GameStatus.active;
      _isLoading = false;
    });
  }

  @override
  void initState() {
    _getCurrentGame();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(title: const Text('Lucky-money')),
      body: Padding(padding: const EdgeInsets.all(24.0), child: _content()),
    );
  }

  Widget _content() {
    if (isError['error']) {
      return GameErrorState(message: isError['message']);
    }
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: GameStatCard.multiplier(
                value: _currentGame?.currentMultiplier.toString(),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: GameStatCard.payOut(
                value: _currentGame?.currentPayoutAmount.toString(),
              ),
            ),
          ],
        ),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 12),
          child: GameGrid(),
        ),
        GameButtonAct(
          gameStatus: _gameStatus,
          nextCof: '_currentGame!.nextMultiplier.toString()',
          handleBet: _handleBet,
        ),
      ],
    );
  }

  void _handleBet() {
    if (_gameStatus == GameStatus.active) {
      _onCashout();
      return;
    } else {
      return _showBottomSheet();
    }
  }

  Future<void> _onCashout() async {
    var cashout = await _game.getCashout();
    ref.invalidate(balanceProvider);
    setState(() {
      _gameStatus = GameStatus.cashedOut;
    });
  }

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
