import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucky_money_app/providers/bottom_nav_index_provider.dart';

class HomeBottomNavWidget extends ConsumerWidget {
  const HomeBottomNavWidget({super.key, required this.setIndexPage});
  final void Function(int i) setIndexPage;

  @override
  Widget build(BuildContext context, ref) {
    final theme = Theme.of(context);
    final indexState = ref.watch(bottomNavProvider);
    final List<IconData> iconList = [
      Icons.notifications_active_outlined,
      Icons.home_outlined,
    ];
    return AnimatedBottomNavigationBar(
      backgroundColor: theme.colorScheme.primary,
      activeColor: theme.colorScheme.secondary,
      // activeColor: theme.colorScheme.onPrimary,
      scaleFactor: 2,
      inactiveColor: Colors.white.withValues(alpha: .7),
      icons: iconList,
      activeIndex: indexState,
      gapLocation: GapLocation.center,
      notchSmoothness: NotchSmoothness.softEdge,
      leftCornerRadius: 32,
      rightCornerRadius: 32,
      onTap: setIndexPage,
    );
  }
}
