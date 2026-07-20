import 'package:dio/dio.dart';
import 'package:untitled5/core/models/search_models.dart';
import 'package:untitled5/core/network/failures.dart';
import 'package:untitled5/features/search/data/datasources/search_remote_datasource.dart';
import 'package:untitled5/features/search/domain/repositories/search_repository.dart';

class SearchRepositoryImpl implements SearchRepository {
  final SearchRemoteDataSource _remoteDataSource;

  SearchRepositoryImpl(this._remoteDataSource);

  @override
  Future<SearchResponse> search(
    SearchRequest request, {
    CancelToken? cancelToken,
  }) async {
    try {
      final payload = _buildSearchPayload(request);
      final response = await _remoteDataSource.search(
        payload,
        cancelToken: cancelToken,
      );
      final data = _asJsonMap(response.data);
      if (data != null) {
        return SearchResponse.fromJson(_normalizeQuotaPayload(data));
      }
      throw AppException.unknown('Search response was incomplete.');
    } on DioException {
      rethrow;
    } catch (e) {
      throw AppException.unknown(e);
    }
  }

  @override
  Future<SearchSessionStatusResponse> getSearchStatus(
    String requestId, {
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await _remoteDataSource.searchStatus(
        requestId,
        cancelToken: cancelToken,
      );
      return SearchSessionStatusResponse.fromJson(response.data);
    } on DioException {
      rethrow;
    } catch (e) {
      throw AppException.unknown(e);
    }
  }

  @override
  Future<AIStatusResponse> getAiStatus(
    String requestId, {
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await _remoteDataSource.aiStatus(
        requestId,
        cancelToken: cancelToken,
      );
      return AIStatusResponse.fromJson(response.data);
    } on DioException {
      rethrow;
    } catch (e) {
      throw AppException.unknown(e);
    }
  }

  @override
  Future<List<Country>> getCountries() async {
    try {
      final response = await _remoteDataSource.countries();
      return _parseCountries(response.data);
    } on DioException {
      rethrow;
    } catch (e) {
      throw AppException.unknown(e);
    }
  }

  @override
  Future<List<Store>> getStores(
    String country, {
    String? q,
    int limit = 20,
  }) async {
    try {
      final queryParameters = <String, dynamic>{
        'country': country,
        'limit': limit,
      };
      if (q != null) {
        queryParameters['q'] = q;
      }

      final response = await _remoteDataSource.stores(queryParameters);
      return _parseStores(response.data, country);
    } on DioException {
      rethrow;
    } catch (e) {
      throw AppException.unknown(e);
    }
  }

  @override
  Future<String> scanBarcode(BarcodeRequest request) async {
    try {
      final response = await _remoteDataSource.scanBarcode(request.toJson());
      final data = response.data;
      if (data is Map<String, dynamic>) {
        final barcode = data['barcode'];
        if (barcode is Map<String, dynamic>) {
          final info = barcode['productInfo'];
          if (info is Map<String, dynamic>) {
            final external = info['external'];
            if (external is Map<String, dynamic>) {
              final title = _safeString(external['title']);
              if (title.isNotEmpty) return title;
            }
            final primaryName = _safeString(
              info['detectedProduct'] ??
                  info['productTitle'] ??
                  info['title'] ??
                  info['name'],
            );
            if (primaryName.isNotEmpty) return primaryName;
          }
        }
      }
      return '';
    } on DioException {
      rethrow;
    } catch (e) {
      throw AppException.unknown(e);
    }
  }

  @override
  Future<String> recognizeImage(ImageRecognitionRequest request) async {
    try {
      final response = await _remoteDataSource.recognizeImage(request.toJson());
      final data = response.data;
      if (data is Map<String, dynamic>) {
        final imageAnalysis = data['imageAnalysis'];
        if (imageAnalysis is Map<String, dynamic>) {
          final detected = _safeString(
            imageAnalysis['detectedProduct'] ??
                imageAnalysis['productTitle'] ??
                imageAnalysis['title'],
          );
          if (detected.isNotEmpty) return detected;
        }
      }
      return '';
    } on DioException {
      rethrow;
    } catch (e) {
      throw AppException.unknown(e);
    }
  }

  @override
  Future<SearchResponse> analyzeProduct(Map<String, dynamic> data) async {
    try {
      final response = await _remoteDataSource.analyzeProduct(data);
      final payload = _asJsonMap(response.data);
      if (payload != null) {
        // Clario endpoint has a different shape than /search.
        // Keep this repository method backward-compatible by mapping minimal fields.
        final ai = payload['ai_analysis'] as Map<String, dynamic>? ?? const {};
        final stores = payload['store_results'] as List? ?? const [];
        final offers = <StoreOffer>[];
        for (final store in stores) {
          if (store is! Map<String, dynamic>) continue;
          final selected = store['selected_results'] as List? ?? const [];
          for (final r in selected) {
            if (r is! Map<String, dynamic>) continue;
            final price = _parsePrice(r['priceText']);
            if (price == null) continue;
            offers.add(
              StoreOffer(
                store: _safeString(store['store_domain'], fallback: 'Unknown'),
                price: price,
                currency: 'USD',
                link: _safeString(r['link']),
                availability: true,
                stock: 0,
              ),
            );
          }
        }

        return SearchResponse(
          query: _safeString(payload['normalized_query']?['normalized_query']),
          count: offers.length,
          results: const [],
          country: 'US',
          storeOffers: offers,
          stage: 3,
          isPartial: false,
          aiAnalysisDeferred: false,
          aiSummaryRequestId: ai['requestId']?.toString(),
        );
      }
      throw AppException.unknown('Analysis response was incomplete.');
    } on DioException {
      rethrow;
    } catch (e) {
      throw AppException.unknown(e);
    }
  }

