import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:ruay_jung/src/theme/app_colors.dart';
import 'package:ruay_jung/l10n/app_localizations.dart';
import 'package:ruay_jung/src/core/utils/formatters.dart';
import 'package:ruay_jung/src/features/budgets/presentation/controllers/budgets_cubit.dart';
import 'package:ruay_jung/src/features/budgets/presentation/controllers/budgets_state.dart';
import 'package:ruay_jung/src/features/categories/presentation/controllers/categories_cubit.dart';
import 'package:ruay_jung/src/features/categories/presentation/controllers/categories_state.dart';
import 'package:ruay_jung/src/features/transactions/presentation/controllers/transactions_cubit.dart';
import 'package:ruay_jung/src/features/transactions/presentation/controllers/transactions_state.dart';

/// The daily-driver screen — this month's income/expense/savings at a
/// glance, plus a live budget-vs-actual bar per expense category. Matches
/// the mock built in the approved "Ruay Jung" design artifact, now backed
/// by real data from three cubits at once.
class OverviewPage extends StatefulWidget {
  const OverviewPage({super.key});

  @override
  State<OverviewPage> createState() => _OverviewPageState();
}

class _OverviewPageState extends State<OverviewPage> {
  late final DateTime _month;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    _month = DateTime(now.year, now.month, 1);
    context.read<TransactionsCubit>().loadTransactions();
    context.read<CategoriesCubit>().loadCategories();
    context.read<BudgetsCubit>().loadBudgets(_month);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final colors = AppColors.of(context);
    final transactionsState = context.watch<TransactionsCubit>().state;
    final categoriesState = context.watch<CategoriesCubit>().state;
    final budgetsState = context.watch<BudgetsCubit>().state;

    final isLoading = transactionsState.status == TransactionsStatus.loading ||
        categoriesState.status == CategoriesStatus.loading ||
        budgetsState.status == BudgetsStatus.loading;

    final income = transactionsState.incomeInMonth(_month);
    final expense = transactionsState.expenseInMonth(_month);
    final saved = income - expense;
    final now = DateTime.now();
    final daysInMonth = DateTime(_month.year, _month.month + 1, 0).day;
    final daysLeft = (daysInMonth - now.day + 1).clamp(1, daysInMonth);
    final remainingBudget = budgetsState.budgets.fold(0.0, (sum, b) => sum + b.amount) - expense;
    final safeToSpendPerDay = remainingBudget > 0 ? remainingBudget / daysLeft : 0.0;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.overviewTitle),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          tooltip: l10n.navBackToSwitcher,
          onPressed: () => context.go('/'),
        ),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: () => Future.wait([
                context.read<TransactionsCubit>().loadTransactions(),
                context.read<BudgetsCubit>().loadBudgets(_month),
              ]),
              child: ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(Formatters.month(_month), style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: colors.onCover)),
                      Text(l10n.overviewDaysLeft(daysLeft), style: TextStyle(fontSize: 12.5, color: colors.onCoverMuted)),
                    ],
                  ),
                  const SizedBox(height: 16),
                  _StatGrid(income: income, expense: expense, saved: saved, safeToSpendPerDay: safeToSpendPerDay, l10n: l10n),
                  const SizedBox(height: 24),
                  Text(l10n.overviewBudgetSectionTitle, style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: colors.onCover)),
                  const SizedBox(height: 12),
                  if (categoriesState.expenseCategories.isEmpty || budgetsState.budgets.isEmpty)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: Text(l10n.overviewNoBudgets, style: TextStyle(color: colors.onCoverMuted)),
                    )
                  else
                    Container(
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(color: colors.page, borderRadius: BorderRadius.circular(18)),
                      child: Column(
                        children: [
                          for (final category in categoriesState.expenseCategories)
                            if (budgetsState.forCategory(category.id) != null)
                              Padding(
                                padding: const EdgeInsets.only(bottom: 14),
                                child: _BudgetRow(
                                  name: category.name,
                                  spent: transactionsState.spentOnCategoryInMonth(category.id, _month),
                                  budget: budgetsState.forCategory(category.id)!,
                                ),
                              ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
    );
  }
}

class _StatGrid extends StatelessWidget {
  const _StatGrid({required this.income, required this.expense, required this.saved, required this.safeToSpendPerDay, required this.l10n});

  final double income;
  final double expense;
  final double saved;
  final double safeToSpendPerDay;
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      childAspectRatio: 1.7,
      children: [
        _StatTile(label: l10n.overviewIncome, value: Formatters.baht(income), color: colors.emerald),
        _StatTile(label: l10n.overviewExpense, value: Formatters.baht(expense), color: colors.clay),
        _StatTile(label: l10n.overviewSaved, value: Formatters.baht(saved), color: saved >= 0 ? colors.emerald : colors.clay),
        _StatTile(label: l10n.overviewSafeToSpend, value: Formatters.baht(safeToSpendPerDay), color: colors.ink),
      ],
    );
  }
}

class _StatTile extends StatelessWidget {
  const _StatTile({required this.label, required this.value, required this.color});

  final String label;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(color: colors.pageCard, borderRadius: BorderRadius.circular(12), border: Border.all(color: colors.pageLine)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(label, style: TextStyle(fontSize: 11, color: colors.inkFaint, letterSpacing: 0.3)),
          const SizedBox(height: 6),
          Text(value, style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700, color: color)),
        ],
      ),
    );
  }
}

class _BudgetRow extends StatelessWidget {
  const _BudgetRow({required this.name, required this.spent, required this.budget});

  final String name;
  final double spent;
  final double budget;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final ratio = budget <= 0 ? 0.0 : (spent / budget).clamp(0.0, 1.5);
    final barColor = ratio >= 1 ? colors.clay : (ratio >= 0.85 ? colors.gold : colors.emerald);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(name, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: colors.ink)),
            Text(
              '${Formatters.baht(spent)} / ${Formatters.baht(budget)}',
              style: TextStyle(fontSize: 12, color: colors.inkMuted),
            ),
          ],
        ),
        const SizedBox(height: 6),
        ClipRRect(
          borderRadius: BorderRadius.circular(999),
          child: LinearProgressIndicator(
            value: ratio.clamp(0.0, 1.0),
            minHeight: 8,
            backgroundColor: colors.pageLine,
            valueColor: AlwaysStoppedAnimation(barColor),
          ),
        ),
      ],
    );
  }
}
