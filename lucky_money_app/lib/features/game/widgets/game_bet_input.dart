import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucky_money_app/common/widgets/number_input_formatter.dart';
import 'package:lucky_money_app/providers/bet_validation_result_provider.dart';
import 'package:lucky_money_app/providers/game_bet_provider.dart';
import 'package:lucky_money_app/providers/user_provider.dart';

class GameBetInput extends ConsumerStatefulWidget {
  const GameBetInput({super.key, required this.betController});

  final TextEditingController betController;
  @override
  ConsumerState<GameBetInput> createState() => _GameBetInputState();
}

class _GameBetInputState extends ConsumerState<GameBetInput> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.betController;

    _controller.addListener(() {
      final value = double.tryParse(_controller.text) ?? 0;
      ref.read(gameBetProvider.notifier).setBet(value);
      final asyncBalance = ref.watch(balanceProvider);
      final double currentBalance = asyncBalance.maybeWhen(
        data: (result) => double.tryParse(result.data ?? '0') ?? 0.0,
        orElse: () => 0.0,
      );
      // Валідуємо в реальному часі
      ref
          .read(betValidatorProvider.notifier)
          .updateValidation(value == 0 ? null : value, currentBalance);
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final validation = ref.watch(betValidatorProvider);

    return TextFormField(
      // maxLength: 64,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      controller: _controller,
      inputFormatters: [NumberInputFormatter()],

      decoration: InputDecoration(
        icon: Icon(
          Icons.casino_outlined,
          color: theme.colorScheme.primary,
          size: 42,
        ),
        hintText: 'Введи свою ставку',
        labelText: 'Ставка',
        helperText: 'мінімально: 1 WBT',
        errorText: validation.error,
        filled: true,
        fillColor: theme.colorScheme.surfaceContainer,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: theme.colorScheme.onPrimary),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: theme.colorScheme.primary),
        ),
      ),
    );
  }
}
