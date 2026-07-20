class StoreLinkNormalizer {
  static String normalize(String url) {
    if (url.isEmpty) return url;

    String normalized = url.trim();

    // Ensure it starts with https:// if it doesn't have a protocol
    if (!normalized.startsWith(RegExp(r'^https?://'))) {
      normalized = 'https://$normalized';
    }

    try {
      final uri = Uri.parse(normalized);
      // We return the full valid URL for production AI mode
      return uri.toString();
    } catch (_) {
      return url;
    }
  }

  static String getDomain(String url) {
    try {
      String normalized = url.trim();
      if (!normalized.startsWith(RegExp(r'^https?://'))) {
        normalized = 'https://$normalized';
      }
      final uri = Uri.parse(normalized);
      return uri.host.replaceFirst('www.', '');
    } catch (_) {
      return url;
    }
  }
}
