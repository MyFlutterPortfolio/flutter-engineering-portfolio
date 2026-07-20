import 'package:flutter_test/flutter_test.dart';
import 'package:untitled5/core/utils/safe_url_launcher.dart';

void main() {
  group('parseExternalWebUri', () {
    test('accepts http and https URLs with a host', () {
      expect(
        parseExternalWebUri('https://example.com/deal')?.host,
        'example.com',
      );
      expect(parseExternalWebUri(' http://shop.example ')?.scheme, 'http');
    });

    test('rejects unsafe schemes and malformed URLs', () {
      expect(parseExternalWebUri('javascript:alert(1)'), isNull);
      expect(parseExternalWebUri('file:///etc/passwd'), isNull);
      expect(parseExternalWebUri('https://'), isNull);
      expect(parseExternalWebUri('example.com'), isNull);
    });
  });
}
