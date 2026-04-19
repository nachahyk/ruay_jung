import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failures.dart';
import '../entities/profile_entity.dart';
import '../repositories/profile_repository.dart';

class GetProfile {
  final ProfileRepository repository;

  GetProfile(this.repository);

  Future<Either<Failure, ProfileEntity>> call(String id) async {
    return await repository.getProfile(id);
  }
}
