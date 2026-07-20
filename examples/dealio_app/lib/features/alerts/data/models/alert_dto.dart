import 'package:untitled5/features/alerts/domain/entities/alert_entity.dart';

class AlertDto {
  final String id;
  final String productId;
  final String productTitle;
  final String? productImage;
  final double? targetPrice;
  final String alertType;
  final int cooldownMinutes;
  final bool isActive;
  final int triggeredCount;
  final DateTime? lastTriggeredAt;
  final List<AlertEventDto> recentEvents;
  final DateTime createdAt;

  AlertDto({
    required this.id,
    required this.productId,
    required this.productTitle,
    this.productImage,
    this.targetPrice,
    required this.alertType,
    required this.cooldownMinutes,
    required this.isActive,
    required this.triggeredCount,
    this.lastTriggeredAt,
    required this.recentEvents,
    required this.createdAt,
  });

  factory AlertDto.fromJson(Map<String, dynamic> json) {
    final eventsRaw =
        (json['events'] as List?) ??
        (json['latestEvents'] as List?) ??
        const [];

    return AlertDto(
      id: (json['id'] ?? '').toString(),
      productId: (json['productId'] ?? '').toString(),
      productTitle: (json['product']?['title'] ?? 'Unknown Product').toString(),
      productImage: json['product']?['imageUrl'],
      targetPrice: json['targetPrice']?.toDouble(),
      alertType: (json['alertType'] ?? 'PRICE_DROP').toString(),
      cooldownMinutes: json['cooldownMinutes'] ?? 60,
      isActive: json['isActive'] ?? true,
      triggeredCount: json['triggeredCount'] ?? 0,
      lastTriggeredAt:
          (json['lastTriggeredAt'] ?? json['lastTriggered']) != null
          ? DateTime.tryParse(
              (json['lastTriggeredAt'] ?? json['lastTriggered']).toString(),
            )
          : null,
      recentEvents: eventsRaw
          .whereType<Map>()
          .map((e) => AlertEventDto.fromJson(Map<String, dynamic>.from(e)))
          .toList(),
      createdAt:
          DateTime.tryParse((json['createdAt'] ?? '').toString()) ??
          DateTime.now(),
    );
  }

  AlertEntity toEntity() {
    return AlertEntity(
      id: id,
      productId: productId,
      productTitle: productTitle,
      productImage: productImage,
      targetPrice: targetPrice,
      alertType: AlertType.values.firstWhere(
        (e) => e.name == alertType,
        orElse: () => AlertType.PRICE_DROP,
      ),
      cooldownMinutes: cooldownMinutes,
      isActive: isActive,
      triggeredCount: triggeredCount,
      lastTriggeredAt: lastTriggeredAt,
      recentEvents: recentEvents.map((e) => e.toEntity()).toList(),
      createdAt: createdAt,
    );
  }
}

class AlertEventDto {
  final String id;
  final String productId;
  final String eventType;
  final String message;
  final double? triggerPrice;
  final double? targetPrice;
  final String? currency;
  final String? store;
  final String? storeLink;
  final DateTime createdAt;

  AlertEventDto({
    required this.id,
    required this.productId,
    required this.eventType,
    required this.message,
    this.triggerPrice,
    this.targetPrice,
    this.currency,
    this.store,
    this.storeLink,
    required this.createdAt,
  });

  factory AlertEventDto.fromJson(Map<String, dynamic> json) {
    return AlertEventDto(
      id: (json['id'] ?? '').toString(),
      productId: (json['productId'] ?? '').toString(),
      eventType: (json['eventType'] ?? '').toString(),
      message: (json['message'] ?? '').toString(),
      triggerPrice: json['triggerPrice']?.toDouble(),
      targetPrice: json['targetPrice']?.toDouble(),
      currency: json['currency'],
      store: json['store'],
      storeLink: json['storeLink'],
      createdAt:
          DateTime.tryParse((json['createdAt'] ?? '').toString()) ??
          DateTime.now(),
    );
  }

  AlertEventEntity toEntity() {
    return AlertEventEntity(
      id: id,
      productId: productId,
      eventType: eventType,
      message: message,
      triggerPrice: triggerPrice,
      targetPrice: targetPrice,
      currency: currency,
      store: store,
      storeLink: storeLink,
      createdAt: createdAt,
    );
  }
}

class RealtimePriceQuoteDto {
  final String productId;
  final String productTitle;
  final String query;
  final DateTime sampledAt;
  final String currency;
  final double? confidence;
  final String? storeLink;
  final String? storeDomain;
  final double? currentPrice;
  final double? lowestPrice;
  final double? highestPrice;
  final double? recommendedTargetPrice;
  final double? suggestedDropPercent;
  final double? suggestedDropAmount;
  final List<RealtimeTrendPointDto> trendPoints;
  final List<RealtimeOfferDto> offers;

  RealtimePriceQuoteDto({
    required this.productId,
    required this.productTitle,
    required this.query,
    required this.sampledAt,
    required this.currency,
    this.confidence,
    this.storeLink,
    this.storeDomain,
    required this.currentPrice,
    required this.lowestPrice,
    required this.highestPrice,
    required this.recommendedTargetPrice,
    required this.suggestedDropPercent,
    required this.suggestedDropAmount,
    required this.trendPoints,
    required this.offers,
  });

