import 'package:flutter/material.dart';
import 'package:lucky_money_app/common/constant/image_constants.dart'
    show appLogo;

class AuthHeader extends StatelessWidget implements PreferredSizeWidget {
  const AuthHeader({super.key, required this.appBarTitle});
  final String appBarTitle;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: kToolbarHeight + 42,
      title: Text(appBarTitle),
      actions: [Image.asset(appLogo, width: 89), const SizedBox(width: 28)],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 42);
}
