import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:the_quote/core/l10n/locale_keys.g.dart';
import 'package:the_quote/features/home/presentation/page/home_page.dart';
import 'package:the_quote/features/search/presentation/search_page.dart';
import 'package:the_quote/features/settings/presentation/settings_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int selectedPageIndex = 0;

  void onSelectedPageIndexChange(int index) {
    setState(() {
      selectedPageIndex = index;
    });
  }

  final pages = const [HomePage(), SearchPage(), SettingsPage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[selectedPageIndex],
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: onSelectedPageIndexChange,
        selectedIndex: selectedPageIndex,
        destinations: [
          NavigationDestination(icon: const Icon(Icons.home), label: LocaleKeys.home.tr()),
          NavigationDestination(
            icon: const Icon(Icons.search),
            label: LocaleKeys.search.tr(),
          ),
          NavigationDestination(
            icon: const Icon(Icons.settings),
            label: LocaleKeys.settings.tr(),
          ),
        ],
      ),
    );
  }
}
