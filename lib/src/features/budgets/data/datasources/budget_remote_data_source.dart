import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:ruay_jung/src/features/budgets/domain/entities/budget.dart';

String _monthKey(DateTime month) {
  final normalized = DateTime(month.year, month.month, 1);
  return normalized.toIso8601String().split('T').first;
}

Budget _budgetFromMap(Map<String, dynamic> map) {
  return Budget(
    id: map['id'] as String,
    categoryId: map['category_id'] as String,
    month: DateTime.parse(map['month'] as String),
    amount: (map['amount'] as num).toDouble(),
  );
}

class BudgetRemoteDataSource {
  BudgetRemoteDataSource(this._client);

  final SupabaseClient _client;

  Future<List<Budget>> fetchBudgets(DateTime month) async {
    final rows = await _client.from('rj_budgets').select().eq('month', _monthKey(month));
    return rows.map(_budgetFromMap).toList();
  }

  Future<Budget> setBudget({required String categoryId, required DateTime month, required double amount}) async {
    final row = await _client
        .from('rj_budgets')
        .upsert(
          {'category_id': categoryId, 'month': _monthKey(month), 'amount': amount},
          onConflict: 'owner_id,category_id,month',
        )
        .select()
        .single();
    return _budgetFromMap(row);
  }
}
