import 'package:flutter/material.dart';
import 'package:lucky_money_app/features/game/widgets/game_bet_input.dart';
import 'package:lucky_money_app/features/game/widgets/game_button_start.dart';
import 'package:lucky_money_app/features/game/widgets/game_choice_bet.dart';

class GameSettingInputs extends StatefulWidget {
  const GameSettingInputs({super.key});

  @override
  State<GameSettingInputs> createState() => _GameSettingInputsState();
}

class _GameSettingInputsState extends State<GameSettingInputs> {
  final double balance = 70;
  double _minCount = 1.0;
  final List<int> bets = [10, 50, 100];
  late final TextEditingController _betController;

  @override
  void initState() {
    super.initState();
    _betController = TextEditingController();
  }

  @override
  void dispose() {
    _betController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,s
          children: bets.map((bet) {
            return Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: GameChoiceBet(
                  balance: balance,
                  bet: bet,
                  betController: _betController,
                ),
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 24),
        GameBetInput(betController: _betController),

        // TextFormField(
        //   // maxLength: 64,
        //   keyboardType: TextInputType.number,

        //   decoration: InputDecoration(
        //     icon: Icon(
        //       Icons.casino_outlined,
        //       color: theme.colorScheme.primary,
        //       size: 42,
        //     ),
        //     hintText: 'Введи свою ставку',
        //     labelText: 'Ставка',

        //     filled: true,
        //     fillColor: Theme.of(context).colorScheme.surfaceContainer,

        //     enabledBorder: OutlineInputBorder(
        //       borderRadius: BorderRadius.circular(12),
        //       borderSide: BorderSide(
        //         color: Theme.of(context).colorScheme.onPrimary,
        //       ),
        //     ),

        //     focusedBorder: OutlineInputBorder(
        //       borderRadius: BorderRadius.circular(12),
        //       borderSide: BorderSide(
        //         color: Theme.of(context).colorScheme.primary,
        //       ),
        //     ),
        //   ),
        // ),
        Slider(
          min: 1,
          max: 8,
          divisions: 7,
          value: _minCount,
          label: _minCount.toStringAsFixed(0),
          onChanged: (double val) {
            setState(() {
              _minCount = val;
            });
          },
        ),
        Text('Кількість мін: ${_minCount.toStringAsFixed(0)}'),

        const SizedBox(height: 24),
        const SizedBox(
          width: double.infinity,
          child: GameButtonStart(),

          //  OutlinedButton(
          //   onPressed: () {
          //     Navigator.pop(context);
          //   },
          //   child: const Text('ПОЧАТИ ГРУ'),
          // ),
        ),
        Text(
          'Перший множник: x1.47',
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }
}
