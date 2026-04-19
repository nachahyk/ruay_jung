import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../core/services/local_storage_service.dart';
import '../features/auth/presentation/bloc/auth_bloc.dart';
import '../features/auth/presentation/pages/login_page.dart';
import '../features/auth/presentation/pages/signup_page.dart';
import '../features/splash/presentation/pages/splash_page.dart';
import '../features/home/home_page.dart';
import '../features/profile/profile_page.dart';
import '../injection.dart';
import 'main_shell.dart';

final router = GoRouter(
  initialLocation: '/',
  refreshListenable: GoRouterRefreshStream(serviceLocator<AuthBloc>().stream),
  redirect: (context, state) {
    final authState = serviceLocator<AuthBloc>().state;
    final isFirstTime = serviceLocator<LocalStorageService>().isFirstTime();
    final isSplash = state.uri.path == '/';
    final isLoggingIn =
        state.uri.path == '/login' || state.uri.path == '/signup';

    if (isFirstTime) {
      return isSplash ? null : '/';
    }

    if (authState is AuthInitial || authState is AuthLoading) {
      return isSplash ? '/login' : null;
    }

    if (authState is AuthAuthenticated) {
      if (isLoggingIn || isSplash) {
        return '/home';
      }
      return null;
    }

    if (authState is AuthUnauthenticated || authState is AuthFailureState) {
      if (isLoggingIn) {
        return null;
      }
      return '/login';
    }

    return null;
  },
  routes: [
    GoRoute(path: '/', builder: (context, state) => const SplashPage()),
    GoRoute(path: '/login', builder: (context, state) => const LoginPage()),
    GoRoute(path: '/signup', builder: (context, state) => const SignUpPage()),
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return MainShell(navigationShell: navigationShell);
      },
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/home',
              name: 'home',
              builder: (_, _) => const HomePage(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/profile',
              name: 'profile',
              builder: (_, _) => const ProfilePage(),
            ),
          ],
        ),
      ],
    ),
  ],
);

class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream<dynamic> stream) {
    notifyListeners();
    _subscription = stream.asBroadcastStream().listen(
      (dynamic _) => notifyListeners(),
    );
  }

  late final StreamSubscription<dynamic> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
