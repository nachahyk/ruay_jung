import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/error/failures.dart';
import '../repositories/auth_repository.dart';

@injectable
class SignOut {
  final AuthRepository repository;
  SignOut(this.repository);

  Future<Either<Failure, void>> call() async {
    return await repository.signOut();
  }
}
