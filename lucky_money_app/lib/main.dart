import 'package:flutter/material.dart';
import 'package:lucky_money_app/lucky_money_app.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ProviderScope(child: LuckyMoneyApp()));
}
