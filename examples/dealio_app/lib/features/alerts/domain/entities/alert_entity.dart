enum AlertType {
  // ignore: constant_identifier_names
  PRICE_DROP,
  // ignore: constant_identifier_names
  PRICE_SPECIFIC,
  // ignore: constant_identifier_names
  STOCK_AVAILABLE,
  // ignore: constant_identifier_names
  DEAL_ALERT;

  String get label {
    switch (this) {
      case AlertType.PRICE_DROP:
        return 'Price Drop';
      case AlertType.PRICE_SPECIFIC:
        return 'Price Target';
      case AlertType.STOCK_AVAILABLE:
        return 'In Stock';
      case AlertType.DEAL_ALERT:
        return 'Deal Alert';
    }
  }
}

class AlertEntity {
  final String id;
  final String productId;
  final String productTitle;
  final String? productImage;
  final double? targetPrice;
  final AlertType alertType;
  final int cooldownMinutes;
  final bool isActive;
  final int triggeredCount;
  final DateTime? lastTriggeredAt;
  final List<AlertEventEntity> recentEvents;
  final DateTime createdAt;

  AlertEntity({
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
}

class AlertEventEntity {
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

  AlertEventEntity({
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
}

class RealtimePriceQuoteEntity {
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
  final List<RealtimeTrendPointEntity> trendPoints;
  final List<RealtimeOfferEntity> offers;

  RealtimePriceQuoteEntity({
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
}

class RealtimeTrendPointEntity {
  final DateTime timestamp;
  final double price;
  final String currency;
  final String store;
  final String storeLink;
  final bool availability;

  RealtimeTrendPointEntity({
    required this.timestamp,
    required this.price,
    required this.currency,
    required this.store,
    required this.storeLink,
    required this.availability,
  });
}

class RealtimeOfferEntity {
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

  RealtimeOfferEntity({
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
}
