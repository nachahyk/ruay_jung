import 'package:ruay_jung/src/features/categories/data/datasources/category_remote_data_source.dart';
import 'package:ruay_jung/src/features/categories/domain/entities/category.dart';
import 'package:ruay_jung/src/features/categories/domain/entities/transaction_kind.dart';
import 'package:ruay_jung/src/features/categories/domain/repositories/category_repository.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  CategoryRepositoryImpl(this._remoteDataSource);

  final CategoryRemoteDataSource _remoteDataSource;

  @override
  Future<List<Category>> fetchCategories() => _remoteDataSource.fetchCategories();

  @override
  Future<Category> createCategory({required String name, required TransactionKind kind}) =>
      _remoteDataSource.createCategory(name: name, kind: kind);
}
