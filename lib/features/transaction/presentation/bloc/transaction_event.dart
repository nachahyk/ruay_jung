part of 'transaction_bloc.dart';

sealed class TransactionEvent extends Equatable {
  const TransactionEvent();

  @override
  List<Object> get props => [];
}

final class TransactionCategoriesFetchRequested extends TransactionEvent {
  final String type;

  const TransactionCategoriesFetchRequested(this.type);

  @override
  List<Object> get props => [type];
}
