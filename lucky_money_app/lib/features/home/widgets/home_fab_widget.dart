import 'package:flutter/material.dart';

class HomeFabWidget extends StatelessWidget {
  const HomeFabWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Navigator.pushNamed(context, '/wallet');
      },
      child: const Icon(Icons.wallet_rounded),
    );
  }
}
