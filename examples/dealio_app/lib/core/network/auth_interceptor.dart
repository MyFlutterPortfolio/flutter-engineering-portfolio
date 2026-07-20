import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:untitled5/core/network/api_endpoints.dart';

class AuthInterceptor extends Interceptor {
  final Dio _dio;
  final FlutterSecureStorage _storage;
  bool _isRefreshing = false;

  AuthInterceptor(this._dio, this._storage);

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    options.headers['Content-Type'] = 'application/json';
    options.headers['Accept'] = 'application/json';

    final token = await _readToken('accessToken');
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    _debugLog('REQUEST ${options.method} ${options.path}');
    return handler.next(options);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    if (err.response?.statusCode != 401 ||
        _isAuthPath(err.requestOptions.path)) {
      return handler.next(err);
    }

    if (_isRefreshing) {
      return handler.next(err);
    }

    _isRefreshing = true;
    try {
      final refreshToken = await _readToken('refreshToken');
      if (refreshToken == null) {
        await _clearTokens();
        return handler.next(err);
      }

      _debugLog('Refreshing access token');
      final refreshDio = Dio(
        BaseOptions(
          baseUrl: _dio.options.baseUrl,
          connectTimeout: _dio.options.connectTimeout,
          receiveTimeout: _dio.options.receiveTimeout,
          sendTimeout: _dio.options.sendTimeout,
          headers: const {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ),
      );

      final response = await refreshDio.post(
        ApiEndpoints.refresh,
        data: {'refreshToken': refreshToken},
      );

      if (response.statusCode != 200 && response.statusCode != 201) {
        await _clearTokens();
        return handler.next(err);
      }

      final newAccessToken = _stringField(response.data, 'accessToken');
      final newRefreshToken = _stringField(response.data, 'refreshToken');
      if (newAccessToken == null) {
        await _clearTokens();
        return handler.next(err);
      }

      await _storage.write(key: 'accessToken', value: newAccessToken);
      if (newRefreshToken != null) {
        await _storage.write(key: 'refreshToken', value: newRefreshToken);
      }

      final options = err.requestOptions;
      options.headers['Authorization'] = 'Bearer $newAccessToken';
      _debugLog('Access token refreshed; retrying request');
      final retryResponse = await _dio.fetch(options);
      return handler.resolve(retryResponse);
    } catch (_) {
      await _clearTokens();
      return handler.next(err);
    } finally {
      _isRefreshing = false;
    }
  }

  Future<String?> _readToken(String key) async {
    final value = await _storage.read(key: key);
    if (value == null) return null;

    final token = value.trim();
    if (token.isEmpty || token == 'null') return null;
    return token;
  }

  String? _stringField(Object? data, String key) {
    if (data is! Map) return null;
    final value = data[key];
    if (value is! String) return null;

    final trimmed = value.trim();
    return trimmed.isEmpty ? null : trimmed;
  }

  bool _isAuthPath(String path) {
    return path.contains('/auth/login') ||
        path.contains('/auth/register') ||
        path.contains(ApiEndpoints.refresh);
  }

  Future<void> _clearTokens() async {
    await _storage.delete(key: 'accessToken');
    await _storage.delete(key: 'refreshToken');
  }

  void _debugLog(String message) {
    if (kDebugMode) {
      debugPrint('[DIO] $message');
    }
  }
}
