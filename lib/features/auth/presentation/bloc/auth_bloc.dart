import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/usecases/get_current_user.dart';
import '../../domain/usecases/sign_in_with_email_password.dart';
import '../../domain/usecases/sign_out.dart';
import '../../domain/usecases/sign_up_with_email_password.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignUpWithEmailPassword _signUpWithEmailPassword;
  final SignInWithEmailPassword _signInWithEmailPassword;
  final SignOut _signOut;
  final GetCurrentUser _getCurrentUser;

  AuthBloc({
    required SignUpWithEmailPassword signUpWithEmailPassword,
    required SignInWithEmailPassword signInWithEmailPassword,
    required SignOut signOut,
    required GetCurrentUser getCurrentUser,
  })  : _signUpWithEmailPassword = signUpWithEmailPassword,
        _signInWithEmailPassword = signInWithEmailPassword,
        _signOut = signOut,
        _getCurrentUser = getCurrentUser,
        super(AuthInitial()) {
    on<AuthSignUp>(_onSignUp);
    on<AuthSignIn>(_onSignIn);
    on<AuthSignOut>(_onSignOut);
    on<AuthIsUserLoggedIn>(_onIsUserLoggedIn);
  }

  void _onSignUp(AuthSignUp event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final res = await _signUpWithEmailPassword(
      email: event.email,
      password: event.password,
      fullName: event.fullName,
      avatarUrl: event.avatarUrl,

    );
    res.fold(
      (failure) => emit(AuthFailureState(failure.message)),
      (user) => emit(AuthAuthenticated(user)),
    );
  }

  void _onSignIn(AuthSignIn event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final res = await _signInWithEmailPassword(
      email: event.email,
      password: event.password,
    );
    res.fold(
      (failure) => emit(AuthFailureState(failure.message)),
      (user) => emit(AuthAuthenticated(user)),
    );
  }

  void _onSignOut(AuthSignOut event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final res = await _signOut();
    res.fold(
      (failure) => emit(AuthFailureState(failure.message)),
      (_) => emit(AuthUnauthenticated()),
    );
  }

  void _onIsUserLoggedIn(AuthIsUserLoggedIn event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final res = await _getCurrentUser();
    res.fold(
      (failure) => emit(AuthUnauthenticated()),
      (user) => emit(AuthAuthenticated(user)),
    );
  }
}
