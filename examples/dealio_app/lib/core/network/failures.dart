import 'package:dio/dio.dart';

const String kGenericUserErrorMessage =
    'Something went wrong. Please try again.';
const String kSearchUnavailableMessage =
    'Search is temporarily unavailable. Please try again.';

const List<String> _technicalErrorSignals = <String>[
  'typeerror',
  'nosuchmethoderror',
  'formatexception',
  'casterror',
  'stack trace',
  'subtype of type',
  "type 'null'",
  'map<string',
  'renderflex',
  'renderbox',
  'exception:',
];

String _sanitizeForUser(
  String? raw, {
  String fallback = kGenericUserErrorMessage,
}) {
  final message = raw?.trim() ?? '';
  if (message.isEmpty) return fallback;
  if (message.length > 180) return fallback;
  if (_looksTechnical(message)) return fallback;
  return message;
}

bool _looksTechnical(String value) {
  final lowered = value.toLowerCase();
  for (final signal in _technicalErrorSignals) {
    if (lowered.contains(signal)) {
      return true;
    }
  }
  return false;
}

abstract class Failure {
  final String message;
  Failure(this.message);
}

class ServerFailure extends Failure {
  ServerFailure(super.message);
}

class NetworkFailure extends Failure {
  NetworkFailure(super.message);
}

class AuthFailure extends Failure {
  AuthFailure(super.message);
}

enum AppErrorCode {
  // ignore: constant_identifier_names
  MONTHLY_SEARCH_LIMIT_REACHED,
  // ignore: constant_identifier_names
  PLAN_NOT_ALLOWED,
  // ignore: constant_identifier_names
  FEATURE_NOT_AVAILABLE,
  // ignore: constant_identifier_names
  DEVICE_VERIFICATION_FAILED,
  // ignore: constant_identifier_names
  UNKNOWN,
}

class AppException implements Exception {
  final String message;
  final dynamic originalError;
  final AppErrorCode? code;
  final Map<String, dynamic>? details;

  AppException(this.message, [this.originalError, this.code, this.details]);

  factory AppException.fromDio(DioException e) {
    String message;
    AppErrorCode? code;
    Map<String, dynamic>? details;

    if (e.response?.data is Map<String, dynamic>) {
      final data = e.response!.data as Map<String, dynamic>;
      final errorCode = data['code'] as String?;
      details =
          data['quota'] as Map<String, dynamic>? ??
          data['details'] as Map<String, dynamic>?;

      if (errorCode == 'MONTHLY_SEARCH_LIMIT_REACHED') {
        code = AppErrorCode.MONTHLY_SEARCH_LIMIT_REACHED;
        message = 'Monthly search limit reached. Upgrade to continue.';
      } else if (errorCode == 'PLAN_NOT_ALLOWED') {
        code = AppErrorCode.PLAN_NOT_ALLOWED;
        message = 'Feature not allowed on your current plan.';
      } else if (errorCode == 'FEATURE_NOT_AVAILABLE') {
        code = AppErrorCode.FEATURE_NOT_AVAILABLE;
        message = 'This feature is not available.';
      } else if (errorCode == 'DEVICE_VERIFICATION_FAILED') {
        code = AppErrorCode.DEVICE_VERIFICATION_FAILED;
        message = 'This account is bound to another device.';
      } else {
        message = data['message'] ?? 'An error occurred.';
      }
    } else {
      message = 'Something went wrong.';
    }

    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        message = 'Connection timed out. Please check your internet.';
        break;
      case DioExceptionType.badResponse:
        final statusCode = e.response?.statusCode;
        if (statusCode == 429 &&
            code == AppErrorCode.MONTHLY_SEARCH_LIMIT_REACHED) {
          // Already handled above
        } else if (statusCode == 401) {
          if (code == AppErrorCode.DEVICE_VERIFICATION_FAILED) {
            // Already handled
          } else {
            message = 'Unauthorized. Please login again.';
          }
        } else if (statusCode == 403) {
          message = message == 'Something went wrong.'
              ? 'Access denied.'
              : message;
        } else if (statusCode == 404) {
          message = 'Resource not found.';
        } else if (statusCode != null && statusCode >= 500) {
          message = 'Server error. Please try again later.';
        }
        break;
      case DioExceptionType.cancel:
        message = 'Request cancelled.';
        break;
      case DioExceptionType.connectionError:
        message = 'No internet connection.';
        break;
      default:
        break;
    }
    final path = e.requestOptions.path.toLowerCase();
    final fallback = path.contains('search')
        ? kSearchUnavailableMessage
        : kGenericUserErrorMessage;
    return AppException(
      _sanitizeForUser(message, fallback: fallback),
      e,
      code,
      details,
    );
  }

  factory AppException.unknown(dynamic e) {
    if (e is AppException) return e;
    final raw = e?.toString() ?? '';
    final lowered = raw.toLowerCase();
    final fallback = lowered.contains('search')
        ? kSearchUnavailableMessage
        : kGenericUserErrorMessage;
    return AppException(_sanitizeForUser(raw, fallback: fallback), e);
  }

  @override
  String toString() => message;
}

class AppErrorMapper {
  static String map(dynamic error) {
    if (error is AppException) {
      return _sanitizeForUser(error.message);
    }
    if (error is DioException) {
      return AppException.fromDio(error).message;
    }
    return _sanitizeForUser(error?.toString());
  }
}
