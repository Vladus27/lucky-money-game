import 'package:flutter/material.dart';

class WalletAddressInput extends StatefulWidget {
  const WalletAddressInput({super.key});

  @override
  State<WalletAddressInput> createState() => _WalletAddressInputState();
}

class _WalletAddressInputState extends State<WalletAddressInput> {
  final TextEditingController _walletController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _walletController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return TextFormField(
      controller: _walletController,
      style: TextStyle(color: theme.colorScheme.onPrimary),
      decoration: InputDecoration(
        hintText: 'oxdsf234...',
        labelText: 'Адреса гаманця',

        suffixIcon: IconButton(
          icon: const Icon(Icons.playlist_add_outlined),
          onPressed: () {},
        ),
        hintStyle: TextStyle(
          color: theme.colorScheme.onPrimary.withValues(alpha: .5),
        ),

        labelStyle: const TextStyle(color: Colors.white),
        filled: true,
        fillColor: theme.colorScheme.onTertiaryContainer,

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: theme.colorScheme.onSurface),
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: theme.colorScheme.onSurface),
        ),
      ),
    );
  }
}
