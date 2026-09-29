import 'package:ruay_jung/src/features/accounts/domain/entities/account.dart';

abstract class AccountRepository {
  Future<List<Account>> fetchAccounts();

  Future<Account> createAccount({required String name, required AccountType type});

  Future<void> deleteAccount(String id);
}
