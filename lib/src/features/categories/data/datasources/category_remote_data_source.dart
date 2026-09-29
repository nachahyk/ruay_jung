import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:ruay_jung/src/features/categories/domain/entities/category.dart';
import 'package:ruay_jung/src/features/categories/domain/entities/transaction_kind.dart';

TransactionKind _kindFromString(String value) => value == 'income' ? TransactionKind.income : TransactionKind.expense;

Category _categoryFromMap(Map<String, dynamic> map) {
  return Category(
    id: map['id'] as String,
    name: map['name'] as String,
    kind: _kindFromString(map['kind'] as String),
  );
}

class CategoryRemoteDataSource {
  CategoryRemoteDataSource(this._client);

  final SupabaseClient _client;

  Future<List<Category>> fetchCategories() async {
    final rows = await _client.from('rj_categories').select().order('created_at');
    return rows.map(_categoryFromMap).toList();
  }

  Future<Category> createCategory({required String name, required TransactionKind kind}) async {
    final row = await _client
        .from('rj_categories')
        .insert({'name': name, 'kind': kind.name})
        .select()
        .single();
    return _categoryFromMap(row);
  }
}
