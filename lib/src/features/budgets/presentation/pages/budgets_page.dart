import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:ruay_jung/src/theme/app_colors.dart';
import 'package:ruay_jung/l10n/app_localizations.dart';
import 'package:ruay_jung/src/core/utils/formatters.dart';
import 'package:ruay_jung/src/features/categories/domain/entities/category.dart';
import 'package:ruay_jung/src/features/categories/presentation/controllers/categories_cubit.dart';
import 'package:ruay_jung/src/features/categories/presentation/controllers/categories_state.dart';
import 'package:ruay_jung/src/features/budgets/presentation/controllers/budgets_cubit.dart';
import 'package:ruay_jung/src/features/budgets/presentation/controllers/budgets_state.dart';

class BudgetsPage extends StatefulWidget {
  const BudgetsPage({super.key});

  @override
  State<BudgetsPage> createState() => _BudgetsPageState();
}

class _BudgetsPageState extends State<BudgetsPage> {
  late final DateTime _month;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    _month = DateTime(now.year, now.month, 1);
    context.read<CategoriesCubit>().loadCategories();
    context.read<BudgetsCubit>().loadBudgets(_month);
  }

  Future<void> _editBudget(Category category, double? current) async {
    final l10n = AppLocalizations.of(context)!;
    final controller = TextEditingController(text: current == null ? '' : current.toStringAsFixed(0));
    final amount = await showDialog<double>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(category.name),
        content: TextField(
          controller: controller,
          autofocus: true,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          decoration: InputDecoration(labelText: l10n.budgetsAmountLabel, prefixText: '฿ '),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.of(dialogContext).pop(), child: Text(l10n.commonCancel)),
          FilledButton(
            onPressed: () => Navigator.of(dialogContext).pop(double.tryParse(controller.text.trim())),
            child: Text(l10n.commonSave),
          ),
        ],
      ),
    );
    if (amount == null || !mounted) return;
    context.read<BudgetsCubit>().setBudget(categoryId: category.id, amount: amount);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final colors = AppColors.of(context);
    final categoriesState = context.watch<CategoriesCubit>().state;
    final budgetsState = context.watch<BudgetsCubit>().state;
    final isLoading = categoriesState.status == CategoriesStatus.loading || budgetsState.status == BudgetsStatus.loading;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.budgetsTitle),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          tooltip: l10n.navBackToSwitcher,
          onPressed: () => context.go('/'),
        ),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : categoriesState.expenseCategories.isEmpty
              ? Center(
                  child: Padding(
                    padding: const EdgeInsets.all(32),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.pie_chart_outline, size: 40, color: colors.onCoverMuted),
                        const SizedBox(height: 14),
                        Text(l10n.budgetsEmptyTitle, style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: colors.onCover)),
                        const SizedBox(height: 6),
                        Text(l10n.budgetsEmptyBody, textAlign: TextAlign.center, style: TextStyle(fontSize: 13, color: colors.onCoverMuted)),
                      ],
                    ),
                  ),
                )
              : ListView(
                  padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
                  children: [
                    Text(l10n.budgetsSubtitle, style: TextStyle(fontSize: 13, color: colors.onCoverMuted, height: 1.4)),
                    const SizedBox(height: 16),
                    Material(
                      color: colors.page,
                      borderRadius: BorderRadius.circular(16),
                      clipBehavior: Clip.antiAlias,
                      child: Column(
                        children: [
                          for (var i = 0; i < categoriesState.expenseCategories.length; i++) ...[
                            if (i > 0) Divider(height: 1, color: colors.pageLine),
                            Builder(builder: (context) {
                              final category = categoriesState.expenseCategories[i];
                              final amount = budgetsState.forCategory(category.id);
                              return ListTile(
                                title: Text(category.name, style: TextStyle(fontSize: 13.5, fontWeight: FontWeight.w600, color: colors.ink)),
                                trailing: Text(
                                  amount == null ? '—' : Formatters.baht(amount),
                                  style: TextStyle(fontSize: 13.5, fontWeight: FontWeight.w700, color: colors.ink),
                                ),
                                onTap: () => _editBudget(category, amount),
                              );
                            }),
                          ],
                        ],
                      ),
                    ),
                  ],
                ),
    );
  }
}
