import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:untitled5/core/models/product_model.dart';
import 'package:untitled5/core/models/search_models.dart';
import 'package:untitled5/features/search/domain/repositories/search_repository.dart';
import 'package:untitled5/features/search/presentation/providers/search_provider.dart';
import 'package:untitled5/features/search/presentation/providers/search_state.dart';

import 'search_polling_test.mocks.dart';

@GenerateMocks([SearchRepository])
void main() {
  late MockSearchRepository mockRepository;
  late ProviderContainer container;

  setUp(() {
    mockRepository = MockSearchRepository();
    container = ProviderContainer(
      overrides: [searchRepositoryProvider.overrideWithValue(mockRepository)],
    );
  });

  tearDown(() => container.dispose());

  test('Search flow: Stage 1 -> AI Polling -> Stage 2 Ready', () async {
    const searchRequest = SearchRequest(query: 'iphone', country: 'US');
    const searchResponse = SearchResponse(
      query: 'iphone',
      count: 1,
      results: [Product(id: '1', title: 'iPhone 13')],
      country: 'US',
      aiAnalysisDeferred: true,
      requestId: 'req_1',
      aiSummaryRequestId: 'req_1',
    );

    final statusReady = SearchSessionStatusResponse(
      status: 'ready',
      stage2: const StageData(
        status: 'ready',
        data: <String, dynamic>{
          'results': <Map<String, dynamic>>[
            <String, dynamic>{
              'id': '1',
              'title': 'iPhone 13',
              'specifications': <String, dynamic>{},
              'dynamicPrices': <Map<String, dynamic>>[],
            },
          ],
          'storeOffers': <Map<String, dynamic>>[],
        },
      ),
      stage3: const StageData(
        status: 'ready',
        data: <String, dynamic>{
          'results': <Map<String, dynamic>>[
            <String, dynamic>{
              'productId': '1',
              'aiAnalysis': <String, dynamic>{
                'needsMatchScore': 95,
                'recommendation_for_user': 'Great fit',
              },
            },
          ],
        },
      ),
    );

    when(
      mockRepository.search(any, cancelToken: anyNamed('cancelToken')),
    ).thenAnswer((_) async => searchResponse);
    when(
      mockRepository.getSearchStatus(
        'req_1',
        cancelToken: anyNamed('cancelToken'),
      ),
    ).thenAnswer((_) async => statusReady);

    final notifier = container.read(searchNotifierProvider.notifier);

    // Start search
    await notifier.search(searchRequest);

    // Initial state should be stage 1 ready (partial payload received)
    expect(
      container.read(searchNotifierProvider).status,
      SearchStatus.stage1Ready,
    );
    expect(
      container.read(searchNotifierProvider).results.first.aiAnalysis,
      isNull,
    );

    // Wait for polling tick (first poll runs after ~1500ms)
    await Future.delayed(const Duration(milliseconds: 2300));

    // Final state should be Stage 3 Ready (polling finalized)
    final finalState = container.read(searchNotifierProvider);
    expect(finalState.status, SearchStatus.stage3Ready);
    expect(finalState.results.first.aiAnalysis?.needsMatchScore, 95);
  });
}
