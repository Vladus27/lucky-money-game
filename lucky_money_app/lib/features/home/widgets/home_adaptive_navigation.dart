import 'package:flutter/material.dart';

class HomeAdaptiveNavigation extends StatelessWidget {
  final bool isMobile;
  final int index;
  final Function(int) onSelect;
  final Widget child;

  const HomeAdaptiveNavigation({
    super.key,
    required this.isMobile,
    required this.index,
    required this.onSelect,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    if (isMobile) return child;

    return Row(
      children: [
        NavigationRail(
          selectedIndex: index,
          onDestinationSelected: onSelect,
          labelType: NavigationRailLabelType.all,
          destinations: const [
            NavigationRailDestination(
              icon: Icon(Icons.history),
              label: Text('Історія'),
            ),
            NavigationRailDestination(
              icon: Icon(Icons.home),
              label: Text('Головна'),
            ),
          ],
        ),
        Expanded(child: child),
      ],
    );
  }
}
