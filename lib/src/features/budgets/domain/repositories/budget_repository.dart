import 'package:ruay_jung/src/features/budgets/domain/entities/budget.dart';

abstract class BudgetRepository {
  /// Every budget row set for [month] (normalized to the 1st).
  Future<List<Budget>> fetchBudgets(DateTime month);

  /// Creates the budget row for this category+month if none exists yet,
  /// otherwise updates the existing one — the UI only ever needs "set this
  /// category's budget to X," not a separate create/update decision.
  Future<Budget> setBudget({required String categoryId, required DateTime month, required double amount});
}
