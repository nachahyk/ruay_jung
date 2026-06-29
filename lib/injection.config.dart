// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:ruay_jung/core/services/local_storage_service.dart' as _i167;
import 'package:ruay_jung/features/auth/data/datasources/auth_remote_data_source.dart'
    as _i360;
import 'package:ruay_jung/features/auth/data/repositories/auth_repository_impl.dart'
    as _i738;
import 'package:ruay_jung/features/auth/domain/repositories/auth_repository.dart'
    as _i820;
import 'package:ruay_jung/features/auth/domain/usecases/get_current_user.dart'
    as _i356;
import 'package:ruay_jung/features/auth/domain/usecases/sign_in_with_email_password.dart'
    as _i705;
import 'package:ruay_jung/features/auth/domain/usecases/sign_out.dart' as _i612;
import 'package:ruay_jung/features/auth/domain/usecases/sign_up_with_email_password.dart'
    as _i289;
import 'package:ruay_jung/features/auth/presentation/bloc/auth_bloc.dart'
    as _i679;
import 'package:ruay_jung/features/profile/data/datasources/profile_remote_data_source.dart'
    as _i150;
import 'package:ruay_jung/features/profile/data/repositories/profile_repository_impl.dart'
    as _i402;
import 'package:ruay_jung/features/profile/domain/repositories/profile_repository.dart'
    as _i350;
import 'package:ruay_jung/features/profile/domain/usecases/get_profile.dart'
    as _i10;
import 'package:ruay_jung/features/profile/presentation/bloc/profile_bloc.dart'
    as _i337;
import 'package:ruay_jung/features/transaction/data/datasources/transaction_remote_data_source.dart'
    as _i542;
import 'package:ruay_jung/features/transaction/data/repositories/transaction_repository_impl.dart'
    as _i1055;
import 'package:ruay_jung/features/transaction/domain/repositories/transaction_repository.dart'
    as _i501;
import 'package:ruay_jung/features/transaction/domain/usecases/add_transaction.dart'
    as _i415;
import 'package:ruay_jung/features/transaction/domain/usecases/get_categories.dart'
    as _i85;
import 'package:ruay_jung/features/transaction/presentation/bloc/add_transaction_bloc.dart'
    as _i1018;
import 'package:ruay_jung/features/transaction/presentation/bloc/transaction_bloc.dart'
    as _i665;
import 'package:ruay_jung/injection.dart' as _i550;
import 'package:shared_preferences/shared_preferences.dart' as _i460;
import 'package:supabase_flutter/supabase_flutter.dart' as _i454;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final registerModule = _$RegisterModule();
    await gh.factoryAsync<_i460.SharedPreferences>(
      () => registerModule.prefs,
      preResolve: true,
    );
    gh.lazySingleton<_i454.SupabaseClient>(() => registerModule.supabaseClient);
    gh.factory<_i542.TransactionRemoteDataSource>(
      () => _i542.TransactionRemoteDataSourceImpl(gh<_i454.SupabaseClient>()),
    );
    gh.lazySingleton<_i167.LocalStorageService>(
      () => _i167.LocalStorageService(gh<_i460.SharedPreferences>()),
    );
    gh.factory<_i360.AuthRemoteDataSource>(
      () => _i360.AuthRemoteDataSourceImpl(gh<_i454.SupabaseClient>()),
    );
    gh.factory<_i150.ProfileRemoteDataSource>(
      () => _i150.ProfileRemoteDataSourceImpl(gh<_i454.SupabaseClient>()),
    );
    gh.factory<_i501.TransactionRepository>(
      () => _i1055.TransactionRepositoryImpl(
        gh<_i542.TransactionRemoteDataSource>(),
      ),
    );
    gh.factory<_i415.AddTransaction>(
      () => _i415.AddTransaction(gh<_i501.TransactionRepository>()),
    );
    gh.factory<_i85.GetCategories>(
      () => _i85.GetCategories(gh<_i501.TransactionRepository>()),
    );
    gh.factory<_i820.AuthRepository>(
      () => _i738.AuthRepositoryImpl(gh<_i360.AuthRemoteDataSource>()),
    );
    gh.factory<_i665.TransactionBloc>(
      () => _i665.TransactionBloc(getCategories: gh<_i85.GetCategories>()),
    );
    gh.factory<_i1018.AddTransactionBloc>(
      () => _i1018.AddTransactionBloc(
        addTransaction: gh<_i415.AddTransaction>(),
        getCategories: gh<_i85.GetCategories>(),
      ),
    );
    gh.factory<_i350.ProfileRepository>(
      () => _i402.ProfileRepositoryImpl(gh<_i150.ProfileRemoteDataSource>()),
    );
    gh.factory<_i10.GetProfile>(
      () => _i10.GetProfile(gh<_i350.ProfileRepository>()),
    );
    gh.factory<_i356.GetCurrentUser>(
      () => _i356.GetCurrentUser(gh<_i820.AuthRepository>()),
    );
    gh.factory<_i705.SignInWithEmailPassword>(
      () => _i705.SignInWithEmailPassword(gh<_i820.AuthRepository>()),
    );
    gh.factory<_i612.SignOut>(() => _i612.SignOut(gh<_i820.AuthRepository>()));
    gh.factory<_i289.SignUpWithEmailPassword>(
      () => _i289.SignUpWithEmailPassword(gh<_i820.AuthRepository>()),
    );
    gh.factory<_i337.ProfileBloc>(
      () => _i337.ProfileBloc(getProfile: gh<_i10.GetProfile>()),
    );
    gh.lazySingleton<_i679.AuthBloc>(
      () => _i679.AuthBloc(
        signUpWithEmailPassword: gh<_i289.SignUpWithEmailPassword>(),
        signInWithEmailPassword: gh<_i705.SignInWithEmailPassword>(),
        signOut: gh<_i612.SignOut>(),
        getCurrentUser: gh<_i356.GetCurrentUser>(),
      ),
    );
    return this;
  }
}

class _$RegisterModule extends _i550.RegisterModule {}
