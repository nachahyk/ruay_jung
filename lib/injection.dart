import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'core/config/supabase_config.dart';
import 'injection.config.dart';

final serviceLocator = GetIt.instance;

@InjectableInit()
Future<void> initDependencies() async {
  await SupabaseConfig.initialize();
  await serviceLocator.init();
}

@module
abstract class RegisterModule {
  @preResolve
  Future<SharedPreferences> get prefs => SharedPreferences.getInstance();

  @lazySingleton
  SupabaseClient get supabaseClient => SupabaseConfig.client;
}
