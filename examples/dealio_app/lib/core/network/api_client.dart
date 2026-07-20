import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:untitled5/features/auth/presentation/providers/auth_provider.dart';
import 'package:untitled5/core/providers/security_providers.dart';

import 'api_endpoints.dart';

class ApiClient {
  late Dio _dio;
  final Ref? _ref;
  final FlutterSecureStorage _secureStorage;
  Future<bool>? _refreshInFlight;

  ApiClient(this._secureStorage, [this._ref]) {
    _dio = Dio(
      BaseOptions(
        baseUrl: ApiEndpoints.baseUrl,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await _getStoredAccessToken();

          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }

          _debugLog('REQUEST ${options.method} ${options.path}');
          return handler.next(options);
        },
        onResponse: (response, handler) {
          _debugLog(
            'RESPONSE ${response.statusCode} ${response.requestOptions.path}',
          );
          return handler.next(response);
        },
        onError: (DioException e, handler) async {
          _debugLog(
            'ERROR ${e.response?.statusCode ?? '-'} '
            '${e.requestOptions.path} ${e.type.name}',
          );

          if (e.response?.statusCode == 401 &&
              !_isAuthPath(e.requestOptions.path) &&
              e.requestOptions.extra['retriedAfterRefresh'] != true) {
            // Handle 401 Unauthorized - Token expired or invalid
            try {
              final refreshed = await _refreshAccessTokenOnce();
              if (refreshed) {
                // Retry the original request with new token
                return handler.resolve(await _retry(e.requestOptions));
              }
            } catch (_) {
              // Fall through to the original unauthorized response.
            }

            if (_ref != null) {
              _ref.read(authProvider.notifier).forceLogout();
            }
          }

          return handler.next(e);
        },
      ),
    );
  }

  Future<bool> _refreshAccessTokenOnce() {
    final existing = _refreshInFlight;
    if (existing != null) return existing;

    final future = _tryRefreshToken();
    _refreshInFlight = future;
    return future.whenComplete(() {
      if (identical(_refreshInFlight, future)) {
        _refreshInFlight = null;
      }
    });
  }

  Future<bool> _tryRefreshToken() async {
    try {
      final refreshToken = await _getStoredRefreshToken();

      if (refreshToken == null) return false;

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

      if (response.statusCode == 200 || response.statusCode == 201) {
        final newAccessToken = _stringField(response.data, 'accessToken');
        final newRefreshToken = _stringField(response.data, 'refreshToken');

        if (newAccessToken == null) return false;

        await _secureStorage.write(key: 'accessToken', value: newAccessToken);

        if (newRefreshToken != null) {
          await _secureStorage.write(
            key: 'refreshToken',
            value: newRefreshToken,
          );
        }
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  Future<Response> _retry(RequestOptions requestOptions) async {
    final token = await _getStoredAccessToken();

    final options = Options(
      method: requestOptions.method,
      headers: {
        ...requestOptions.headers,
        if (token != null) 'Authorization': 'Bearer $token',
      },
      extra: {...requestOptions.extra, 'retriedAfterRefresh': true},
    );

    return _dio.request<dynamic>(
      requestOptions.path,
      data: requestOptions.data,
      queryParameters: requestOptions.queryParameters,
      options: options,
    );
  }

  Future<String?> _getStoredAccessToken() async {
    return _readToken('accessToken');
  }

  Future<String?> _getStoredRefreshToken() async {
    return _readToken('refreshToken');
  }

  Future<String?> _readToken(String key) async {
    final value = await _secureStorage.read(key: key);
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
        path.contains('/auth/refresh');
  }

  void _debugLog(String message) {
    if (kDebugMode) {
      debugPrint('[DIO] $message');
    }
  }

  Dio get dio => _dio;
}

final apiClientProvider = Provider<ApiClient>((ref) {
  return ApiClient(ref.watch(secureStorageProvider), ref);
});
