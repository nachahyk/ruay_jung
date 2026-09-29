import 'package:ruay_jung/src/features/accounts/data/datasources/account_remote_data_source.dart';
import 'package:ruay_jung/src/features/accounts/domain/entities/account.dart';
import 'package:ruay_jung/src/features/accounts/domain/repositories/account_repository.dart';

class AccountRepositoryImpl implements AccountRepository {
  AccountRepositoryImpl(this._remoteDataSource);

  final AccountRemoteDataSource _remoteDataSource;

  @override
  Future<List<Account>> fetchAccounts() => _remoteDataSource.fetchAccounts();

  @override
  Future<Account> createAccount({required String name, required AccountType type}) =>
      _remoteDataSource.createAccount(name: name, type: type);

  @override
  Future<void> deleteAccount(String id) => _remoteDataSource.deleteAccount(id);
}
