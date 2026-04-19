# Supabase Configuration Guide

This project uses Supabase for authentication and database services. To ensure security, the Supabase URL and Anon Key are not hardcoded but provided via `--dart-define` at build/run time.

## 1. Get Your Credentials
1. Go to your [Supabase Project Settings](https://app.supabase.com/project/_/settings/api).
2. Copy the `Project URL` and `anon public` key.

## 2. Run the App
You must provide the credentials using `--dart-define`.

### Via CLI
```bash
flutter run \
  --dart-define=SUPABASE_URL=YOUR_SUPABASE_URL \
  --dart-define=SUPABASE_ANON_KEY=YOUR_SUPABASE_ANON_KEY
```

### Via VS Code (`launch.json`)
Add `toolArgs` to your configuration:
```json
{
  "name": "ruay_jung",
  "request": "launch",
  "type": "dart",
  "toolArgs": [
    "--dart-define", "SUPABASE_URL=YOUR_SUPABASE_URL",
    "--dart-define", "SUPABASE_ANON_KEY=YOUR_SUPABASE_ANON_KEY"
  ]
}
```

### Via Android Studio
1. Open **Run/Debug Configurations**.
2. In the **Additional run args** field, add:
   `--dart-define=SUPABASE_URL=YOUR_SUPABASE_URL --dart-define=SUPABASE_ANON_KEY=YOUR_SUPABASE_ANON_KEY`

## 3. How it Works
- `SupabaseConfig`: Located in `lib/core/config/supabase_config.dart`, it reads these values using `String.fromEnvironment`.
- `SplashPage`: Initializes Supabase and checks the authentication status on startup.
- `AuthBloc`: Handles the logic for checking if a user is logged in after Supabase is ready.