  Map<String, dynamic> _normalizeQuotaPayload(Map<String, dynamic> raw) {
    if (raw['quota'] is! Map<String, dynamic>) {
      return raw;
    }
    final normalized = Map<String, dynamic>.from(raw);
    final quota = Map<String, dynamic>.from(
      normalized['quota'] as Map<String, dynamic>,
    );
    if (quota['search'] is! Map<String, dynamic>) {
      return normalized;
    }
    final search = Map<String, dynamic>.from(
      quota['search'] as Map<String, dynamic>,
    );
    final used = (search['used'] as num?)?.toInt() ?? 0;
    final limit = (search['limit'] as num?)?.toInt() ?? 999999;
    final remaining = (search['remaining'] as num?)?.toInt() ?? (limit - used);
    search['used'] = used < 0 ? 0 : used;
    search['limit'] = limit <= 0 ? 999999 : limit;
    search['remaining'] = remaining < 0 ? 0 : remaining;
    search['allowed'] = search['allowed'] ?? true;
    search['resetAt'] = search['resetAt'] ?? '';
    quota['search'] = search;
    normalized['quota'] = quota;
    return normalized;
  }

  double? _parsePrice(dynamic value) {
    if (value == null) return null;
    final text = _safeString(value);
    if (text.isEmpty) return null;
    final cleaned = text
        .replaceAll(RegExp(r'[^0-9.,]'), '')
        .replaceAll(',', '');
    return double.tryParse(cleaned);
  }

  String _safeString(dynamic value, {String fallback = ''}) {
    final text = value?.toString().trim() ?? fallback;
    if (text.isEmpty) return fallback;
    return text;
  }

  List<Country> _parseCountries(dynamic data) {
    final payload = data is Map<String, dynamic>
        ? data
        : <String, dynamic>{'countries': data};

    final rawCountries =
        (payload['countries'] as List?) ??
        (payload['data'] as List?) ??
        const [];

    return rawCountries.whereType<Map>().map((raw) {
      final map = Map<String, dynamic>.from(raw);
      final code = _safeString(map['code']).toUpperCase();
      final gl = _safeString(map['gl'], fallback: code.toLowerCase());
      final hl = _safeString(map['hl'], fallback: 'en');
      final location = _safeString(
        map['location'],
        fallback: _safeString(map['name']),
      );

      return Country(
        code: code,
        name: _safeString(map['name'], fallback: code),
        gl: gl,
        hl: hl,
        location: location.isEmpty ? code : location,
      );
    }).toList();
  }

  List<Store> _parseStores(dynamic data, String countryCode) {
    final payload = data is Map<String, dynamic>
        ? data
        : <String, dynamic>{'stores': data};

    final rawStores =
        (payload['stores'] as List?) ?? (payload['data'] as List?) ?? const [];

    final selectedCode = countryCode.trim().toUpperCase();
    return rawStores
        .whereType<Map>()
        .map((raw) {
          final map = Map<String, dynamic>.from(raw);
          final domainsRaw = map['domains'];
          final domains = domainsRaw is List
              ? domainsRaw
                    .map((e) => _safeString(e))
                    .where((e) => e.isNotEmpty)
                    .toList()
              : <String>[];

          return Store(
            name: _safeString(map['name'], fallback: 'Unknown Store'),
            domains: domains,
            countryCode: _safeString(
              map['countryCode'],
              fallback: countryCode.toUpperCase(),
            ),
          );
        })
        .where(
          (store) => store.countryCode.trim().toUpperCase() == selectedCode,
        )
        .toList();
  }

  Map<String, dynamic> _buildSearchPayload(SearchRequest request) {
    final payload = Map<String, dynamic>.from(request.toJson());

    // Avoid backend validation failures for optional string fields.
    payload.removeWhere((_, value) => value == null);
    payload.remove('budget');
    final notes = _safeString(payload['notes']);
    if (notes.isEmpty) {
      payload.remove('notes');
    } else {
      payload['notes'] = notes;
    }

    final location = _safeString(payload['location']);
    if (location.isEmpty) {
      payload.remove('location');
    } else {
      payload['location'] = location;
    }

    final selectedStores = <String>{
      ...?request.selectedStores,
    }.map((item) => item.trim()).where((item) => item.isNotEmpty).toList();

    if (selectedStores.isEmpty) {
      payload.remove('selectedStores');
      payload.remove('selectedStoreLinks');
      if (_safeString(payload['storeScope']) == 'selected') {
        payload['storeScope'] = 'global';
      }
      return payload;
    }

    payload['selectedStores'] = selectedStores;
    final selectedStoreLinks = selectedStores
        .where(_looksLikeDomainToken)
        .toSet()
        .toList();
    if (selectedStoreLinks.isNotEmpty) {
      payload['selectedStoreLinks'] = selectedStoreLinks;
    }

    return payload;
  }

  bool _looksLikeDomainToken(String value) {
    final lowered = value.toLowerCase();
    if (lowered.startsWith('http://') || lowered.startsWith('https://')) {
      return true;
    }
    return RegExp(r'^[a-z0-9.-]+\.[a-z]{2,}$').hasMatch(lowered);
  }

  Map<String, dynamic>? _asJsonMap(dynamic value) {
    if (value is Map<String, dynamic>) {
      return value;
    }
    if (value is Map) {
      try {
        return Map<String, dynamic>.from(value);
      } catch (_) {
        return null;
      }
    }
    return null;
  }
}
