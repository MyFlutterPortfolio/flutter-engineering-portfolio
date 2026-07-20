import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:untitled5/core/errors/app_error_mapper.dart';
import 'package:untitled5/core/network/api_client.dart';
import 'package:untitled5/core/providers/security_providers.dart';
import 'package:untitled5/core/session/auth_gate.dart';
import 'package:untitled5/features/auth/data/repositories/auth_repository.dart';
import 'package:untitled5/features/auth/domain/repositories/auth_repository.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final dio = ref.watch(apiClientProvider).dio;
  final storage = ref.watch(secureStorageProvider);
  return AuthRepositoryImpl(dio, storage);
});

enum AuthStatus { authenticated, unauthenticated, loading, error }

class AuthState {
  final AuthStatus status;
  final String? errorMessage;

  AuthState({required this.status, this.errorMessage});

  factory AuthState.initial() => AuthState(status: AuthStatus.loading);
  factory AuthState.unauthenticated() =>
      AuthState(status: AuthStatus.unauthenticated);
  factory AuthState.authenticated() =>
      AuthState(status: AuthStatus.authenticated);
  factory AuthState.error(String message) =>
      AuthState(status: AuthStatus.error, errorMessage: message);
}

class AuthNotifier extends StateNotifier<AuthState> {
  final AuthRepository _repository;
  Future<void>? _authCheckInFlight;

  AuthNotifier(this._repository) : super(AuthState.initial()) {
    checkAuth();
  }

  Future<void> checkAuth() async {
    final existing = _authCheckInFlight;
    if (existing != null) return existing;

    final future = _checkAuthInternal();
    _authCheckInFlight = future;
    try {
      await future;
    } finally {
      if (identical(_authCheckInFlight, future)) {
        _authCheckInFlight = null;
      }
    }
  }

  Future<void> _checkAuthInternal() async {
    try {
      final authenticated = await _repository.isAuthenticated();
      _setState(
        authenticated ? AuthState.authenticated() : AuthState.unauthenticated(),
        gate: authenticated ? AuthGateState.signedIn : AuthGateState.signedOut,
      );
    } catch (e) {
      _setState(AuthState.unauthenticated(), gate: AuthGateState.signedOut);
    }
  }

  Future<void> login(String email, String password) async {
    state = AuthState(status: AuthStatus.loading);
    try {
      await _repository.login(email, password);
      _setState(AuthState.authenticated(), gate: AuthGateState.signedIn);
    } catch (e) {
      _setState(
        AuthState.error(AppErrorMapper.mapMessage(e)),
        gate: AuthGateState.signedOut,
      );
    }
  }

  Future<void> register({
    required String email,
    required String password,
    required String username,
  }) async {
    state = AuthState(status: AuthStatus.loading);
    try {
      await _repository.register(
        email: email,
        password: password,
        username: username,
      );

      // Backend register endpoint does not return tokens, so login immediately after register.
      await _repository.login(email, password);
      _setState(AuthState.authenticated(), gate: AuthGateState.signedIn);
    } catch (e) {
      _setState(
        AuthState.error(AppErrorMapper.mapMessage(e)),
        gate: AuthGateState.signedOut,
      );
    }
  }

  Future<void> logout() async {
    try {
      await _repository.logout();
    } finally {
      _setState(AuthState.unauthenticated(), gate: AuthGateState.signedOut);
    }
  }

  void forceLogout() {
    _setState(AuthState.unauthenticated(), gate: AuthGateState.signedOut);
  }

  void _setState(AuthState next, {AuthGateState? gate}) {
    state = next;
    if (gate != null && authGateNotifier.value != gate) {
      authGateNotifier.value = gate;
    }
  }
}

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final repository = ref.watch(authRepositoryProvider);
  return AuthNotifier(repository);
});
