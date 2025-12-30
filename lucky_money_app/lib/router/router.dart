import 'package:flutter/material.dart';
import 'package:lucky_money_app/features/authentication/view/authentication_screen.dart';
import 'package:lucky_money_app/features/home/view/home_screen.dart';

final Map<String, Widget Function(BuildContext)> routes = {
  '/': (ctx) => const AuthenticationScreen(),
  '/auth': (ctx) => const HomeScreen(), // temp home page
  '/wallet': (ctx) => const HomeScreen(), // temp home page
  '/notif': (ctx) => const HomeScreen(), // temp home page
};
