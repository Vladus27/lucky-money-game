import 'package:flutter/material.dart';
import 'package:lucky_money_app/router/router.dart';
import 'package:lucky_money_app/theme/theme.dart';

class LuckyMoneyApp extends StatelessWidget {
  const LuckyMoneyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'LuckyMoney', theme: casinoTheme, routes: routes);
  }
}
