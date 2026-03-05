import 'package:go_router/go_router.dart';

import 'package:lucky_money_app/features/home/view/home_screen.dart';
import 'package:lucky_money_app/features/authentication/view/authentication_screen.dart';
import 'package:lucky_money_app/features/history/view/history_screen.dart';
import 'package:lucky_money_app/features/wallet/view/wallet_sceen.dart';
import 'package:lucky_money_app/features/game/view/example_game_screen.dart';
import 'package:lucky_money_app/features/game/view/game_screen.dart';
import 'package:lucky_money_app/common/models/authentication_copy.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
      routes: [
        GoRoute(
          path: 'auth-login',
          builder: (context, state) =>
              const AuthenticationScreen(initialMode: AuthMode.login),
        ),
        GoRoute(
          path: 'auth-register',
          builder: (context, state) =>
              const AuthenticationScreen(initialMode: AuthMode.register),
        ),
        GoRoute(
          path: 'wallet',
          builder: (context, state) => const WalletScreen(),
        ),
        GoRoute(
          path: 'notif',
          builder: (context, state) => const HistoryScreen(),
        ),
        GoRoute(
          path: 'game',
          builder: (context, state) => const ExampleGameScreen(),
        ),
        GoRoute(
          path: 'my-gane',
          builder: (context, state) => const GameScreen(),
        ),
      ],
    ),
  ],
);
