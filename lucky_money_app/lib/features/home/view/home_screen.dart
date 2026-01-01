import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucky_money_app/features/history/view/history_screen.dart';

import 'package:lucky_money_app/features/home/widgets/home_header.dart';
import 'package:lucky_money_app/features/home/widgets/home_bottom_nav_widget.dart';
import 'package:lucky_money_app/features/home/widgets/home_fab_widget.dart';
import 'package:lucky_money_app/features/home/widgets/home_content.dart';
import 'package:lucky_money_app/providers/bottom_nav_index_provider.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 1);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final indexNotifier = ref.read(bottomNavProvider.notifier);
    void setPage(int i) {
      indexNotifier.setIndex(i);
      _pageController.animateToPage(
        i,
        duration: const Duration(milliseconds: 150),
        curve: Curves.linear,
      );
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: const HomeHeader(),
      floatingActionButton: const HomeFabWidget(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      body: PageView(
        controller: _pageController,
        onPageChanged: indexNotifier.setIndex,

        children: const [HistoryScreen(), HomeContent()],
      ),

      bottomNavigationBar: HomeBottomNavWidget(setIndexPage: setPage),
    );
  }
}
