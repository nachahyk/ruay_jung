import 'package:equatable/equatable.dart';

import 'package:ruay_jung/src/features/categories/domain/entities/transaction_kind.dart';
import 'package:ruay_jung/src/features/transactions/domain/entities/transaction.dart';

enum TransactionsStatus { initial, loading, loaded, error }

enum TransactionsActionStatus { idle, saving, success, failure }

class TransactionsState extends Equatable {
  const TransactionsState({
    this.status = TransactionsStatus.initial,
    this.transactions = const [],
    this.error,
    this.actionStatus = TransactionsActionStatus.idle,
    this.actionError,
  });

  final TransactionsStatus status;
  final List<Transaction> transactions;
  final String? error;
  final TransactionsActionStatus actionStatus;
  final String? actionError;

  List<Transaction> inMonth(DateTime month) {
    return transactions
        .where((t) => t.occurredOn.year == month.year && t.occurredOn.month == month.month)
        .toList();
  }

  double totalForAccount(String accountId) {
    return transactions.where((t) => t.accountId == accountId).fold(0.0, (sum, t) => sum + t.signedAmount);
  }

  double incomeInMonth(DateTime month) =>
      inMonth(month).where((t) => t.kind == TransactionKind.income).fold(0.0, (sum, t) => sum + t.amount);

  double expenseInMonth(DateTime month) =>
      inMonth(month).where((t) => t.kind == TransactionKind.expense).fold(0.0, (sum, t) => sum + t.amount);

  double spentOnCategoryInMonth(String categoryId, DateTime month) => inMonth(month)
      .where((t) => t.categoryId == categoryId && t.kind == TransactionKind.expense)
      .fold(0.0, (sum, t) => sum + t.amount);

  TransactionsState copyWith({
    TransactionsStatus? status,
    List<Transaction>? transactions,
    String? error,
    bool clearError = false,
    TransactionsActionStatus? actionStatus,
    String? actionError,
    bool clearActionError = false,
  }) {
    return TransactionsState(
      status: status ?? this.status,
      transactions: transactions ?? this.transactions,
      error: clearError ? null : (error ?? this.error),
      actionStatus: actionStatus ?? this.actionStatus,
      actionError: clearActionError ? null : (actionError ?? this.actionError),
    );
  }

  @override
  List<Object?> get props => [status, transactions, error, actionStatus, actionError];
}
