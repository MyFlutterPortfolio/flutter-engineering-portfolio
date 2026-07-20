import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:untitled5/core/firebase/firebase_options.dart';
import 'package:untitled5/core/network/api_endpoints.dart';
import 'package:untitled5/core/network/api_client.dart';
import 'package:untitled5/core/router/app_router.dart';
import 'package:untitled5/core/utils/safe_url_launcher.dart';

const String _priceAlertChannelId = 'price_alerts';
const String _priceAlertCategoryId = 'PRICE_ALERT';
const String _actionOpenDeal = 'open_deal';
const String _actionOpenApp = 'open_app';
const Color _profitGreen = Color(0xFF16A34A);

const AndroidNotificationChannel _priceAlertChannel =
    AndroidNotificationChannel(
      _priceAlertChannelId,
      'Price alerts',
      description: 'Realtime price drop and deal notifications.',
      importance: Importance.high,
    );

const List<AndroidNotificationAction> _androidPriceAlertActions = [
  AndroidNotificationAction(
    _actionOpenDeal,
    'View deal',
    showsUserInterface: true,
    cancelNotification: true,
  ),
  AndroidNotificationAction(
    _actionOpenApp,
    'Open app',
    showsUserInterface: true,
    cancelNotification: true,
  ),
];

const Set<String> _notificationPayloadKeys = {
  'type',
  'alertId',
  'eventId',
  'productId',
  'productTitle',
  'notificationKind',
  'triggerPrice',
  'currentPrice',
  'baselinePrice',
  'targetPrice',
  'savingsAmount',
  'savingsPercent',
  'currency',
  'store',
  'buyNowUrl',
  'trendUrl',
  'oneTapUrl',
  'actionUrl',
  'appRoute',
  'timestamp',
};

final FlutterLocalNotificationsPlugin _localNotifications =
    FlutterLocalNotificationsPlugin();

bool _firebaseReady = false;
bool _backgroundHandlerRegistered = false;
bool _localNotificationsReady = false;

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await ensureFirebaseReadyForPush();
}

@pragma('vm:entry-point')
void notificationTapBackground(NotificationResponse response) {
  // Actions with showsUserInterface=true are handled after the app opens.
}

Future<bool> ensureFirebaseReadyForPush() async {
  if (!DefaultFirebaseOptions.isConfigured) return false;

  try {
    if (Firebase.apps.isEmpty) {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
    }

    if (!_backgroundHandlerRegistered) {
      FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
      _backgroundHandlerRegistered = true;
    }

    _firebaseReady = true;
    return true;
  } catch (error) {
    _debugLog('Firebase init skipped: $error');
    _firebaseReady = false;
    return false;
  }
}

final pushNotificationServiceProvider = Provider<PushNotificationService>((
  ref,
) {
  final dio = ref.watch(apiClientProvider).dio;
  return PushNotificationService(dio);
});

class PushNotificationService {
  PushNotificationService(this._dio);

  final Dio _dio;
  StreamSubscription<String>? _tokenRefreshSubscription;
  StreamSubscription<RemoteMessage>? _foregroundMessageSubscription;
  StreamSubscription<RemoteMessage>? _messageOpenedSubscription;
  String? _lastRegisteredToken;
  bool _initialized = false;
  bool _initializing = false;
  bool _initialMessageHandled = false;

  Future<void> initializeAndRegister() async {
    if (_initialized) return;
    if (_initializing) return;
    _initializing = true;

    try {
      final ready = _firebaseReady || await ensureFirebaseReadyForPush();
      if (!ready) return;

      await _initializeLocalNotifications();
      await _requestPermission();
      await FirebaseMessaging.instance
          .setForegroundNotificationPresentationOptions(
            alert: true,
            badge: true,
            sound: true,
          );

      await _registerCurrentToken();

      _tokenRefreshSubscription ??= FirebaseMessaging.instance.onTokenRefresh
          .listen((token) => unawaited(_registerToken(token)));

      _foregroundMessageSubscription ??= FirebaseMessaging.onMessage.listen(
        (message) => unawaited(_showForegroundNotification(message)),
      );

      _messageOpenedSubscription ??= FirebaseMessaging.onMessageOpenedApp
          .listen((message) => unawaited(_handleRemoteMessageTap(message)));

      await _handleInitialMessageIfNeeded();

      _initialized = true;
    } catch (error) {
      _debugLog('Push notification init failed: $error');
    } finally {
      _initializing = false;
    }
  }

