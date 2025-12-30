import 'package:flutter/material.dart';

import 'package:lucky_money_app/common/constant/image_constants.dart'
    show appLogo;
import 'package:lucky_money_app/common/constant/register_strings.dart';

class AuthenticationScreen extends StatefulWidget {
  const AuthenticationScreen({super.key});

  @override
  State<AuthenticationScreen> createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text(registerAppBarTitle),
        actions: [Image.asset(appLogo), const SizedBox(width: 28)],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 28.0, vertical: 24),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(registerLabel, style: theme.textTheme.titleLarge),
            const SizedBox(height: 48),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 24.0),
              child: Container(
                decoration: BoxDecoration(
                  color: theme.colorScheme.onPrimary,
                  borderRadius: BorderRadius.circular(24),
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
                child: Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Text(
                          'Заповни усі поля',
                          style: theme.textTheme.titleMedium,
                        ),
                        SizedBox(height: 12),
                        TextFormField(
                          decoration: InputDecoration(
                            icon: const Icon(Icons.person_outline_outlined),

                            labelText: registerUsername,
                            // hintText: 'hint',
                            filled: true,
                            fillColor: theme.colorScheme.surfaceContainer,
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color: theme.colorScheme.onPrimary,
                              ),
                            ),

                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color: theme.colorScheme.primary,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),
                        TextFormField(
                          decoration: InputDecoration(
                            icon: const Icon(Icons.password_outlined),

                            labelText: registerPassword,
                            // hintText: 'hint',
                            filled: true,
                            fillColor: theme.colorScheme.surfaceContainer,
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color: theme.colorScheme.onPrimary,
                              ),
                            ),

                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color: theme.colorScheme.primary,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 24),

                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {},
                            child: Text('Зареєструватися'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const Text(registerQuestion),
            TextButton(onPressed: () {}, child: Text('Увійти')),
          ],
        ),
      ),
    );
  }
}