  factory RealtimePriceQuoteDto.fromJson(Map<String, dynamic> json) {
    final trendRaw = (json['trendPoints'] as List?) ?? const [];
    final offersRaw = (json['offers'] as List?) ?? const [];

    return RealtimePriceQuoteDto(
      productId: (json['productId'] ?? '').toString(),
      productTitle: (json['productTitle'] ?? '').toString(),
      query: (json['query'] ?? '').toString(),
      sampledAt:
          DateTime.tryParse((json['sampledAt'] ?? '').toString()) ??
          DateTime.now(),
      currency: (json['currency'] ?? 'USD').toString(),
      confidence: (json['confidence'] as num?)?.toDouble(),
      storeLink: json['storeLink']?.toString(),
      storeDomain: json['storeDomain']?.toString(),
      currentPrice: (json['currentPrice'] as num?)?.toDouble(),
      lowestPrice: (json['lowestPrice'] as num?)?.toDouble(),
      highestPrice: (json['highestPrice'] as num?)?.toDouble(),
      recommendedTargetPrice: (json['recommendedTargetPrice'] as num?)
          ?.toDouble(),
      suggestedDropPercent: (json['suggestedDropPercent'] as num?)?.toDouble(),
      suggestedDropAmount: (json['suggestedDropAmount'] as num?)?.toDouble(),
      trendPoints: trendRaw
          .whereType<Map>()
          .map(
            (item) =>
                RealtimeTrendPointDto.fromJson(Map<String, dynamic>.from(item)),
          )
          .toList(),
      offers: offersRaw
          .whereType<Map>()
          .map(
            (item) =>
                RealtimeOfferDto.fromJson(Map<String, dynamic>.from(item)),
          )
          .toList(),
    );
  }

  RealtimePriceQuoteEntity toEntity() {
    return RealtimePriceQuoteEntity(
      productId: productId,
      productTitle: productTitle,
      query: query,
      sampledAt: sampledAt,
      currency: currency,
      confidence: confidence,
      storeLink: storeLink,
      storeDomain: storeDomain,
      currentPrice: currentPrice,
      lowestPrice: lowestPrice,
      highestPrice: highestPrice,
      recommendedTargetPrice: recommendedTargetPrice,
      suggestedDropPercent: suggestedDropPercent,
      suggestedDropAmount: suggestedDropAmount,
      trendPoints: trendPoints.map((e) => e.toEntity()).toList(),
      offers: offers.map((e) => e.toEntity()).toList(),
    );
  }
}

class RealtimeTrendPointDto {
  final DateTime timestamp;
  final double price;
  final String currency;
  final String store;
  final String storeLink;
  final bool availability;

  RealtimeTrendPointDto({
    required this.timestamp,
    required this.price,
    required this.currency,
    required this.store,
    required this.storeLink,
    required this.availability,
  });

  factory RealtimeTrendPointDto.fromJson(Map<String, dynamic> json) {
    return RealtimeTrendPointDto(
      timestamp:
          DateTime.tryParse((json['timestamp'] ?? '').toString()) ??
          DateTime.now(),
      price: (json['price'] as num?)?.toDouble() ?? 0,
      currency: (json['currency'] ?? 'USD').toString(),
      store: (json['store'] ?? '').toString(),
      storeLink: (json['storeLink'] ?? '').toString(),
      availability: json['availability'] == true,
    );
  }

  RealtimeTrendPointEntity toEntity() {
    return RealtimeTrendPointEntity(
      timestamp: timestamp,
      price: price,
      currency: currency,
      store: store,
      storeLink: storeLink,
      availability: availability,
    );
  }
}

class RealtimeOfferDto {
  final String store;
  final double price;
  final String currency;
  final String link;
  final bool availability;
  final int stock;
  final String productTitle;
  final String productId;
  final String? source;
  final double? confidence;

  RealtimeOfferDto({
    required this.store,
    required this.price,
    required this.currency,
    required this.link,
    required this.availability,
    required this.stock,
    required this.productTitle,
    required this.productId,
    this.source,
    this.confidence,
  });

  factory RealtimeOfferDto.fromJson(Map<String, dynamic> json) {
    return RealtimeOfferDto(
      store: (json['store'] ?? '').toString(),
      price: (json['price'] as num?)?.toDouble() ?? 0,
      currency: (json['currency'] ?? 'USD').toString(),
      link: (json['link'] ?? '').toString(),
      availability: json['availability'] == true,
      stock: (json['stock'] as num?)?.toInt() ?? 0,
      productTitle: (json['productTitle'] ?? '').toString(),
      productId: (json['productId'] ?? '').toString(),
      source: json['source']?.toString(),
      confidence: (json['confidence'] as num?)?.toDouble(),
    );
  }

  RealtimeOfferEntity toEntity() {
    return RealtimeOfferEntity(
      store: store,
      price: price,
      currency: currency,
      link: link,
      availability: availability,
      stock: stock,
      productTitle: productTitle,
      productId: productId,
      source: source,
      confidence: confidence,
    );
  }
}
