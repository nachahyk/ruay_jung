import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../core/error/failures.dart';

abstract class AuthRemoteDataSource {
  Session? get currentUserSession;
  Stream<AuthState> get onAuthStateChange;

  Future<User?> signUpWithEmailPassword({
    required String email,
    required String password,
    required String fullName,
    String? avatarUrl,
  });

  Future<User?> signInWithEmailPassword({
    required String email,
    required String password,
  });

  Future<void> signOut();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final SupabaseClient Function() _clientGetter;

  AuthRemoteDataSourceImpl(this._clientGetter);

  SupabaseClient get _client => _clientGetter();

  @override
  Session? get currentUserSession => _client.auth.currentSession;

  @override
  Stream<AuthState> get onAuthStateChange => _client.auth.onAuthStateChange;

  @override
  Future<User?> signInWithEmailPassword({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _client.auth.signInWithPassword(
        email: email,
        password: password,
      );
      return response.user;
    } catch (e) {
      throw AuthFailure(e.toString());
    }
  }

  @override
  Future<User?> signUpWithEmailPassword({
    required String email,
    required String password,
    required String fullName,
    String? avatarUrl,
  }) async {
    try {
      final response = await _client.auth.signUp(
        email: email,
        password: password,
        data: {
          'full_name': fullName,
          'avatar_url': avatarUrl,
        },
      );
      final user = response.user;

      if (user == null) {
        throw AuthFailure('Signup failed. Please verify your email.');
      }

      return user;
    } on AuthException catch (e) {
      throw AuthFailure(e.message);
    } catch (e) {
      throw AuthFailure(e.toString());
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await _client.auth.signOut();
    } catch (e) {
      throw AuthFailure(e.toString());
    }
  }
}
