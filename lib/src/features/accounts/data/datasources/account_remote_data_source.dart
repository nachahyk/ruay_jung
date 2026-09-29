import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:ruay_jung/src/features/accounts/domain/entities/account.dart';

AccountType _typeFromString(String value) {
  return AccountType.values.firstWhere((t) => t.name == value, orElse: () => AccountType.other);
}

Account _accountFromMap(Map<String, dynamic> map) {
  return Account(
    id: map['id'] as String,
    name: map['name'] as String,
    type: _typeFromString(map['account_type'] as String),
  );
}

class AccountRemoteDataSource {
  AccountRemoteDataSource(this._client);

  final SupabaseClient _client;

  Future<List<Account>> fetchAccounts() async {
    final rows = await _client.from('rj_accounts').select().order('created_at');
    return rows.map(_accountFromMap).toList();
  }

  Future<Account> createAccount({required String name, required AccountType type}) async {
    final row = await _client
        .from('rj_accounts')
        .insert({'name': name, 'account_type': type.name})
        .select()
        .single();
    return _accountFromMap(row);
  }

  Future<void> deleteAccount(String id) {
    return _client.from('rj_accounts').delete().eq('id', id);
  }
}
