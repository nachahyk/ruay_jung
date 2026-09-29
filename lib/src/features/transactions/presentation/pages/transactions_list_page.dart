import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:ruay_jung/src/theme/app_colors.dart';
import 'package:ruay_jung/l10n/app_localizations.dart';
import 'package:ruay_jung/src/core/utils/formatters.dart';
import 'package:ruay_jung/src/routes/app_routes.dart';
import 'package:ruay_jung/src/features/categories/domain/entities/transaction_kind.dart';
import 'package:ruay_jung/src/features/categories/presentation/controllers/categories_cubit.dart';
import 'package:ruay_jung/src/features/transactions/domain/entities/transaction.dart';
import 'package:ruay_jung/src/features/transactions/presentation/controllers/transactions_cubit.dart';
import 'package:ruay_jung/src/features/transactions/presentation/controllers/transactions_state.dart';

class TransactionsListPage extends StatefulWidget {
  const TransactionsListPage({super.key});

  @override
  State<TransactionsListPage> createState() => _TransactionsListPageState();
}

class _TransactionsListPageState extends State<TransactionsListPage> {
  @override
  void initState() {
    super.initState();
    context.read<TransactionsCubit>().loadTransactions();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final colors = AppColors.of(context);
    final state = context.watch<TransactionsCubit>().state;
    final categories = context.watch<CategoriesCubit>().state.categories;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.transactionsTitle),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          tooltip: l10n.navBackToSwitcher,
          onPressed: () => context.go('/'),
        ),
      ),
      body: state.status == TransactionsStatus.loading
          ? const Center(child: CircularProgressIndicator())
          : state.status == TransactionsStatus.error
              ? Center(child: Text(state.error ?? l10n.transactionsLoadError, style: TextStyle(color: colors.onCoverMuted)))
              : state.transactions.isEmpty
                  ? _EmptyState(l10n: l10n)
                  : RefreshIndicator(
                      onRefresh: () => context.read<TransactionsCubit>().loadTransactions(),
                      child: ListView.builder(
                        physics: const AlwaysScrollableScrollPhysics(),
                        padding: const EdgeInsets.fromLTRB(20, 12, 20, 90),
                        itemCount: state.transactions.length,
                        itemBuilder: (context, index) {
                          final transaction = state.transactions[index];
                          final categoryName = categories
                              .where((c) => c.id == transaction.categoryId)
                              .map((c) => c.name)
                              .firstOrDefault('—');
                          return _TransactionRow(transaction: transaction, categoryName: categoryName);
                        },
                      ),
                    ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push(AppRoutes.transactionNew),
        icon: const Icon(Icons.add),
        label: const Text('Add'),
        shape: const StadiumBorder(),
      ),
    );
  }
}

extension _FirstOrDefault<T> on Iterable<T> {
  T firstOrDefault(T fallback) {
    for (final item in this) {
      return item;
    }
    return fallback;
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState({required this.l10n});

  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.receipt_long_outlined, size: 40, color: colors.onCoverMuted),
            const SizedBox(height: 14),
            Text(l10n.transactionsEmptyTitle, style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: colors.onCover)),
            const SizedBox(height: 6),
            Text(l10n.transactionsEmptyBody, textAlign: TextAlign.center, style: TextStyle(fontSize: 13, color: colors.onCoverMuted)),
          ],
        ),
      ),
    );
  }
}

class _TransactionRow extends StatelessWidget {
  const _TransactionRow({required this.transaction, required this.categoryName});

  final Transaction transaction;
  final String categoryName;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final isIncome = transaction.kind == TransactionKind.income;
    final color = isIncome ? colors.emerald : colors.clay;

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Material(
        color: colors.page,
        borderRadius: BorderRadius.circular(14),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: () => context.push(AppRoutes.transactionEdit(transaction.id)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            child: Row(
              children: [
                Container(
                  width: 34,
                  height: 34,
                  decoration: BoxDecoration(
                    color: isIncome ? colors.emeraldTint : colors.clayTint,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(isIncome ? Icons.arrow_upward : Icons.arrow_downward, size: 16, color: color),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(categoryName, style: TextStyle(fontSize: 13.5, fontWeight: FontWeight.w700, color: colors.ink)),
                      Text(Formatters.day(transaction.occurredOn), style: TextStyle(fontSize: 11.5, color: colors.inkMuted)),
                    ],
                  ),
                ),
                Text(
                  '${isIncome ? '+' : '-'}${Formatters.baht(transaction.amount)}',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: color),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
