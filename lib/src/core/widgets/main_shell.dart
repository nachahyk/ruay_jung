import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:ruay_jung/l10n/app_localizations.dart';

/// Bottom-nav shell for Ruay Jung's four tabs — same
/// `StatefulShellRoute.indexedStack` shape as AimJung's `MainShell`, just
/// with a fixed tab set (no staff/customer split needed here).
class MainShell extends StatelessWidget {
  const MainShell({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: navigationShell.currentIndex,
        onTap: (index) => navigationShell.goBranch(index, initialLocation: index == navigationShell.currentIndex),
        items: [
          BottomNavigationBarItem(icon: const Icon(Icons.dashboard_outlined), label: l10n.navOverview),
          BottomNavigationBarItem(icon: const Icon(Icons.receipt_long_outlined), label: l10n.navTransactions),
          BottomNavigationBarItem(icon: const Icon(Icons.pie_chart_outline), label: l10n.navBudgets),
          BottomNavigationBarItem(icon: const Icon(Icons.account_balance_wallet_outlined), label: l10n.navAccounts),
        ],
      ),
    );
  }
}
