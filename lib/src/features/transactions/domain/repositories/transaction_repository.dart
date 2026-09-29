import 'package:ruay_jung/src/features/transactions/domain/entities/transaction.dart';

abstract class TransactionRepository {
  /// Every transaction, newest first — the app's data volume at this stage
  /// doesn't call for server-side month filtering; the cubit derives
  /// per-month views client-side from one loaded list.
  Future<List<Transaction>> fetchTransactions();

  Future<Transaction> createTransaction(Transaction transaction);

  Future<Transaction> updateTransaction(Transaction transaction);

  Future<void> deleteTransaction(String id);
}
