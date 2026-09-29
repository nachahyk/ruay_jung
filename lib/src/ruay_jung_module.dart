import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:core_infra/core_infra.dart';
import 'package:jung_studio_auth/jung_studio_auth.dart';

import 'core/widgets/main_shell.dart';
import 'core/widgets/rj_theme.dart';
import 'features/accounts/presentation/pages/accounts_page.dart';
import 'features/budgets/presentation/pages/budgets_page.dart';
import 'features/transactions/presentation/pages/overview_page.dart';
import 'features/transactions/presentation/pages/transaction_form_page.dart';
import 'features/transactions/presentation/pages/transactions_list_page.dart';
import 'routes/app_routes.dart';

/// Ruay Jung's [AppModule] implementation — the personal-finance mini-app.
///
/// Namespaced under `/ruay-jung`. Same as Tiaw Jung: a light/dark adaptive
/// "passbook" theme applied per-route via [RjTheme].
///
/// Financial data is private per-user (no group/membership concept), so
/// every route just requires sign-in, same reasoning as Tiaw Jung.
class RuayJungModule implements AppModule {
  RuayJungModule({required this.authCubit});

  final AuthCubit authCubit;

  @override
  String get id => 'ruay_jung';

  @override
  String get displayName => 'Ruay Jung';

  @override
  IconData get icon => Icons.savings_outlined;

  @override
  String get entryPath => AppRoutes.overview;

  String? _requireSignedIn(BuildContext context, GoRouterState state) {
    return authCubit.state is AuthAuthenticated ? null : '/login';
  }

  @override
  List<RouteBase> get routes => [
        GoRoute(
          path: AppRoutes.transactionNew,
          redirect: _requireSignedIn,
          builder: (context, state) => const RjTheme(child: TransactionFormPage()),
        ),
        GoRoute(
          path: AppRoutes.transactionEditPath,
          redirect: _requireSignedIn,
          builder: (context, state) => RjTheme(
            child: TransactionFormPage(transactionId: state.pathParameters['id']),
          ),
        ),
        StatefulShellRoute.indexedStack(
          builder: (context, state, navigationShell) => RjTheme(
            child: MainShell(navigationShell: navigationShell),
          ),
          branches: [
            StatefulShellBranch(routes: [
              GoRoute(path: AppRoutes.overview, redirect: _requireSignedIn, builder: (context, state) => const OverviewPage()),
            ]),
            StatefulShellBranch(routes: [
              GoRoute(path: AppRoutes.transactions, redirect: _requireSignedIn, builder: (context, state) => const TransactionsListPage()),
            ]),
            StatefulShellBranch(routes: [
              GoRoute(path: AppRoutes.budgets, redirect: _requireSignedIn, builder: (context, state) => const BudgetsPage()),
            ]),
            StatefulShellBranch(routes: [
              GoRoute(path: AppRoutes.accounts, redirect: _requireSignedIn, builder: (context, state) => const AccountsPage()),
            ]),
          ],
        ),
      ];

  @override
  Future<void> initialize() async {}

  @override
  Future<void> dispose() async {}
}
