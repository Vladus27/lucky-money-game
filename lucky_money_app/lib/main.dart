import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:lucky_money_app/lucky_money_app.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_web_plugins/flutter_web_plugins.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setUrlStrategy(PathUrlStrategy());

  await dotenv.load();
  runApp(const ProviderScope(child: LuckyMoneyApp()));
}
