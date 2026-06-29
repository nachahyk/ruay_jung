import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/error/failures.dart';
import '../entities/category_entity.dart';
import '../repositories/transaction_repository.dart';

@injectable
class GetCategories {
  final TransactionRepository repository;

  GetCategories(this.repository);

  Future<Either<Failure, List<CategoryEntity>>> call(String type) async {
    return await repository.getCategories(type);
  }
}
