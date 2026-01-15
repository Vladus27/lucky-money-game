import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucky_money_app/providers/user_provider.dart';

class HomeFabWidget extends ConsumerWidget {
  const HomeFabWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAsync = ref.watch(userProvider);
    final isAuthenticated = userAsync.hasValue && userAsync.value!.isSuccess;
    return FloatingActionButton(
      onPressed: isAuthenticated
          ? () {
              Navigator.pushNamed(context, '/wallet');
            }
          : null,
      child: const Icon(Icons.wallet_rounded),
    );
  }
}
