import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseConfig {
  static const String _url = String.fromEnvironment(
    'SUPABASE_URL', 
    defaultValue: '',
  );
  
  static const String _anonKey = String.fromEnvironment(
    'SUPABASE_ANON_KEY',
    defaultValue: '',
  );

  static Future<void> initialize() async {
    if (_url.isEmpty || _anonKey.isEmpty) {
      throw Exception(
        'Supabase URL and Anon Key must be provided via --dart-define. \n'
        'Example: flutter run --dart-define=SUPABASE_URL=... --dart-define=SUPABASE_ANON_KEY=...'
      );
    }

    await Supabase.initialize(
      url: _url,
      anonKey: _anonKey,
      authOptions: const FlutterAuthClientOptions(
        authFlowType: AuthFlowType.pkce,
        autoRefreshToken: true,
      ),
      realtimeClientOptions: const RealtimeClientOptions(
        logLevel: RealtimeLogLevel.info,
      ),
      storageOptions: const StorageClientOptions(
        retryAttempts: 3,
      ),
    );
  }

  /// Get Supabase Client Instance
  static SupabaseClient get client => Supabase.instance.client;

  /// Get Auth Client
  static GoTrueClient get auth => client.auth;

  /// Get Storage Client
  static SupabaseStorageClient get storage => client.storage;

  /// Get Realtime Client
  static RealtimeClient get realtime => client.realtime;
}
