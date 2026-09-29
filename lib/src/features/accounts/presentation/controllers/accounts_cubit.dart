import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ruay_jung/src/features/accounts/domain/entities/account.dart';
import 'package:ruay_jung/src/features/accounts/domain/repositories/account_repository.dart';
import 'package:ruay_jung/src/features/accounts/presentation/controllers/accounts_state.dart';

class AccountsCubit extends Cubit<AccountsState> {
  AccountsCubit(this._repository) : super(const AccountsState());

  final AccountRepository _repository;

  Future<void> loadAccounts() async {
    emit(state.copyWith(status: AccountsStatus.loading, clearError: true));
    try {
      final accounts = await _repository.fetchAccounts();
      emit(state.copyWith(status: AccountsStatus.loaded, accounts: accounts));
    } catch (error) {
      emit(state.copyWith(status: AccountsStatus.error, error: error.toString()));
    }
  }

  Future<void> createAccount({required String name, required AccountType type}) async {
    emit(state.copyWith(actionStatus: AccountsActionStatus.saving, clearActionError: true));
    try {
      final account = await _repository.createAccount(name: name, type: type);
      emit(state.copyWith(actionStatus: AccountsActionStatus.success, accounts: [...state.accounts, account]));
    } catch (error) {
      emit(state.copyWith(actionStatus: AccountsActionStatus.failure, actionError: error.toString()));
    }
  }

  void resetActionStatus() => emit(state.copyWith(actionStatus: AccountsActionStatus.idle));
}
