import 'package:flutter/material.dart';

class WalletHeader extends StatelessWidget implements PreferredSizeWidget {
  const WalletHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: kToolbarHeight + 42,

      title: const Padding(
        padding: EdgeInsets.only(right: 56.0),
        child: Center(child: Text('Каса', textAlign: TextAlign.center)),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 42);
}
