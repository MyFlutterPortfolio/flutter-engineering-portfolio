import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:untitled5/features/auth/domain/repositories/auth_repository.dart';

final class AuthRepositoryImpl implements AuthRepository {
  final Dio _dio;
  final FlutterSecureStorage _storage;
  AuthRepositoryImpl(this._dio, this._storage);

  @override
  Future<void> login(String email, String password) async {
    final response = await _dio.post(
      '/auth/login',
      data: {'email': email, 'password': password},
    );

    final accessToken = _stringField(response.data, 'accessToken');
    final refreshToken = _stringField(response.data, 'refreshToken');
    if (accessToken == null || refreshToken == null) {
      throw StateError('Invalid auth response');
    }

    await _storage.write(key: 'accessToken', value: accessToken);
    await _storage.write(key: 'refreshToken', value: refreshToken);
  }

  @override
  Future<void> register({
    required String email,
    required String password,
    required String username,
  }) async {
    await _dio.post(
      '/auth/register',
      data: {'email': email, 'password': password, 'username': username},
    );
  }

  @override
  Future<void> logout() async {
    try {
      final refreshToken = (await _storage.read(key: 'refreshToken'))?.trim();

      if (refreshToken != null && refreshToken.isNotEmpty) {
        await _dio.post('/auth/logout', data: {'refreshToken': refreshToken});
      }
    } finally {
      await _storage.delete(key: 'accessToken');
      await _storage.delete(key: 'refreshToken');
    }
  }

  @override
  Future<bool> isAuthenticated() async {
    final token = await _storage.read(key: 'accessToken');
    final isValidToken =
        token != null && token.trim().isNotEmpty && token.trim() != 'null';

    if (!isValidToken) {
      await _storage.delete(key: 'accessToken');
      await _storage.delete(key: 'refreshToken');
    }

    return isValidToken;
  }

  String? _stringField(Object? data, String key) {
    if (data is! Map) return null;
    final value = data[key];
    if (value is! String) return null;
    final trimmed = value.trim();
    return trimmed.isEmpty || trimmed == 'null' ? null : trimmed;
  }
}
