import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'core/config/supabase_config.dart';
import 'core/services/local_storage_service.dart';
import 'features/auth/data/datasources/auth_remote_data_source.dart';
import 'features/auth/data/repositories/auth_repository_impl.dart';
import 'features/auth/domain/repositories/auth_repository.dart';
import 'features/auth/domain/usecases/get_current_user.dart';
import 'features/auth/domain/usecases/sign_in_with_email_password.dart';
import 'features/auth/domain/usecases/sign_out.dart';
import 'features/auth/domain/usecases/sign_up_with_email_password.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';
import 'features/profile/data/datasources/profile_remote_data_source.dart';
import 'features/profile/data/repositories/profile_repository_impl.dart';
import 'features/profile/domain/repositories/profile_repository.dart';
import 'features/profile/domain/usecases/get_profile.dart';
import 'features/profile/presentation/bloc/profile_bloc.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  final prefs = await SharedPreferences.getInstance();
  serviceLocator.registerLazySingleton(() => LocalStorageService(prefs));

  await SupabaseConfig.initialize();

  _initAuth();
  _initProfile();

  serviceLocator.registerLazySingleton(() => SupabaseConfig.client);
}

void _initProfile() {
  serviceLocator
    ..registerFactory<ProfileRemoteDataSource>(
      () => ProfileRemoteDataSourceImpl(serviceLocator()),
    )
    ..registerFactory<ProfileRepository>(
      () => ProfileRepositoryImpl(serviceLocator()),
    )
    ..registerFactory(() => GetProfile(serviceLocator()))
    ..registerFactory(
      () => ProfileBloc(getProfile: serviceLocator()),
    );
}

void _initAuth() {
  // Datasource
  serviceLocator
    ..registerFactory<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(() => serviceLocator<SupabaseClient>()),
    )
    // Repository
    ..registerFactory<AuthRepository>(
      () => AuthRepositoryImpl(serviceLocator()),
    )
    // UseCases
    ..registerFactory(() => SignUpWithEmailPassword(serviceLocator()))
    ..registerFactory(() => SignInWithEmailPassword(serviceLocator()))
    ..registerFactory(() => SignOut(serviceLocator()))
    ..registerFactory(() => GetCurrentUser(serviceLocator()))
    // Bloc
    ..registerLazySingleton(
      () => AuthBloc(
        signUpWithEmailPassword: serviceLocator(),
        signInWithEmailPassword: serviceLocator(),
        signOut: serviceLocator(),
        getCurrentUser: serviceLocator(),
      ),
    );
}
