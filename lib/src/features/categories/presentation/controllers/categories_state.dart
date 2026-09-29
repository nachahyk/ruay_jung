import 'package:equatable/equatable.dart';

import 'package:ruay_jung/src/features/categories/domain/entities/category.dart';
import 'package:ruay_jung/src/features/categories/domain/entities/transaction_kind.dart';

enum CategoriesStatus { initial, loading, loaded, error }

class CategoriesState extends Equatable {
  const CategoriesState({this.status = CategoriesStatus.initial, this.categories = const [], this.error});

  final CategoriesStatus status;
  final List<Category> categories;
  final String? error;

  List<Category> get incomeCategories => categories.where((c) => c.kind == TransactionKind.income).toList();

  List<Category> get expenseCategories => categories.where((c) => c.kind == TransactionKind.expense).toList();

  CategoriesState copyWith({CategoriesStatus? status, List<Category>? categories, String? error, bool clearError = false}) {
    return CategoriesState(
      status: status ?? this.status,
      categories: categories ?? this.categories,
      error: clearError ? null : (error ?? this.error),
    );
  }

  @override
  List<Object?> get props => [status, categories, error];
}
