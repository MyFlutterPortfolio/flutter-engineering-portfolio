import 'dart:math';

import 'package:untitled5/core/models/product_model.dart';
import 'package:untitled5/core/models/search_models.dart';
import 'package:untitled5/core/models/subscription_model.dart';

class SearchDemoData {
  static final _rnd = Random();

  static final List<Country> countries = <Country>[
    const Country(
      code: 'US',
      name: 'United States',
      gl: 'us',
      hl: 'en',
      location: 'United States',
    ),
    const Country(
      code: 'GB',
      name: 'United Kingdom',
      gl: 'gb',
      hl: 'en',
      location: 'United Kingdom',
    ),
    const Country(
      code: 'DE',
      name: 'Germany',
      gl: 'de',
      hl: 'de',
      location: 'Germany',
    ),
    const Country(
      code: 'FR',
      name: 'France',
      gl: 'fr',
      hl: 'fr',
      location: 'France',
    ),
    const Country(
      code: 'CA',
      name: 'Canada',
      gl: 'ca',
      hl: 'en',
      location: 'Canada',
    ),
    const Country(
      code: 'AU',
      name: 'Australia',
      gl: 'au',
      hl: 'en',
      location: 'Australia',
    ),
    const Country(
      code: 'IN',
      name: 'India',
      gl: 'in',
      hl: 'en',
      location: 'India',
    ),
    const Country(
      code: 'UZ',
      name: 'Uzbekistan',
      gl: 'uz',
      hl: 'uz',
      location: 'Uzbekistan',
    ),
    const Country(
      code: 'ES',
      name: 'Spain',
      gl: 'es',
      hl: 'es',
      location: 'Spain',
    ),
    const Country(
      code: 'IT',
      name: 'Italy',
      gl: 'it',
      hl: 'it',
      location: 'Italy',
    ),
    const Country(
      code: 'NL',
      name: 'Netherlands',
      gl: 'nl',
      hl: 'nl',
      location: 'Netherlands',
    ),
    const Country(
      code: 'BE',
      name: 'Belgium',
      gl: 'be',
      hl: 'nl',
      location: 'Belgium',
    ),
    const Country(
      code: 'CH',
      name: 'Switzerland',
      gl: 'ch',
      hl: 'de',
      location: 'Switzerland',
    ),
    const Country(
      code: 'AT',
      name: 'Austria',
      gl: 'at',
      hl: 'de',
      location: 'Austria',
    ),
    const Country(
      code: 'SE',
      name: 'Sweden',
      gl: 'se',
      hl: 'sv',
      location: 'Sweden',
    ),
    const Country(
      code: 'NO',
      name: 'Norway',
      gl: 'no',
      hl: 'no',
      location: 'Norway',
    ),
    const Country(
      code: 'DK',
      name: 'Denmark',
      gl: 'dk',
      hl: 'da',
      location: 'Denmark',
    ),
    const Country(
      code: 'FI',
      name: 'Finland',
      gl: 'fi',
      hl: 'fi',
      location: 'Finland',
    ),
    const Country(
      code: 'JP',
      name: 'Japan',
      gl: 'jp',
      hl: 'ja',
      location: 'Japan',
    ),
    const Country(
      code: 'KR',
      name: 'South Korea',
      gl: 'kr',
      hl: 'ko',
      location: 'South Korea',
    ),
    const Country(
      code: 'SG',
      name: 'Singapore',
      gl: 'sg',
      hl: 'en',
      location: 'Singapore',
    ),
    const Country(
      code: 'MY',
      name: 'Malaysia',
      gl: 'my',
      hl: 'ms',
      location: 'Malaysia',
    ),
    const Country(
      code: 'ID',
      name: 'Indonesia',
      gl: 'id',
      hl: 'id',
      location: 'Indonesia',
    ),
    const Country(
      code: 'TH',
      name: 'Thailand',
      gl: 'th',
      hl: 'th',
      location: 'Thailand',
    ),
    const Country(
      code: 'AE',
      name: 'United Arab Emirates',
      gl: 'ae',
      hl: 'en',
      location: 'United Arab Emirates',
    ),
    const Country(
      code: 'SA',
      name: 'Saudi Arabia',
      gl: 'sa',
      hl: 'ar',
      location: 'Saudi Arabia',
    ),
    const Country(
      code: 'TR',
      name: 'Turkey',
      gl: 'tr',
      hl: 'tr',
      location: 'Turkey',
    ),
    const Country(
      code: 'BR',
      name: 'Brazil',
      gl: 'br',
      hl: 'pt',
      location: 'Brazil',
    ),
    const Country(
      code: 'MX',
      name: 'Mexico',
      gl: 'mx',
      hl: 'es',
      location: 'Mexico',
    ),
    const Country(
      code: 'AR',
      name: 'Argentina',
      gl: 'ar',
      hl: 'es',
      location: 'Argentina',
    ),
    const Country(
      code: 'CL',
      name: 'Chile',
      gl: 'cl',
      hl: 'es',
      location: 'Chile',
    ),
    const Country(
      code: 'CO',
      name: 'Colombia',
      gl: 'co',
      hl: 'es',
      location: 'Colombia',
    ),
    const Country(code: 'PE', name: 'Peru', gl: 'pe', hl: 'es', location: 'Peru'),
    const Country(
      code: 'PT',
      name: 'Portugal',
      gl: 'pt',
      hl: 'pt',
      location: 'Portugal',
    ),
    const Country(code: 'PL', name: 'Poland', gl: 'pl', hl: 'pl', location: 'Poland'),
    const Country(
      code: 'CZ',
      name: 'Czechia',
      gl: 'cz',
      hl: 'cs',
      location: 'Czechia',
    ),
    const Country(
      code: 'HU',
      name: 'Hungary',
      gl: 'hu',
      hl: 'hu',
      location: 'Hungary',
    ),
    const Country(
      code: 'RO',
      name: 'Romania',
      gl: 'ro',
      hl: 'ro',
      location: 'Romania',
    ),
    const Country(
      code: 'IE',
      name: 'Ireland',
      gl: 'ie',
      hl: 'en',
      location: 'Ireland',
    ),
    const Country(
      code: 'NZ',
      name: 'New Zealand',
      gl: 'nz',
      hl: 'en',
      location: 'New Zealand',
    ),
    const Country(
      code: 'PH',
      name: 'Philippines',
      gl: 'ph',
      hl: 'en',
      location: 'Philippines',
    ),
    const Country(
      code: 'VN',
      name: 'Vietnam',
      gl: 'vn',
      hl: 'vi',
      location: 'Vietnam',
    ),
    const Country(
      code: 'HK',
      name: 'Hong Kong',
      gl: 'hk',
      hl: 'zh',
      location: 'Hong Kong',
    ),
    const Country(
      code: 'TW',
      name: 'Taiwan',
      gl: 'tw',
      hl: 'zh',
      location: 'Taiwan',
    ),
    const Country(
      code: 'IL',
      name: 'Israel',
      gl: 'il',
      hl: 'he',
      location: 'Israel',
    ),
    const Country(
      code: 'ZA',
      name: 'South Africa',
      gl: 'za',
      hl: 'en',
      location: 'South Africa',
    ),
  ];

