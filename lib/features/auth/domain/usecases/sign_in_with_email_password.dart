import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/error/failures.dart';
import '../entities/user_entity.dart';
import '../repositories/auth_repository.dart';

@injectable
class SignInWithEmailPassword {
  final AuthRepository repository;
  SignInWithEmailPassword(this.repository);

  Future<Either<Failure, UserEntity>> call({
    required String email,
    required String password,
  }) async {
    return await repository.signInWithEmailPassword(
      email: email,
      password: password,
    );
  }
}
