import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../core/error/failures.dart';
import '../models/category_model.dart';
import '../models/transaction_model.dart';

abstract class TransactionRemoteDataSource {
  Future<List<CategoryModel>> getCategories(String type);
  Future<void> addTransaction(TransactionModel transaction);
}

@Injectable(as: TransactionRemoteDataSource)
class TransactionRemoteDataSourceImpl implements TransactionRemoteDataSource {
  final SupabaseClient _client;

  TransactionRemoteDataSourceImpl(this._client);

  @override
  Future<List<CategoryModel>> getCategories(String type) async {
    try {
      final response = await _client.rpc(
        'get_categories',
        params: {'p_type': type},
      ) as List;

      return response
          .map((category) => CategoryModel.fromJson(category))
          .toList();
    } on PostgrestException catch (e) {
      throw AuthFailure(e.message);
    } catch (e) {
      throw AuthFailure(e.toString());
    }
  }

  @override
  Future<void> addTransaction(TransactionModel transaction) async {
    try {
      // Map to Supabase table structure
      // We might need to map category to category_id
      final data = {
        'amount': transaction.amount,
        'type': transaction.type,
        'date': transaction.date.toIso8601String(),
        'category_id': transaction.category.id,
        'note': transaction.note,
        'user_id': _client.auth.currentUser?.id,
      };

      await _client.from('transactions').insert(data);
    } on PostgrestException catch (e) {
      throw AuthFailure(e.message);
    } catch (e) {
      throw AuthFailure(e.toString());
    }
  }
}
