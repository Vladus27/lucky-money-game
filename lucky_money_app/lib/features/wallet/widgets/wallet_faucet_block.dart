import 'package:flutter/material.dart';

class WalletFaucetBlock extends StatelessWidget {
  const WalletFaucetBlock({
    super.key,
    required this.faucetLabel,
    required this.openLink,
  });
  final String faucetLabel;
  final void Function() openLink;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: openLink,
      label: const Text('Open Faucet'),
      icon: const Icon(Icons.link),
    );
  }
}
