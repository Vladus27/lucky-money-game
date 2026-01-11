import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final betInputControllerProvider = Provider.autoDispose<TextEditingController>((
  ref,
) {
  final controller = TextEditingController();

  // автоматично очистимо, коли провайдер буде знищено
  ref.onDispose(() {
    controller.dispose();
  });

  return controller;
});
