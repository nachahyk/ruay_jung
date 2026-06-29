part of 'transaction_bloc.dart';

sealed class TransactionState extends Equatable {
  const TransactionState();

  @override
  List<Object?> get props => [];
}

final class TransactionInitial extends TransactionState {}

final class TransactionLoading extends TransactionState {}

final class TransactionCategoriesLoaded extends TransactionState {
  final List<CategoryEntity> categories;

  const TransactionCategoriesLoaded(this.categories);

  @override
  List<Object?> get props => [categories];
}

final class TransactionError extends TransactionState {
  final String message;

  const TransactionError(this.message);

  @override
  List<Object?> get props => [message];
}
