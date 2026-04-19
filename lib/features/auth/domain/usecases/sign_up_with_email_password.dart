import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failures.dart';
import '../entities/user_entity.dart';
import '../repositories/auth_repository.dart';

class SignUpWithEmailPassword {
  final AuthRepository repository;
  SignUpWithEmailPassword(this.repository);

  Future<Either<Failure, UserEntity>> call({
    required String email,
    required String password,
    required String fullName,
    String? avatarUrl,
  }) async {
    return await repository.signUpWithEmailPassword(
      email: email,
      password: password,
      fullName: fullName,
      avatarUrl: avatarUrl,
    );
  }
}
