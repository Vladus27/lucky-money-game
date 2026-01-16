import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucky_money_app/common/constant/image_constants.dart';
import 'package:lucky_money_app/features/home/widgets/home_header_guest.dart';
import 'package:lucky_money_app/features/home/widgets/home_header_logged.dart';
import 'package:lucky_money_app/providers/user_provider.dart';

class HomeHeader extends ConsumerWidget implements PreferredSizeWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncUser = ref.watch(userProvider);

    late Widget userAction;

    asyncUser.when(
      loading: () => userAction = const SizedBox(),
      error: (_, __) => userAction = const HomeHeaderGuest(),
      data: (result) {
        userAction = (result.isSuccess)
            ? const HomeHeaderLogged()
            : const HomeHeaderGuest();
      },
    );

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
