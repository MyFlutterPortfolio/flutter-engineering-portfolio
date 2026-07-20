abstract interface class AuthRepository {
  Future<void> login(String email, String password);

  Future<void> register({
    required String email,
    required String password,
    required String username,
  });

  Future<void> logout();

  Future<bool> isAuthenticated();
}
