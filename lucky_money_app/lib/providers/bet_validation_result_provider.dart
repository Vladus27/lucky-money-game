import 'package:flutter_riverpod/flutter_riverpod.dart';

class BetValidationResult {
  final bool isValid;
  final String? error;

  const BetValidationResult.valid() : isValid = true, error = null;

  const BetValidationResult.invalid(this.error) : isValid = false;
}

class BetValidator extends Notifier<BetValidationResult> {
  late final int balance;
  static const int minBet = 5;

  @override
  BetValidationResult build() {
    balance = 70; // ⚠️ у майбутньому з іншого провайдера
    return const BetValidationResult.invalid(null);
  }

  void updateValidation(int? bet) {
    state = validate(bet);
  }

  BetValidationResult validate(int? bet) {
    if (bet == null) {
      return const BetValidationResult.invalid('Введи суму ставки');
    }

    if (bet < minBet) {
      return const BetValidationResult.invalid('Мінімальна ставка — $minBet');
    }

    if (bet > balance) {
      return const BetValidationResult.invalid('Недостатньо коштів');
    }

    return const BetValidationResult.valid();
  }
}

final betValidatorProvider =
    NotifierProvider<BetValidator, BetValidationResult>(BetValidator.new);
