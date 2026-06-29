part of 'add_transaction_bloc.dart';

abstract class AddTransactionEvent extends Equatable {
  const AddTransactionEvent();

  @override
  List<Object?> get props => [];
}

class AddTransactionTypeChanged extends AddTransactionEvent {
  final String type;
  const AddTransactionTypeChanged(this.type);

  @override
  List<Object?> get props => [type];
}

class AddTransactionAmountChanged extends AddTransactionEvent {
  final double amount;
  const AddTransactionAmountChanged(this.amount);

  @override
  List<Object?> get props => [amount];
}

class AddTransactionDateChanged extends AddTransactionEvent {
  final DateTime date;
  const AddTransactionDateChanged(this.date);

  @override
  List<Object?> get props => [date];
}

class AddTransactionCategoryChanged extends AddTransactionEvent {
  final CategoryEntity category;
  const AddTransactionCategoryChanged(this.category);

  @override
  List<Object?> get props => [category];
}

class AddTransactionNoteChanged extends AddTransactionEvent {
  final String note;
  const AddTransactionNoteChanged(this.note);

  @override
  List<Object?> get props => [note];
}

class AddTransactionSubmitted extends AddTransactionEvent {}

class AddTransactionFetchCategories extends AddTransactionEvent {
  final String type;
  const AddTransactionFetchCategories(this.type);

  @override
  List<Object?> get props => [type];
}
