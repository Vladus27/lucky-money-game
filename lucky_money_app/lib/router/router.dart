import 'package:flutter/material.dart';

import 'package:lucky_money_app/common/models/authentication_copy.dart';
import 'package:lucky_money_app/features/authentication/view/authentication_screen.dart';
import 'package:lucky_money_app/features/history/view/history_screen.dart';
import 'package:lucky_money_app/features/home/view/home_screen.dart';
import 'package:lucky_money_app/features/wallet/view/wallet_new_sceen.dart';

final Map<String, Widget Function(BuildContext)> routes = {
  '/': (ctx) => const HomeScreen(),
  '/auth-login': (ctx) =>
      const AuthenticationScreen(initialMode: AuthMode.login),
  '/auth-register': (ctx) =>
      const AuthenticationScreen(initialMode: AuthMode.register),
  '/wallet': (ctx) => const WalletScreen(),
  '/notif': (ctx) => const HistoryScreen(),
};
