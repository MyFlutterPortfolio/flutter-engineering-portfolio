import 'package:untitled5/features/profile/domain/entities/profile_entity.dart';

class ProfileDto {
  final ProfileUserDto user;
  final ProfileSubscriptionDto subscription;
  final ProfileSearchQuotaDto searchQuota;
  final ProfileCashbackDto cashback;
  final ProfileAlertsDto alerts;

  const ProfileDto({
    required this.user,
    required this.subscription,
    required this.searchQuota,
    required this.cashback,
    required this.alerts,
  });

  factory ProfileDto.fromJson(Map<String, dynamic> json) {
    final userJson = Map<String, dynamic>.from((json['user'] as Map?) ?? {});
    final subscriptionJson = Map<String, dynamic>.from(
      (json['subscription'] as Map?) ?? {},
    );
    final quotaJson = Map<String, dynamic>.from(
      ((json['quota'] as Map?)?['search'] as Map?) ?? const {},
    );
    final cashbackJson = Map<String, dynamic>.from(
      (json['cashback'] as Map?) ?? {},
    );
    final alertsJson = Map<String, dynamic>.from(
      (json['alerts'] as Map?) ?? {},
    );

    return ProfileDto(
      user: ProfileUserDto.fromJson(userJson),
      subscription: ProfileSubscriptionDto.fromJson(subscriptionJson),
      searchQuota: ProfileSearchQuotaDto.fromJson(quotaJson),
      cashback: ProfileCashbackDto.fromJson(cashbackJson),
      alerts: ProfileAlertsDto.fromJson(alertsJson),
    );
  }

  ProfileEntity toEntity() {
    return ProfileEntity(
      user: user.toEntity(),
      subscription: subscription.toEntity(),
      searchQuota: searchQuota.toEntity(),
      cashback: cashback.toEntity(),
      alerts: alerts.toEntity(),
    );
  }
}

class ProfileUserDto {
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

