part of 'add_transaction_bloc.dart';

enum AddTransactionStatus { initial, loading, success, failure }

class AddTransactionState extends Equatable {
  final AddTransactionStatus status;
  final String type; // 'expense' or 'income'
  final double amount;
  final DateTime date;
  final CategoryEntity? category;
  final List<CategoryEntity> categories;
  final String note;
  final String? errorMessage;

  const AddTransactionState({
    this.status = AddTransactionStatus.initial,
    this.type = 'expense',
    this.amount = 0.0,
    required this.date,
    this.category,
    this.categories = const [],
    this.note = '',
    this.errorMessage,
  });

  AddTransactionState copyWith({
    AddTransactionStatus? status,
    String? type,
    double? amount,
    DateTime? date,
    CategoryEntity? category,
    List<CategoryEntity>? categories,
    String? note,
    String? errorMessage,
  }) {
    return AddTransactionState(
      status: status ?? this.status,
      type: type ?? this.type,
      amount: amount ?? this.amount,
      date: date ?? this.date,
      category: category ?? this.category,
      categories: categories ?? this.categories,
      note: note ?? this.note,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        status,
        type,
        amount,
        date,
        category,
        categories,
        note,
        errorMessage,
      ];
}
