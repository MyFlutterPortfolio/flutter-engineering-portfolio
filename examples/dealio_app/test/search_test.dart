import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:untitled5/core/models/search_models.dart';
import 'package:untitled5/core/network/failures.dart';

void main() {
  group('Search Models Parsing', () {
    test('SearchResponse parses correctly from JSON', () {
      final json = <String, dynamic>{
        'query': 'iphone',
        'count': 1,
        'results': <Map<String, dynamic>>[
          <String, dynamic>{
            'id': '1',
            'title': 'iPhone 13',
            'brand': 'Apple',
            'category': 'Phones',
            'specifications': <String, dynamic>{},
            'dynamicPrices': <Map<String, dynamic>>[],
          },
        ],
        'country': 'US',
        'storeScope': 'global',
        'aiAnalysisDeferred': true,
        'aiSummaryRequestId': 'req_123',
        'timestamp': '2023-01-01T00:00:00Z',
      };

      final response = SearchResponse.fromJson(json);
      expect(response.query, 'iphone');
      expect(response.aiAnalysisDeferred, true);
      expect(response.results.first.title, 'iPhone 13');
    });

    test('AIStatusResponse parses correctly from JSON', () {
      final json = <String, dynamic>{
        'status': 'ready',
        'requestId': 'req_123',
        'results': <Map<String, dynamic>>[
          <String, dynamic>{
            'productId': '1',
            'aiAnalysis': <String, dynamic>{
              'sentimentScore': 0.9,
              'pros': <String>['Fast'],
              'cons': <String>['Expensive'],
            },
          },
        ],
      };

      final response = AIStatusResponse.fromJson(json);
      expect(response.status, 'ready');
      expect(response.results.first.aiAnalysis.pros, contains('Fast'));
    });
  });

  group('AppErrorMapper', () {
    test('maps 401 to unauthorized message', () {
      final dioError = DioException(
        requestOptions: RequestOptions(path: ''),
        response: Response(
          requestOptions: RequestOptions(path: ''),
          statusCode: 401,
        ),
        type: DioExceptionType.badResponse,
      );

      final message = AppErrorMapper.map(dioError);
      expect(message, contains('Unauthorized'));
    });

    test('maps connection timeout', () {
      final dioError = DioException(
        requestOptions: RequestOptions(path: ''),
        type: DioExceptionType.connectionTimeout,
      );

      final message = AppErrorMapper.map(dioError);
      expect(message, contains('Connection timed out'));
    });
  });
}
