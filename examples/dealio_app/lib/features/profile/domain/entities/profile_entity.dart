class ProfileEntity {
  final ProfileUserEntity user;
  final ProfileSubscriptionEntity subscription;
  final ProfileSearchQuotaEntity searchQuota;
  final ProfileCashbackEntity cashback;
  final ProfileAlertsEntity alerts;

  const ProfileEntity({
    required this.user,
    required this.subscription,
    required this.searchQuota,
    required this.cashback,
    required this.alerts,
  });
}

class ProfileUserEntity {
  final String id;
  final String email;
  final String username;
  final String? firstName;
  final String? lastName;
  final String displayName;
  final String? avatar;
  final String language;
  final String currency;
  final String theme;
  final bool emailNotifications;
  final bool priceAlerts;

  const ProfileUserEntity({
    required this.id,
    required this.email,
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.displayName,
    required this.avatar,
    required this.language,
    required this.currency,
    required this.theme,
    required this.emailNotifications,
    required this.priceAlerts,
  });
}

class ProfileSubscriptionEntity {
  final String plan;
  final String status;
  final String? expiresAt;

  const ProfileSubscriptionEntity({
    required this.plan,
    required this.status,
    required this.expiresAt,
  });
}

class ProfileSearchQuotaEntity {
  final bool allowed;
  final int? used;
  final int? limit;
  final int? remaining;
  final String resetAt;

  const ProfileSearchQuotaEntity({
    required this.allowed,
    required this.used,
    required this.limit,
    required this.remaining,
    required this.resetAt,
  });
}

class ProfileCashbackEntity {
  final double balance;
  final String currency;
  final double lifetimeSavings;
  final int pointsCurrent;
  final int pointsTotal;
  final double nextRewardAmount;
  final int totalTriggered;
  final DateTime? lastTriggeredAt;

  const ProfileCashbackEntity({
    required this.balance,
    required this.currency,
    required this.lifetimeSavings,
    required this.pointsCurrent,
    required this.pointsTotal,
    required this.nextRewardAmount,
    required this.totalTriggered,
    required this.lastTriggeredAt,
  });
}

class ProfileAlertsEntity {
  final int activeCount;
  final int totalTriggered;
  final DateTime? lastTriggeredAt;

  const ProfileAlertsEntity({
    required this.activeCount,
    required this.totalTriggered,
    required this.lastTriggeredAt,
  });
}