  static final List<Store> _globalStores = <Store>[
    const Store(name: 'Amazon', domains: ['amazon.com'], countryCode: ''),
    const Store(name: 'eBay', domains: ['ebay.com'], countryCode: ''),
    const Store(name: 'Walmart', domains: ['walmart.com'], countryCode: ''),
    const Store(name: 'Best Buy', domains: ['bestbuy.com'], countryCode: ''),
    const Store(name: 'Target', domains: ['target.com'], countryCode: ''),
    const Store(name: 'AliExpress', domains: ['aliexpress.com'], countryCode: ''),
    const Store(name: 'Newegg', domains: ['newegg.com'], countryCode: ''),
    const Store(name: 'Temu', domains: ['temu.com'], countryCode: ''),
    const Store(name: 'Rakuten', domains: ['rakuten.com'], countryCode: ''),
    const Store(name: 'Noon', domains: ['noon.com'], countryCode: ''),
    const Store(name: 'MediaMarkt', domains: ['mediamarkt.com'], countryCode: ''),
    const Store(name: 'Shopee', domains: ['shopee.com'], countryCode: ''),
  ];

  static List<Store> storesForCountry(
    String countryCode, {
    String? query,
    int limit = 20,
  }) {
    final cc = countryCode.trim().toUpperCase();
    final localized = _globalStores
        .map((s) => Store(
              name: s.name,
              domains: s.domains,
              countryCode: cc,
            ))
        .toList();

    final q = (query ?? '').trim().toLowerCase();
    final filtered = q.isEmpty
        ? localized
        : localized
            .where((s) => s.name.toLowerCase().contains(q))
            .toList();

    final safeLimit = limit.clamp(1, 100).toInt();
    return filtered.take(safeLimit).toList();
  }

