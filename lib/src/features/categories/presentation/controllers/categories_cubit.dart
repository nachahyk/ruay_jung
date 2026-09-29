import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ruay_jung/src/features/categories/domain/entities/category.dart';
import 'package:ruay_jung/src/features/categories/domain/entities/transaction_kind.dart';
import 'package:ruay_jung/src/features/categories/domain/repositories/category_repository.dart';
import 'package:ruay_jung/src/features/categories/presentation/controllers/categories_state.dart';

const _defaultIncomeCategories = ['Salary', 'Freelance'];
const _defaultExpenseCategories = ['Food & Dining', 'Transport', 'Bills', 'Shopping'];

class CategoriesCubit extends Cubit<CategoriesState> {
  CategoriesCubit(this._repository) : super(const CategoriesState());

  final CategoryRepository _repository;

  Future<void> loadCategories() async {
    emit(state.copyWith(status: CategoriesStatus.loading, clearError: true));
    try {
      var categories = await _repository.fetchCategories();
      if (categories.isEmpty) {
        categories = await _seedDefaultCategories();
      }
      emit(state.copyWith(status: CategoriesStatus.loaded, categories: categories));
    } catch (error) {
      emit(state.copyWith(status: CategoriesStatus.error, error: error.toString()));
    }
  }

  /// A brand-new user has no categories yet, which would leave the Budgets
  /// tab and the transaction form's category picker empty on first open —
  /// seed a starter set once so there's something real to work with.
  Future<List<Category>> _seedDefaultCategories() async {
    final created = <Category>[];
    for (final name in _defaultIncomeCategories) {
      created.add(await _repository.createCategory(name: name, kind: TransactionKind.income));
    }
    for (final name in _defaultExpenseCategories) {
      created.add(await _repository.createCategory(name: name, kind: TransactionKind.expense));
    }
    return created;
  }

  Future<Category> createCategory({required String name, required TransactionKind kind}) async {
    final category = await _repository.createCategory(name: name, kind: kind);
    emit(state.copyWith(categories: [...state.categories, category]));
    return category;
  }
}
