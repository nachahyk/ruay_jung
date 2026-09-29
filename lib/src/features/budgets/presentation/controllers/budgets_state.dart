import 'package:equatable/equatable.dart';

import 'package:ruay_jung/src/features/budgets/domain/entities/budget.dart';

enum BudgetsStatus { initial, loading, loaded, error }

enum BudgetsActionStatus { idle, saving, failure }

class BudgetsState extends Equatable {
  const BudgetsState({
    this.status = BudgetsStatus.initial,
    this.month,
    this.budgets = const [],
    this.error,
    this.actionStatus = BudgetsActionStatus.idle,
    this.actionError,
  });

  final BudgetsStatus status;
  final DateTime? month;
  final List<Budget> budgets;
  final String? error;
  final BudgetsActionStatus actionStatus;
  final String? actionError;

  double? forCategory(String categoryId) {
    for (final budget in budgets) {
      if (budget.categoryId == categoryId) return budget.amount;
    }
    return null;
  }

  BudgetsState copyWith({
    BudgetsStatus? status,
    DateTime? month,
    List<Budget>? budgets,
    String? error,
    bool clearError = false,
    BudgetsActionStatus? actionStatus,
    String? actionError,
    bool clearActionError = false,
  }) {
    return BudgetsState(
      status: status ?? this.status,
      month: month ?? this.month,
      budgets: budgets ?? this.budgets,
      error: clearError ? null : (error ?? this.error),
      actionStatus: actionStatus ?? this.actionStatus,
      actionError: clearActionError ? null : (actionError ?? this.actionError),
    );
  }

  @override
  List<Object?> get props => [status, month, budgets, error, actionStatus, actionError];
}
