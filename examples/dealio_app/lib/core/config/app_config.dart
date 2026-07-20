import 'package:flutter/foundation.dart';

/// Runtime configuration supplied with --dart-define.
final class AppConfig {
  static const apiBaseUrlFromEnvironment = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: '',
  );

  static String get apiBaseUrl {
    final configured = apiBaseUrlFromEnvironment.trim();
    if (configured.isNotEmpty) return _normalizeBaseUrl(configured);
    if (kReleaseMode) return 'https://api.clario.com/api';
    if (kIsWeb) return 'http://localhost:3000/api';
    if (defaultTargetPlatform == TargetPlatform.android) {
      return 'http://10.0.2.2:3000/api';
    }
    return 'http://localhost:3000/api';
  }

  static String _normalizeBaseUrl(String input) {
    final withScheme = input.contains('://') ? input : 'https://$input';
    final uri = Uri.tryParse(withScheme);
    if (uri == null || uri.host.isEmpty) {
      throw StateError('Invalid API_BASE_URL.');
    }
    if (kReleaseMode && uri.scheme != 'https') {
      throw StateError('API_BASE_URL must use HTTPS in release builds.');
    }
    final withoutTrailingSlash = withScheme.endsWith('/')
        ? withScheme.substring(0, withScheme.length - 1)
        : withScheme;
    return withoutTrailingSlash.endsWith('/api')
        ? withoutTrailingSlash
        : '$withoutTrailingSlash/api';
  }
}
