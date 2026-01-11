import 'package:flutter_riverpod/flutter_riverpod.dart';

class GameBetNotifier extends Notifier<int> {
  @override
  int build() => 0;

  void setBet(int bet) {
    state = bet;
    print('betNotifier state is now $state');
  }

  bool isBetSelected(int bet) {
    return state == bet;
  }
}

final gameBetProvider = NotifierProvider<GameBetNotifier, int>(
  GameBetNotifier.new,
);