  Future<void> unregisterCurrentToken() async {
    final ready = _firebaseReady || await ensureFirebaseReadyForPush();
    if (!ready) return;

    final token = await FirebaseMessaging.instance.getToken(
      vapidKey: _webVapidKey,
    );
    if (token == null || token.isEmpty) return;

    await _dio.delete(
      ApiEndpoints.notificationsFcmToken,
      data: {'token': token},
    );
    _lastRegisteredToken = null;
  }

  Future<void> _registerCurrentToken() async {
    final token = await FirebaseMessaging.instance.getToken(
      vapidKey: _webVapidKey,
    );
    if (token == null || token.isEmpty) {
      _debugLog('FCM token is empty.');
      return;
    }

    await _registerToken(token);
  }

  Future<void> _registerToken(String token) async {
    if (_lastRegisteredToken == token) return;

    await _dio.post(
      ApiEndpoints.notificationsFcmToken,
      data: {'token': token, 'platform': _platformName},
    );

    _lastRegisteredToken = token;
  }

  Future<void> _requestPermission() async {
    await FirebaseMessaging.instance.requestPermission(
      alert: true,
      badge: true,
      sound: true,
      provisional: false,
    );
  }

  Future<void> _initializeLocalNotifications() async {
    if (_localNotificationsReady) return;

    final initializationSettings = InitializationSettings(
      android: const AndroidInitializationSettings('ic_stat_price_alert'),
      iOS: DarwinInitializationSettings(
        requestAlertPermission: false,
        requestBadgePermission: false,
        requestSoundPermission: false,
        notificationCategories: [
          DarwinNotificationCategory(
            _priceAlertCategoryId,
            actions: [
              DarwinNotificationAction.plain(
                _actionOpenDeal,
                'View deal',
                options: {DarwinNotificationActionOption.foreground},
              ),
              DarwinNotificationAction.plain(
                _actionOpenApp,
                'Open app',
                options: {DarwinNotificationActionOption.foreground},
              ),
            ],
          ),
        ],
      ),
    );

    await _localNotifications.initialize(
      settings: initializationSettings,
      onDidReceiveNotificationResponse: _handleNotificationResponse,
      onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
    );

    final androidPlugin = _localNotifications
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >();
    await androidPlugin?.createNotificationChannel(_priceAlertChannel);

    _localNotificationsReady = true;
  }

  Future<void> _showForegroundNotification(RemoteMessage message) async {
    final notification = message.notification;
    final title =
        notification?.title ??
        message.data['title']?.toString() ??
        'Price alert';
    final body = notification?.body ?? message.data['body']?.toString() ?? '';

    if (title.trim().isEmpty && body.trim().isEmpty) return;

    await _localNotifications.show(
      id: _stableNotificationId(message),
      title: title,
      body: body,
      notificationDetails: NotificationDetails(
        android: AndroidNotificationDetails(
          _priceAlertChannelId,
          'Price alerts',
          channelDescription: 'Realtime price drop and deal notifications.',
          importance: Importance.high,
          priority: Priority.high,
          icon: 'ic_stat_price_alert',
          color: _profitGreen,
          styleInformation: BigTextStyleInformation(body),
          actions: _androidPriceAlertActions,
        ),
        iOS: DarwinNotificationDetails(
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
          categoryIdentifier: _priceAlertCategoryId,
          threadIdentifier: message.data['alertId']?.toString(),
        ),
      ),
      payload: _encodeNotificationPayload(message.data),
    );
  }

  Future<void> _handleInitialMessageIfNeeded() async {
    if (_initialMessageHandled) return;
    _initialMessageHandled = true;

    final initialMessage = await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {
      await _handleRemoteMessageTap(initialMessage);
    }
  }

  Future<void> _handleRemoteMessageTap(RemoteMessage message) async {
    final payload = _PriceAlertPayload.fromMap(message.data);
    await _openPayloadInApp(payload);
  }

