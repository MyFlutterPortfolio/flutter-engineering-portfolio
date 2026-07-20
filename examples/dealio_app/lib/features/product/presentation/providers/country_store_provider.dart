import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled5/core/models/search_models.dart';
import 'package:untitled5/features/product/presentation/providers/product_provider.dart';

// Countries Provider with memory + disk cache
final countriesProvider = FutureProvider<List<Country>>((ref) async {
  final repository = ref.watch(productRepositoryProvider);
  final prefs = await SharedPreferences.getInstance();

  final cachedData = prefs.getString('cached_countries');
  final cachedCountries = _decodeCountries(cachedData);

  try {
    final countries = await repository.getCountries();
    await prefs.setString(
      'cached_countries',
      json.encode(countries.map((e) => e.toJson()).toList()),
    );
    return countries;
  } catch (e) {
    if (cachedCountries != null) return cachedCountries;
    rethrow;
  }
});

List<Country>? _decodeCountries(String? rawJson) {
  if (rawJson == null || rawJson.isEmpty) return null;

  try {
    final decoded = json.decode(rawJson);
    if (decoded is! List) return null;

    return decoded
        .whereType<Map>()
        .map((item) => Country.fromJson(Map<String, dynamic>.from(item)))
        .toList(growable: false);
  } catch (_) {
    return null;
  }
}

// Persistence for last selected country
final lastSelectedCountryProvider =
    StateNotifierProvider<LastCountryNotifier, Country?>((ref) {
      return LastCountryNotifier(ref);
    });

class LastCountryNotifier extends StateNotifier<Country?> {
  final Ref _ref;
  LastCountryNotifier(this._ref) : super(null) {
    _load();
  }

  static const _key = 'last_selected_country_code';

  Future<void> _load() async {
    final prefs = await SharedPreferences.getInstance();
    final code = prefs.getString(_key) ?? 'US';

    // Wait for countries to be available
    _ref.listen<AsyncValue<List<Country>>>(countriesProvider, (previous, next) {
      if (next is AsyncData<List<Country>>) {
        final countries = next.value;
        final match = countries.firstWhere(
          (c) => c.code == code,
          orElse: () => countries.isNotEmpty
              ? countries.first
              : const Country(
                  code: 'US',
                  name: 'United States',
                  gl: 'us',
                  hl: 'en',
                  location: 'United States',
                ),
        );
        state = match;
      }
    }, fireImmediately: true);
  }

  Future<void> select(Country country) async {
    state = country;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key, country.code);
  }
}

// Stores Search Provider with Debounce and CancelToken
final storeSearchProvider =
    StateNotifierProvider<StoreSearchNotifier, AsyncValue<List<Store>>>((ref) {
      return StoreSearchNotifier(ref);
    });

class StoreSearchNotifier extends StateNotifier<AsyncValue<List<Store>>> {
  final Ref ref;
  Timer? _debounce;
  CancelToken? _cancelToken;

  StoreSearchNotifier(this.ref) : super(const AsyncValue.data([]));

  void search({required String countryCode, String query = ''}) {
    _debounce?.cancel();

    if (countryCode.isEmpty) {
      state = const AsyncValue.data([]);
      return;
    }

    _debounce = Timer(const Duration(milliseconds: 400), () async {
      _cancelToken?.cancel();
      _cancelToken = CancelToken();

      state = const AsyncValue.loading();

      try {
        final repository = ref.read(productRepositoryProvider);
        final stores = await repository.searchStores(
          country: countryCode,
          q: query,
          limit: 20,
          cancelToken: _cancelToken,
        );
        state = AsyncValue.data(stores);
      } catch (e, stack) {
        if (e is DioException && CancelToken.isCancel(e)) return;
        state = AsyncValue.error(e, stack);
      }
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _cancelToken?.cancel();
    super.dispose();
  }
}
