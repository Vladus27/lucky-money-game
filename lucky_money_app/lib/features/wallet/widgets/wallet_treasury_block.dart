import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class WalletTreasuryBlock extends StatelessWidget {
  const WalletTreasuryBlock({
    super.key,
    required this.treasuryLabel,
    required this.treasuryAddress,
  });
  final String treasuryLabel;
  final String treasuryAddress;

  String _shortenAddress(
    String address, {
    int prefixLength = 6,
    int suffixLength = 4,
  }) {
    if (address.length <= prefixLength + suffixLength) return address;
    return '${address.substring(0, prefixLength)}...${address.substring(address.length - suffixLength)}';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    void showSnackBar() {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Андресу скопійовано!'),
              Text(
                treasuryAddress,
                style: TextStyle(color: theme.colorScheme.secondary),
              ),
            ],
          ),
        ),
      );
    }

    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.secondary,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 2),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(treasuryLabel, style: theme.textTheme.bodySmall),
                  Text(
                    _shortenAddress(treasuryAddress),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    softWrap: true,
                    style: theme.textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              onPressed: () async {
                await Clipboard.setData(ClipboardData(text: treasuryAddress));
                showSnackBar();
              },
              icon: const Icon(Icons.copy_rounded),
            ),
          ],
        ),
      ),
    );
  }
}
