import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ruay_jung/src/features/budgets/domain/repositories/budget_repository.dart';
import 'package:ruay_jung/src/features/budgets/presentation/controllers/budgets_state.dart';

class BudgetsCubit extends Cubit<BudgetsState> {
  BudgetsCubit(this._repository) : super(const BudgetsState());

  final BudgetRepository _repository;

  Future<void> loadBudgets(DateTime month) async {
    emit(state.copyWith(status: BudgetsStatus.loading, month: month, clearError: true));
    try {
      final budgets = await _repository.fetchBudgets(month);
      emit(state.copyWith(status: BudgetsStatus.loaded, budgets: budgets));
    } catch (error) {
      emit(state.copyWith(status: BudgetsStatus.error, error: error.toString()));
    }
  }

  Future<void> setBudget({required String categoryId, required double amount}) async {
    final month = state.month;
    if (month == null) return;
    emit(state.copyWith(actionStatus: BudgetsActionStatus.saving, clearActionError: true));
    try {
      final updated = await _repository.setBudget(categoryId: categoryId, month: month, amount: amount);
      final withoutOld = state.budgets.where((b) => b.categoryId != categoryId);
      emit(state.copyWith(actionStatus: BudgetsActionStatus.idle, budgets: [...withoutOld, updated]));
    } catch (error) {
      emit(state.copyWith(actionStatus: BudgetsActionStatus.failure, actionError: error.toString()));
    }
  }
}
