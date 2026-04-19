import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/profile_entity.dart';
import '../../domain/repositories/profile_repository.dart';
import '../datasources/profile_remote_data_source.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDataSource remoteDataSource;

  ProfileRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, ProfileEntity>> getProfile(String id) async {
    try {
      final profile = await remoteDataSource.getProfile(id);
      return right(profile);
    } on AuthFailure catch (e) {
      return left(e);
    } catch (e) {
      return left(AuthFailure(e.toString()));
    }
  }
}
