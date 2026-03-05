import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:lucky_money_app/features/game/widgets/game_bet_input.dart';
import 'package:lucky_money_app/features/game/widgets/game_button_start.dart';
import 'package:lucky_money_app/features/game/widgets/game_choice_bet.dart';
import 'package:lucky_money_app/providers/bet_validation_result_provider.dart';
import 'package:lucky_money_app/providers/game_provider.dart';
import 'package:lucky_money_app/providers/user_provider.dart';

class GameSettingInputs extends ConsumerStatefulWidget {
  const GameSettingInputs({super.key});

  @override
  ConsumerState<GameSettingInputs> createState() => _GameSettingInputsState();
}

const List<double> _firstMultipliers = [
  1.1025,
  1.26,
  1.47,
  1.764,
  2.205,
  2.94,
  4.41,
  8.82,
];

class _GameSettingInputsState extends ConsumerState<GameSettingInputs> {
  double _minCount = 1.0;
  double _firstMultiplier = 1.1025;
  final List<double> bets = [1, 5, 10];
  // bool _isLoading = false;

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

  Future<void> _onSubmit() async {
    // Отримуємо поточний баланс
    final asyncBalance = ref.read(balanceProvider);
    final double balance = asyncBalance.maybeWhen(
      data: (balanceResult) {
        if (balanceResult.isSuccess && balanceResult.data != null) {
          return double.tryParse(balanceResult.data!) ?? 0.0;
        }
        return 0.0;
      },
      orElse: () => 0.0,
    );

    // Парсимо введену ставку
    final double? betAmount = double.tryParse(_betController.text);

    // Валідуємо ставку
    final validator = ref.read(betValidatorProvider.notifier);
    final validationResult = validator.validate(betAmount, balance);
    validator.updateValidation(betAmount, balance);

    if (!validationResult.isValid) {
      // Показуємо помилку валідації
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            behavior: SnackBarBehavior.floating,
            content: Text(validationResult.error ?? 'Помилка валідації'),
            backgroundColor: Colors.red,
          ),
        );
      }
      return;
    }

    // Починаємо завантаження
    setState(() {
      // _isLoading = true;
    });

    try {
      // Викликаємо API для старту гри
      final success = await ref
          .read(gameNotifierProvider.notifier)
          .startGame(
            betAmount: betAmount!,
            minesCount: _minCount.toInt(),
            ref: ref,
          );

      if (!mounted) return;

      if (success) {
        // Успішний старт - закриваємо bottom sheet
        context.pop();

        // Показуємо успішне повідомлення
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.green,
            content: Text('🎮 Гру розпочато! Удачі!'),
            duration: Duration(seconds: 2),
          ),
        );
      } else {
        // Помилка від API
        final errorMessage = ref.read(gameNotifierProvider).value?.errorMessage;

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.red,
            content: Text(errorMessage ?? 'Не вдалося розпочати гру'),
          ),
        );
      }
    } finally {
      // Зупиняємо завантаження
      if (mounted) {
        setState(() {
          // _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final asyncBalance = ref.watch(balanceProvider);

    final double balance = asyncBalance.maybeWhen(
      data: (balanceResult) {
        if (balanceResult.isSuccess && balanceResult.data != null) {
          return double.tryParse(balanceResult.data!) ??
              0.0; // Конвертуємо String в double
        }
        return 0.0; // Якщо дані не успішні
      },
      orElse: () => 0.0, // Для loading/error використовуємо 0.0
    );

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
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
        Slider(
          min: 1,
          max: 8,
          divisions: 7,
          value: _minCount,
          label: _minCount.toStringAsFixed(0),
          onChanged: (double val) {
            setState(() {
              _minCount = val;
              _firstMultiplier = _firstMultipliers[val.toInt() - 1];
            });
          },
        ),
        Text('Кількість мін: ${_minCount.toStringAsFixed(0)}'),

        const SizedBox(height: 24),
        SizedBox(
          width: double.infinity,
          child: GameButtonStart(onSubmit: _onSubmit),
        ),
        Text(
          'Перший множник: x$_firstMultiplier',
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }
}
