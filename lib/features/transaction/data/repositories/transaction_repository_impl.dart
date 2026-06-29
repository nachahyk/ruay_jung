import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/category_entity.dart';
import '../../domain/entities/transaction_entity.dart';
import '../../domain/repositories/transaction_repository.dart';
import '../datasources/transaction_remote_data_source.dart';
import '../models/transaction_model.dart';

@Injectable(as: TransactionRepository)
class TransactionRepositoryImpl implements TransactionRepository {
  final TransactionRemoteDataSource remoteDataSource;

  TransactionRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, List<CategoryEntity>>> getCategories(String type) async {
    try {
      final categories = await remoteDataSource.getCategories(type);
      return right(categories.map((model) => model.toEntity()).toList());
    } on AuthFailure catch (e) {
      return left(e);
    } catch (e) {
      return left(AuthFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> addTransaction(TransactionEntity transaction) async {
    try {
      await remoteDataSource.addTransaction(
        TransactionModel.fromEntity(transaction),
      );
      return right(null);
    } on AuthFailure catch (e) {
      return left(e);
    } catch (e) {
      return left(AuthFailure(e.toString()));
    }
  }
}
