import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:ruay_jung/src/features/categories/domain/entities/transaction_kind.dart';
import 'package:ruay_jung/src/features/transactions/domain/entities/transaction.dart';

TransactionKind _kindFromString(String value) => value == 'income' ? TransactionKind.income : TransactionKind.expense;

Transaction _transactionFromMap(Map<String, dynamic> map) {
  return Transaction(
    id: map['id'] as String,
    accountId: map['account_id'] as String,
    categoryId: map['category_id'] as String,
    kind: _kindFromString(map['kind'] as String),
    amount: (map['amount'] as num).toDouble(),
    occurredOn: DateTime.parse(map['occurred_on'] as String),
    note: map['note'] as String?,
  );
}

class TransactionRemoteDataSource {
  TransactionRemoteDataSource(this._client);

  final SupabaseClient _client;

  Future<List<Transaction>> fetchTransactions() async {
    final rows = await _client.from('rj_transactions').select().order('occurred_on', ascending: false);
    return rows.map(_transactionFromMap).toList();
  }

  Future<Transaction> createTransaction(Transaction transaction) async {
    final row = await _client
        .from('rj_transactions')
        .insert({
          'account_id': transaction.accountId,
          'category_id': transaction.categoryId,
          'kind': transaction.kind.name,
          'amount': transaction.amount,
          'occurred_on': transaction.occurredOn.toIso8601String().split('T').first,
          'note': transaction.note,
        })
        .select()
        .single();
    return _transactionFromMap(row);
  }

  Future<Transaction> updateTransaction(Transaction transaction) async {
    final row = await _client
        .from('rj_transactions')
        .update({
          'account_id': transaction.accountId,
          'category_id': transaction.categoryId,
          'kind': transaction.kind.name,
          'amount': transaction.amount,
          'occurred_on': transaction.occurredOn.toIso8601String().split('T').first,
          'note': transaction.note,
        })
        .eq('id', transaction.id)
        .select()
        .single();
    return _transactionFromMap(row);
  }

  Future<void> deleteTransaction(String id) {
    return _client.from('rj_transactions').delete().eq('id', id);
  }
}
