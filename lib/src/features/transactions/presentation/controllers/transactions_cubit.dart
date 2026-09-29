import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ruay_jung/src/features/transactions/domain/entities/transaction.dart';
import 'package:ruay_jung/src/features/transactions/domain/repositories/transaction_repository.dart';
import 'package:ruay_jung/src/features/transactions/presentation/controllers/transactions_state.dart';

class TransactionsCubit extends Cubit<TransactionsState> {
  TransactionsCubit(this._repository) : super(const TransactionsState());

  final TransactionRepository _repository;

  Future<void> loadTransactions() async {
    emit(state.copyWith(status: TransactionsStatus.loading, clearError: true));
    try {
      final transactions = await _repository.fetchTransactions();
      emit(state.copyWith(status: TransactionsStatus.loaded, transactions: transactions));
    } catch (error) {
      emit(state.copyWith(status: TransactionsStatus.error, error: error.toString()));
    }
  }

  Future<void> addTransaction(Transaction transaction) async {
    emit(state.copyWith(actionStatus: TransactionsActionStatus.saving, clearActionError: true));
    try {
      final created = await _repository.createTransaction(transaction);
      emit(state.copyWith(actionStatus: TransactionsActionStatus.success, transactions: [created, ...state.transactions]));
    } catch (error) {
      emit(state.copyWith(actionStatus: TransactionsActionStatus.failure, actionError: error.toString()));
    }
  }

  Future<void> updateTransaction(Transaction transaction) async {
    emit(state.copyWith(actionStatus: TransactionsActionStatus.saving, clearActionError: true));
    try {
      final updated = await _repository.updateTransaction(transaction);
      emit(state.copyWith(
        actionStatus: TransactionsActionStatus.success,
        transactions: [for (final t in state.transactions) if (t.id == updated.id) updated else t],
      ));
    } catch (error) {
      emit(state.copyWith(actionStatus: TransactionsActionStatus.failure, actionError: error.toString()));
    }
  }

  Future<void> deleteTransaction(String id) async {
    emit(state.copyWith(actionStatus: TransactionsActionStatus.saving, clearActionError: true));
    try {
      await _repository.deleteTransaction(id);
      emit(state.copyWith(
        actionStatus: TransactionsActionStatus.success,
        transactions: [for (final t in state.transactions) if (t.id != id) t],
      ));
    } catch (error) {
      emit(state.copyWith(actionStatus: TransactionsActionStatus.failure, actionError: error.toString()));
    }
  }

  void resetActionStatus() => emit(state.copyWith(actionStatus: TransactionsActionStatus.idle));
}
