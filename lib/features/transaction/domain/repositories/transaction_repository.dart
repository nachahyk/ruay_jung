import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failures.dart';
import '../entities/category_entity.dart';
import '../entities/transaction_entity.dart';

abstract class TransactionRepository {
  Future<Either<Failure, List<CategoryEntity>>> getCategories(String type);
  Future<Either<Failure, void>> addTransaction(TransactionEntity transaction);
}
