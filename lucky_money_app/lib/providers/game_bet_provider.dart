import 'package:flutter_riverpod/flutter_riverpod.dart';

class GameBetNotifier extends Notifier<double> {
  @override
  double build() => 0;

  void setBet(double bet) {
    state = bet;
    // print('betNotifier state is now $state');
  }

  bool isBetSelected(int bet) {
    return state == bet;
  }
}

final gameBetProvider = NotifierProvider<GameBetNotifier, double>(
  GameBetNotifier.new,
);
