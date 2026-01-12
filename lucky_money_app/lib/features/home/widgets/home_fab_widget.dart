import 'package:flutter/material.dart';
import 'package:lucky_money_app/services/secure_storage_service.dart';

class HomeFabWidget extends StatelessWidget {
  const HomeFabWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final storage = SecureStorageService();
    return FutureBuilder(
      future: storage.getToken(),
      builder: (context, asyncSnapshot) {
        final isAuthenticated = asyncSnapshot.data != null;
        return FloatingActionButton(
          onPressed: isAuthenticated
              ? () {
                  Navigator.pushNamed(context, '/game');
                }
              : null,
          child: const Icon(Icons.wallet_rounded),
        );
      },
    );
  }
}