  String? get _webVapidKey {
    if (!kIsWeb || DefaultFirebaseOptions.webVapidKey.isEmpty) return null;
    return DefaultFirebaseOptions.webVapidKey;
  }

  String get _platformName {
    if (kIsWeb) return 'web';

    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return 'android';
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
        return 'ios';
      case TargetPlatform.fuchsia:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
        return 'unknown';
    }
  }
}

void _handleNotificationResponse(NotificationResponse response) {
  unawaited(_handlePriceAlertAction(response.actionId, response.payload));
}

Future<void> _handlePriceAlertAction(
  String? actionId,
  String? encodedPayload,
) async {
  final payload = _PriceAlertPayload.fromEncoded(encodedPayload);

  if (actionId == _actionOpenDeal) {
    final actionUrl = payload.actionUrl;
    if (actionUrl != null && await launchExternalWebUrl(actionUrl)) {
      return;
    }
  }

  await _openPayloadInApp(payload);
}

Future<void> _openPayloadInApp(_PriceAlertPayload payload) async {
  final route =
      payload.appRoute ??
      (payload.productId == null
          ? '/notifications'
          : '/product/${Uri.encodeComponent(payload.productId!)}');

  WidgetsBinding.instance.addPostFrameCallback((_) {
    try {
      appRouter.go(route);
    } catch (error) {
      _debugLog('Failed to open notification route: $error');
    }
  });
}

int _stableNotificationId(RemoteMessage message) {
  final seed = message.data['eventId']?.toString().trim().isNotEmpty == true
      ? message.data['eventId'].toString()
      : message.messageId ?? DateTime.now().microsecondsSinceEpoch.toString();
  return seed.hashCode & 0x7fffffff;
}

String _encodeNotificationPayload(Map<String, dynamic> data) {
  final payload = <String, String>{};

  for (final key in _notificationPayloadKeys) {
    final value = data[key]?.toString().trim();
    if (value == null || value.isEmpty) continue;
    payload[key] = value.length > 2048 ? value.substring(0, 2048) : value;
  }

  return jsonEncode(payload);
}

class _PriceAlertPayload {
  const _PriceAlertPayload({this.productId, this.actionUrl, this.appRoute});

  factory _PriceAlertPayload.fromEncoded(String? encodedPayload) {
    final raw = encodedPayload?.trim();
    if (raw == null || raw.isEmpty) {
      return const _PriceAlertPayload();
    }

    if (!raw.startsWith('{')) {
      return _PriceAlertPayload(productId: raw);
    }

    try {
      final decoded = jsonDecode(raw);
      if (decoded is Map<String, dynamic>) {
        return _PriceAlertPayload.fromMap(decoded);
      }
      if (decoded is Map) {
        return _PriceAlertPayload.fromMap(
          decoded.map((key, value) => MapEntry(key.toString(), value)),
        );
      }
    } catch (error) {
      _debugLog('Invalid notification payload: $error');
    }

    return const _PriceAlertPayload();
  }

  factory _PriceAlertPayload.fromMap(Map<String, dynamic> data) {
    final productId = _nonEmptyString(data['productId']);
    return _PriceAlertPayload(
      productId: productId,
      actionUrl: _firstNonEmpty(
        data['actionUrl'],
        data['oneTapUrl'],
        data['buyNowUrl'],
      ),
      appRoute:
          _safeInternalRoute(data['appRoute']) ??
          (productId == null
              ? null
              : '/product/${Uri.encodeComponent(productId)}'),
    );
  }

  final String? productId;
  final String? actionUrl;
  final String? appRoute;
}

String? _firstNonEmpty(Object? first, [Object? second, Object? third]) {
  return _nonEmptyString(first) ??
      _nonEmptyString(second) ??
      _nonEmptyString(third);
}

String? _nonEmptyString(Object? value) {
  final normalized = value?.toString().trim();
  return normalized == null || normalized.isEmpty ? null : normalized;
}

String? _safeInternalRoute(Object? value) {
  final route = _nonEmptyString(value);
  if (route == null) return null;
  if (!route.startsWith('/') || route.startsWith('//')) return null;
  if (route.contains('\n') || route.contains('\r')) return null;
  if (route.length > 512) return null;
  return route;
}

void _debugLog(String message) {
  if (kDebugMode) {
    debugPrint(message);
  }
}
