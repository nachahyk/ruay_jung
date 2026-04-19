
import 'package:fpdart/fpdart.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/error/failures.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl(this.remoteDataSource);

  @override
  Stream<AuthState> get onAuthStateChange => remoteDataSource.onAuthStateChange;

  UserEntity _mapToUserEntity(User user) {
    return UserEntity(
      id: user.id,
      email: user.email ?? '',
      fullName: user.userMetadata?['full_name'],
      avatarUrl: user.userMetadata?['avatar_url'],
    );
  }

  @override
  Future<Either<Failure, UserEntity>> getCurrentUser() async {
    try {
      final user = remoteDataSource.currentUserSession?.user;
      if (user == null) {
        return left(const AuthFailure('User not logged in'));
      }
      return right(_mapToUserEntity(user));
    } catch (e) {
      return left(AuthFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> signInWithEmailPassword({
    required String email,
    required String password,
  }) async {
    try {
      final user = await remoteDataSource.signInWithEmailPassword(
        email: email,
        password: password,
      );
      if (user == null) {
        return left(const AuthFailure('User is null'));
      }
      return right(_mapToUserEntity(user));
    } on AuthFailure catch (e) {
      return left(e);
    } catch (e) {
      return left(AuthFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> signUpWithEmailPassword({
    required String email,
    required String password,
    required String fullName,
    String? avatarUrl,
  }) async {
    try {
      final user = await remoteDataSource.signUpWithEmailPassword(
        email: email,
        password: password,
        fullName: fullName,
        avatarUrl: avatarUrl,
      );
      if (user == null) {
        return left(const AuthFailure('User is null'));
      }
      return right(_mapToUserEntity(user));
    } on AuthFailure catch (e) {
      return left(e);
    } catch (e) {
      return left(AuthFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> signOut() async {
    try {
      await remoteDataSource.signOut();
      return right(null);
    } on AuthFailure catch (e) {
      return left(e);
    } catch (e) {
      return left(AuthFailure(e.toString()));
    }
  }
}
