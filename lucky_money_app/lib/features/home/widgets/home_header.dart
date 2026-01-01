import 'package:flutter/material.dart';
import 'package:lucky_money_app/common/constant/image_constants.dart';

class HomeHeader extends StatelessWidget implements PreferredSizeWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: kToolbarHeight + 42,
      leadingWidth: 96,
      leading: Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: const EdgeInsets.only(left: 12.0),
          child: Image.asset(
            appLogo,
            height: double.infinity,
            fit: BoxFit.contain,
          ),
        ),
      ),
      actions: [
        OutlinedButton(
          style: OutlinedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          onPressed: () {
            Navigator.pushNamed(context, '/auth-login');
          },
          child: const Text('Увійти'),
        ),
        const SizedBox(width: 8),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          onPressed: () {
            Navigator.pushNamed(context, '/auth-register');
          },
          child: const Text('Реєстрація'),
        ),
        const SizedBox(width: 12),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 42);
}
