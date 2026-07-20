import 'package:url_launcher/url_launcher.dart';

const Set<String> _externalWebSchemes = {'http', 'https'};

Uri? parseExternalWebUri(String rawUrl) {
  final uri = Uri.tryParse(rawUrl.trim());
  if (uri == null || uri.host.isEmpty) return null;
  if (!_externalWebSchemes.contains(uri.scheme.toLowerCase())) return null;
  return uri;
}

Future<bool> launchExternalWebUrl(String rawUrl) async {
  final uri = parseExternalWebUri(rawUrl);
  if (uri == null || !await canLaunchUrl(uri)) return false;

  return launchUrl(uri, mode: LaunchMode.externalApplication);
}
