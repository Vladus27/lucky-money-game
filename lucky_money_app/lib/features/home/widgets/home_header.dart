import 'package:flutter/material.dart';
import 'package:lucky_money_app/common/constant/image_constants.dart';
import 'package:lucky_money_app/features/home/widgets/home_header_guest.dart';
import 'package:lucky_money_app/features/home/widgets/home_header_logged.dart';

class HomeHeader extends StatelessWidget implements PreferredSizeWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    bool isLogined = 1 == 2;
    Widget userAction = isLogined
        ? const HomeHeaderLogged()
        : const HomeHeaderGuest();

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
      actions: [userAction],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 42);
}