  static SearchResponse buildSearchResponse(SearchRequest request) {
    final q = request.query.trim();
    final baseName = q.isEmpty ? 'Product' : q;
    final stores = storesForCountry(
      request.country,
      limit: request.storeScope == 'selected' ? 14 : 12,
    );

    final selected = request.selectedStores ?? const <String>[];
    final selectedSet = selected.map((s) => s.toLowerCase().trim()).toSet();
    final usableStores = request.storeScope == 'selected' && selectedSet.isNotEmpty
        ? stores.where((s) => selectedSet.contains(s.name.toLowerCase())).toList()
        : stores;
    final effectiveStores = usableStores.isEmpty ? stores : usableStores;

    final budget = request.budget ?? 1000;
    final names = <String>[
      '$baseName Pro',
      '$baseName Plus',
      '$baseName Lite',
      '$baseName Max',
      '$baseName Neo',
    ];

    final products = <Product>[];
    for (var i = 0; i < names.length; i++) {
      final basePrice = max(40, budget * (0.75 + (i * 0.08)));
      final prices = <DynamicPrice>[];
      final takeStores = effectiveStores.take(10).toList();
      for (var si = 0; si < takeStores.length; si++) {
        final s = takeStores[si];
        final price = (basePrice + (si * 7.5) + _rnd.nextDouble() * 5)
            .toStringAsFixed(2);
        prices.add(
          DynamicPrice(
            store: s.name,
            price: double.parse(price),
            currency: 'USD',
            link: 'https://${s.domains.first}/search?q=${Uri.encodeComponent(names[i])}',
            availability: true,
            stock: 10 + i + si,
          ),
        );
      }
      prices.sort((a, b) => a.price.compareTo(b.price));

      final match = max(62, 94 - (i * 6));
      final confidence = max(68, 96 - (i * 5));
      final DynamicPrice? best = prices.isNotEmpty ? prices.first : null;

      products.add(
        Product(
          id: 'demo-${request.country.toLowerCase()}-${i + 1}',
          modelName: names[i],
          title: names[i],
          description:
              'Demo result for "$baseName". Personalized ranking based on your notes, budget and selected country.',
          brand: baseName.split(' ').first,
          category: 'Electronics',
          imageUrl:
              'https://images.unsplash.com/photo-1511707171634-5f897ff02aa9?w=1200',
          specifications: <String, dynamic>{
            'country': request.country,
            'searchMode': request.storeScope,
            'demo': true,
          },
          dynamicPrices: prices,
          aiAnalysis: AIAnalysis(
            needsMatchScore: match.toDouble(),
            confidence: confidence.toDouble(),
            recommendationForUser: i == 0
                ? 'Best match for your needs now. Buy from ${best?.store ?? "top store"} while price is stable.'
                : i == 1
                    ? 'Strong alternative if you want better value-to-price balance.'
                    : 'Good option, but slightly weaker fit than top picks.',
            fitSummary:
                'This result aligns with your budget and user notes in demo mode.',
            budgetFit: (best != null && best.price <= budget)
                ? 'Under Budget'
                : 'At Budget Edge',
            finalShoppingVerdict: i == 0
                ? 'Recommended'
                : i < 3
                    ? 'Consider Alternatives'
                    : 'Not Recommended',
            marketSentiment: i == 0
                ? 'High positive trend'
                : 'Mixed but acceptable',
            authenticityReport: 'Verified',
            prosForUser: <String>[
              'Strong fit to your stated needs',
              'Competitive pricing across stores',
            ],
            consForUser: <String>[
              'Price can change quickly',
            ],
            cautionFlags: <String>[
              'Confirm seller warranty before checkout',
            ],
            alternatives: names
                .where((n) => n != names[i])
                .take(3)
                .toList(),
            reasoning:
                'Demo AI: scored against your query intent, budget, and store availability.',
          ),
        ),
      );
    }

    final offers = <StoreOffer>[];
    for (final p in products) {
      final DynamicPrice? best = p.dynamicPrices.isNotEmpty
          ? p.dynamicPrices.first
          : null;
      if (best == null) continue;
      offers.add(
        StoreOffer(
          store: best.store,
          price: best.price,
          currency: best.currency,
          link: best.link,
          availability: best.availability,
          stock: best.stock,
          productId: p.id,
          productTitle: p.title,
        ),
      );
    }
    offers.sort((a, b) => a.price.compareTo(b.price));

    return SearchResponse(
      query: request.query,
      count: products.length,
      results: products,
      country: request.country,
      storeScope: request.storeScope,
      selectedStores: request.selectedStores ?? const <String>[],
      selectedStoreLinks: const <String>[],
      storeOffers: offers.take(10).toList(),
      aiAnalysisDeferred: false,
      requestId: null,
      stage: 3,
      isPartial: false,
      nextPollMs: null,
      statusEndpoint: null,
      stage1Source: 'demo-local',
      aiSummaryRequestId: null,
      timestamp: DateTime.now().toIso8601String(),
      plan: SubscriptionPlan.KVONT,
      searchProvider: 'demo-local',
      quota: QuotaInfo(
        search: SearchQuota(
          used: 3,
          limit: 100,
          remaining: 97,
          resetAt: DateTime.now()
              .add(const Duration(days: 24))
              .toIso8601String(),
          allowed: true,
        ),
      ),
    );
  }
}
