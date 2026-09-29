import 'package:equatable/equatable.dart';

import 'package:ruay_jung/src/features/accounts/domain/entities/account.dart';

enum AccountsStatus { initial, loading, loaded, error }

enum AccountsActionStatus { idle, saving, success, failure }

class AccountsState extends Equatable {
  const AccountsState({
    this.status = AccountsStatus.initial,
    this.accounts = const [],
    this.error,
    this.actionStatus = AccountsActionStatus.idle,
    this.actionError,
  });

  final AccountsStatus status;
  final List<Account> accounts;
  final String? error;
  final AccountsActionStatus actionStatus;
  final String? actionError;

  AccountsState copyWith({
    AccountsStatus? status,
    List<Account>? accounts,
    String? error,
    bool clearError = false,
    AccountsActionStatus? actionStatus,
    String? actionError,
    bool clearActionError = false,
  }) {
    return AccountsState(
      status: status ?? this.status,
      accounts: accounts ?? this.accounts,
      error: clearError ? null : (error ?? this.error),
      actionStatus: actionStatus ?? this.actionStatus,
      actionError: clearActionError ? null : (actionError ?? this.actionError),
    );
  }

  @override
  List<Object?> get props => [status, accounts, error, actionStatus, actionError];
}
