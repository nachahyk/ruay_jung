import 'package:ruay_jung/src/features/transactions/data/datasources/transaction_remote_data_source.dart';
import 'package:ruay_jung/src/features/transactions/domain/entities/transaction.dart';
import 'package:ruay_jung/src/features/transactions/domain/repositories/transaction_repository.dart';

class TransactionRepositoryImpl implements TransactionRepository {
  TransactionRepositoryImpl(this._remoteDataSource);

  final TransactionRemoteDataSource _remoteDataSource;

  @override
  Future<List<Transaction>> fetchTransactions() => _remoteDataSource.fetchTransactions();

  @override
  Future<Transaction> createTransaction(Transaction transaction) => _remoteDataSource.createTransaction(transaction);

  @override
  Future<Transaction> updateTransaction(Transaction transaction) => _remoteDataSource.updateTransaction(transaction);

  @override
  Future<void> deleteTransaction(String id) => _remoteDataSource.deleteTransaction(id);
}
