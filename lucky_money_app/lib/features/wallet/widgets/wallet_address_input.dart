import 'package:flutter/material.dart';
import 'package:lucky_money_app/common/constant/wallet_strings.dart';

class WalletAddressInput extends StatefulWidget {
  const WalletAddressInput({
    super.key,
    required this.userAddressInputLabel,
    required this.userAddressInputHint,
  });
  final String userAddressInputLabel;
  final String userAddressInputHint;

  @override
  State<WalletAddressInput> createState() => _WalletAddressInputState();
}

class _WalletAddressInputState extends State<WalletAddressInput> {
  final TextEditingController _walletController = TextEditingController();
  final FocusNode _addressFocus = FocusNode();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _walletController.dispose();
    _addressFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Form(
      key: _formKey,
      child: TextFormField(
        focusNode: _addressFocus,
        controller: _walletController,
        validator: validateEvmAddress,
        style: TextStyle(color: theme.colorScheme.onPrimary),
        decoration: InputDecoration(
          hintText: userAddressInputHint,
          labelText: userAddressInputLabel,

          suffixIcon: IconButton(
            icon: const Icon(Icons.playlist_add_outlined),
            onPressed: () {
              final bool isValid = _formKey.currentState?.validate() ?? false;

              if (isValid) {
                debugPrint('Адреса валідна: ${_walletController.text}');
                _addressFocus.unfocus();
              } else {
                debugPrint('Помилка валідації');
              }
            },
          ),
          hintStyle: TextStyle(
            color: theme.colorScheme.onPrimary.withValues(alpha: .5),
          ),

          labelStyle: const TextStyle(color: Colors.white),
          filled: true,
          fillColor: theme.colorScheme.onTertiaryContainer,
          errorStyle: TextStyle(
            color: theme.colorScheme.secondary,
            fontSize: 12,
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: theme.colorScheme.secondary),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: theme.colorScheme.secondary),
          ),

          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: theme.colorScheme.onSurface),
          ),

          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: theme.colorScheme.onSurface),
          ),
        ),
      ),
    );
  }

  String? validateEvmAddress(String? value) {
    if (value == null || value.isEmpty) {
      return 'Введи адресу гаманця';
    }

    final regExp = RegExp(r'^0x[a-fA-F0-9]{40}$');

    if (!regExp.hasMatch(value)) {
      return 'Невірний формат адреси гаманця';
    }

    return null;
  }
}
