import 'package:ruay_jung/src/features/categories/domain/entities/category.dart';
import 'package:ruay_jung/src/features/categories/domain/entities/transaction_kind.dart';

abstract class CategoryRepository {
  Future<List<Category>> fetchCategories();

  Future<Category> createCategory({required String name, required TransactionKind kind});
}
