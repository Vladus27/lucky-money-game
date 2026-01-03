import 'package:flutter/material.dart';

import 'package:lucky_money_app/features/wallet/widgets/wallet_header.dart';
import 'package:lucky_money_app/common/constant/image_constants.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  final TextEditingController _walletController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: const WalletHeader(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              // height: 350,
              width: double.infinity,
              decoration: BoxDecoration(
                color: theme.colorScheme.primary,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(48),
                  bottomRight: Radius.circular(48),
                ),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    theme.colorScheme.primary,
                    theme.colorScheme.onSurface,
                    // theme.colorScheme.onSurface.withValues(alpha: 0.9),
                  ],
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(appLogo, height: 48, fit: BoxFit.contain),
                          const SizedBox(width: 8),

                          Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Привіт,',
                                style: TextStyle(color: Colors.white),
                              ),
                              Text(
                                '@VladGamler',
                                style: theme.textTheme.titleMedium!.copyWith(
                                  fontWeight: FontWeight.w700,
                                  color: theme.colorScheme.surface,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(width: 12),
                        ],
                      ),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Крок 1. З'єднання",
                          style: theme.textTheme.labelLarge!.copyWith(
                            color: theme.colorScheme.surface.withValues(
                              alpha: .8,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Введи адресу гаманця, з якого будеш здійснювати поповнення',
                            style: theme.textTheme.bodyMedium!.copyWith(
                              color: theme.colorScheme.onPrimary.withValues(
                                alpha: .9,
                              ),
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ),
                      ],
                    ),
                    TextFormField(
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
                          color: theme.colorScheme.onPrimary.withValues(
                            alpha: .5,
                          ),
                        ),

                        labelStyle: const TextStyle(color: Colors.white),
                        filled: true,
                        fillColor: theme.colorScheme.onTertiaryContainer,

                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                            color: theme.colorScheme.onSurface,
                          ),
                        ),

                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                            color: theme.colorScheme.onSurface,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      "Крок 2. Отримання токенів",
                      style: theme.textTheme.labelLarge!.copyWith(
                        color: theme.colorScheme.surface.withValues(alpha: .8),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: theme.colorScheme.onPrimaryContainer,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12.0,
                          vertical: 8.0,
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                  height: 24,
                                  width: 24,
                                  decoration: BoxDecoration(
                                    color: theme.colorScheme.primary,
                                    borderRadius: BorderRadius.circular(32),
                                  ),
                                  child: Center(
                                    child: Text(
                                      '1',
                                      style: theme.textTheme.labelLarge,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Flexible(
                                  child: Text(
                                    'Натисни кнопку нижче, щоб відкрити official faucet',
                                    style: theme.textTheme.bodyMedium!.copyWith(
                                      color: theme.colorScheme.onPrimary
                                          .withValues(alpha: .9),
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              width: double.infinity,
                              child: OutlinedButton.icon(
                                onPressed: () {},
                                label: const Text('Open Faucet'),
                                icon: const Icon(Icons.link),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      "Крок 3. Поповнити баланс",
                      style: theme.textTheme.labelLarge!.copyWith(
                        color: theme.colorScheme.surface.withValues(alpha: .8),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: theme.colorScheme.onPrimaryContainer,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12.0,
                          vertical: 8.0,
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                  height: 24,
                                  width: 24,
                                  decoration: BoxDecoration(
                                    color: theme.colorScheme.primary,
                                    borderRadius: BorderRadius.circular(32),
                                  ),
                                  child: Center(
                                    child: Text(
                                      '2',
                                      style: theme.textTheme.labelLarge,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Flexible(
                                  child: Text(
                                    'Надішли отриманні токени за адресою нижче',
                                    style: theme.textTheme.bodyMedium!.copyWith(
                                      color: theme.colorScheme.onPrimary
                                          .withValues(alpha: .9),
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: theme.colorScheme.secondary,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12.0,
                                  vertical: 2,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Treasury Address (Sepolia)',
                                          style: theme.textTheme.bodySmall,
                                        ),
                                        Text(
                                          '0x742d...44e',
                                          style: theme.textTheme.bodyMedium!
                                              .copyWith(
                                                fontWeight: FontWeight.bold,
                                              ),
                                        ),
                                      ],
                                    ),
                                    IconButton(
                                      onPressed: () {},
                                      icon: const Icon(Icons.copy_rounded),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 32),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 70,
                    width: 150,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withValues(alpha: 0.5),
                          spreadRadius: 0,
                          blurRadius: 4,
                          offset: const Offset(0, 4),
                        ),
                        BoxShadow(
                          color: Colors.grey.withValues(alpha: 0.5),
                          spreadRadius: 0,
                          blurRadius: .8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Container(
                          width: double.infinity,
                          // padding: const EdgeInsets.symmetric(vertical: 8),
                          decoration: BoxDecoration(
                            color: theme.colorScheme.primary,
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(12),
                            ),
                          ),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Text(
                                'БАЛАНС',
                                style: theme.textTheme.labelLarge,
                              ),
                            ),
                          ),
                        ),
                        const Center(
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text('1500.00 WBT'),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 70,
                    width: 150,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withValues(alpha: 0.5),
                          spreadRadius: 0,
                          blurRadius: 4,
                          offset: const Offset(0, 4),
                        ),
                        BoxShadow(
                          color: Colors.grey.withValues(alpha: 0.5),
                          spreadRadius: 0,
                          blurRadius: .8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Container(
                          width: double.infinity,
                          // padding: const EdgeInsets.symmetric(vertical: 8),
                          decoration: BoxDecoration(
                            color: theme.colorScheme.secondary,
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(12),
                            ),
                          ),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Text(
                                'У ГРІ',
                                style: theme.textTheme.labelLarge!.copyWith(
                                  color: theme.colorScheme.onSurface,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const Center(
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text('comming soon...'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
