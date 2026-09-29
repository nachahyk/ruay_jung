import 'package:ruay_jung/src/features/budgets/data/datasources/budget_remote_data_source.dart';
import 'package:ruay_jung/src/features/budgets/domain/entities/budget.dart';
import 'package:ruay_jung/src/features/budgets/domain/repositories/budget_repository.dart';

class BudgetRepositoryImpl implements BudgetRepository {
  BudgetRepositoryImpl(this._remoteDataSource);

  final BudgetRemoteDataSource _remoteDataSource;

  @override
  Future<List<Budget>> fetchBudgets(DateTime month) => _remoteDataSource.fetchBudgets(month);

  @override
  Future<Budget> setBudget({required String categoryId, required DateTime month, required double amount}) =>
      _remoteDataSource.setBudget(categoryId: categoryId, month: month, amount: amount);
}