  const ProfileUserDto({
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

  factory ProfileUserDto.fromJson(Map<String, dynamic> json) {
    final notifications = Map<String, dynamic>.from(
      (json['notifications'] as Map?) ?? {},
    );

    return ProfileUserDto(
      id: (json['id'] ?? '').toString(),
      email: (json['email'] ?? '').toString(),
      username: (json['username'] ?? '').toString(),
      firstName: (json['firstName'] as String?)?.trim(),
      lastName: (json['lastName'] as String?)?.trim(),
      displayName: (json['displayName'] ?? json['username'] ?? 'User')
          .toString(),
      avatar: (json['avatar'] as String?)?.trim().isEmpty == true
          ? null
          : (json['avatar'] as String?),
      language: (json['language'] ?? 'en').toString(),
      currency: (json['currency'] ?? 'USD').toString(),
      theme: (json['theme'] ?? 'light').toString(),
      emailNotifications: notifications['email'] == true,
      priceAlerts: notifications['priceAlerts'] == true,
    );
  }

  ProfileUserEntity toEntity() {
    return ProfileUserEntity(
      id: id,
      email: email,
      username: username,
      firstName: firstName,
      lastName: lastName,
      displayName: displayName,
      avatar: avatar,
      language: language,
      currency: currency,
      theme: theme,
      emailNotifications: emailNotifications,
      priceAlerts: priceAlerts,
    );
  }
}

class ProfileSubscriptionDto {
  final String plan;
  final String status;
  final String? expiresAt;

  const ProfileSubscriptionDto({
    required this.plan,
    required this.status,
    required this.expiresAt,
  });

  factory ProfileSubscriptionDto.fromJson(Map<String, dynamic> json) {
    return ProfileSubscriptionDto(
      plan: (json['plan'] ?? 'FREE').toString(),
      status: (json['status'] ?? 'NONE').toString(),
      expiresAt: (json['expiresAt'] as String?)?.trim(),
    );
  }

  ProfileSubscriptionEntity toEntity() {
    return ProfileSubscriptionEntity(
      plan: plan,
      status: status,
      expiresAt: expiresAt,
    );
  }
}

class ProfileSearchQuotaDto {
  final bool allowed;
  final int? used;
  final int? limit;
  final int? remaining;
  final String resetAt;

  const ProfileSearchQuotaDto({
    required this.allowed,
    required this.used,
    required this.limit,
    required this.remaining,
    required this.resetAt,
  });

  factory ProfileSearchQuotaDto.fromJson(Map<String, dynamic> json) {
    return ProfileSearchQuotaDto(
      allowed: json['allowed'] != false,
      used: (json['used'] as num?)?.toInt(),
      limit: (json['limit'] as num?)?.toInt(),
      remaining: (json['remaining'] as num?)?.toInt(),
      resetAt: (json['resetAt'] ?? '').toString(),
    );
  }

  ProfileSearchQuotaEntity toEntity() {
    return ProfileSearchQuotaEntity(
      allowed: allowed,
      used: used,
      limit: limit,
      remaining: remaining,
      resetAt: resetAt,
    );
  }
}

class ProfileCashbackDto {
  final double balance;
  final String currency;
  final double lifetimeSavings;
  final int pointsCurrent;
  final int pointsTotal;
  final double nextRewardAmount;
  final int totalTriggered;
  final DateTime? lastTriggeredAt;

  const ProfileCashbackDto({
    required this.balance,
    required this.currency,
    required this.lifetimeSavings,
    required this.pointsCurrent,
    required this.pointsTotal,
    required this.nextRewardAmount,
    required this.totalTriggered,
    required this.lastTriggeredAt,
  });

  factory ProfileCashbackDto.fromJson(Map<String, dynamic> json) {
    return ProfileCashbackDto(
      balance: (json['balance'] as num?)?.toDouble() ?? 0,
      currency: (json['currency'] ?? 'USD').toString(),
      lifetimeSavings: (json['lifetimeSavings'] as num?)?.toDouble() ?? 0,
      pointsCurrent: (json['pointsCurrent'] as num?)?.toInt() ?? 0,
      pointsTotal: (json['pointsTotal'] as num?)?.toInt() ?? 1000,
      nextRewardAmount: (json['nextRewardAmount'] as num?)?.toDouble() ?? 0,
      totalTriggered: (json['totalTriggered'] as num?)?.toInt() ?? 0,
      lastTriggeredAt: DateTime.tryParse(
        (json['lastTriggeredAt'] ?? '').toString(),
      ),
    );
  }

  ProfileCashbackEntity toEntity() {
    return ProfileCashbackEntity(
      balance: balance,
      currency: currency,
      lifetimeSavings: lifetimeSavings,
      pointsCurrent: pointsCurrent,
      pointsTotal: pointsTotal,
      nextRewardAmount: nextRewardAmount,
      totalTriggered: totalTriggered,
      lastTriggeredAt: lastTriggeredAt,
    );
  }
}

class ProfileAlertsDto {
  final int activeCount;
  final int totalTriggered;
  final DateTime? lastTriggeredAt;

  const ProfileAlertsDto({
    required this.activeCount,
    required this.totalTriggered,
    required this.lastTriggeredAt,
  });

  factory ProfileAlertsDto.fromJson(Map<String, dynamic> json) {
    return ProfileAlertsDto(
      activeCount: (json['activeCount'] as num?)?.toInt() ?? 0,
      totalTriggered: (json['totalTriggered'] as num?)?.toInt() ?? 0,
      lastTriggeredAt: DateTime.tryParse(
        (json['lastTriggeredAt'] ?? '').toString(),
      ),
    );
  }

  ProfileAlertsEntity toEntity() {
    return ProfileAlertsEntity(
      activeCount: activeCount,
      totalTriggered: totalTriggered,
      lastTriggeredAt: lastTriggeredAt,
    );
  }
}
