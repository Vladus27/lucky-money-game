import 'package:flutter_riverpod/flutter_riverpod.dart';

class BetValidationResult {
  final bool isValid;
  final String? error;

  const BetValidationResult.valid() : isValid = true, error = null;

  const BetValidationResult.invalid(this.error) : isValid = false;
}

class BetValidator extends Notifier<BetValidationResult> {
  static const double minBet = 1;

  @override
  BetValidationResult build() {
    return const BetValidationResult.invalid(null);
  }

  void updateValidation(double? bet, double currentBalance) {
    state = validate(bet, currentBalance);
  }

  BetValidationResult validate(double? bet, double currentBalance) {
    if (bet == null) {
      return const BetValidationResult.invalid('Введи суму ставки');
    }

    if (bet < minBet) {
      return const BetValidationResult.invalid('Мінімальна ставка — $minBet');
    }

    if (bet > currentBalance) {
      return const BetValidationResult.invalid('Недостатньо коштів');
    }

    return const BetValidationResult.valid();
  }
}

final betValidatorProvider =
    NotifierProvider<BetValidator, BetValidationResult>(BetValidator.new);
