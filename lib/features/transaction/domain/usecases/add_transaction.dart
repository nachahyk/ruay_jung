import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/error/failures.dart';
import '../entities/transaction_entity.dart';
import '../repositories/transaction_repository.dart';

@injectable
class AddTransaction {
  final TransactionRepository repository;

  AddTransaction(this.repository);

  Future<Either<Failure, void>> call(TransactionEntity transaction) async {
    return await repository.addTransaction(transaction);
  }
}
