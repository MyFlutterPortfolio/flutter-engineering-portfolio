import 'package:untitled5/core/config/app_config.dart';

class ApiEndpoints {
  static String get baseUrl => AppConfig.apiBaseUrl;

  static const String apiPrefix = '';

  // Auth
  static const String login = '/auth/login';
  static const String register = '/auth/register';
  static const String refresh = '/auth/refresh';
  static const String logout = '/auth/logout';
  static const String profileMe = '/profile/me';
  static const String notificationsFcmToken = '/notifications/fcm-token';

  // Search
  static const String search = '/search';
  static const String getCountries = '/search/countries';
  static const String getStores = '/search/stores';
  static String getProduct(String id) => '/search/${_pathSegment(id)}';
  static String getSearchStatus(String requestId) =>
      '/search/status/${_pathSegment(requestId)}';
  static String getAiStatus(String requestId) =>
      '/search/ai-status/${_pathSegment(requestId)}';

  // AI Services
  static const String barcodeScan = '/ai/barcode-scan';
  static const String processBarcode = '/ai/barcode-scan';
  static String productByBarcode(String barcode) =>
      '/advanced/product-by-barcode/${_pathSegment(barcode)}';

  static const String imageRecognition = '/ai/image-recognition';
  static const String analyzeImage = '/ai/image-recognition';
  static const String aiChat = '/ai/chat';
  static const String aiChatThreads = '/ai/chat-threads';
  static String aiChatThread(String id) =>
      '/ai/chat-threads/${_pathSegment(id)}';
  static const String aiChatHistory = '/ai/chat-history';
  static const String aiChatMessage = '/ai/chat/message';
  static const String aiChatFeedback = '/ai/chat/feedback';
  static const String agentSearch = '/ai/agent-search';
  static String agentSearchStatus(String requestId) =>
      '/ai/agent-search/status/${_pathSegment(requestId)}';

  // Insights
  static const String sentimentAnalysis = '/ai/sentiment-analysis';
  static const String ecoScore = '/ai/eco-score';

  // Billing
  static const String billingMe = '/billing/me';
  static const String activateGooglePlay = '/billing/google-play/activate';

  // Others
  static const String analyzeProduct = '/clario/analyze-product';
  static const String addFavorite = '/favorites/add';
  static const String getFavorites = '/favorites/list';
  static const String removeFavorite = '/favorites/remove';

  // Alerts
  static const String alerts = '/alerts';
  static String realtimeQuote(String productId) =>
      '/alerts/realtime-quote/${_pathSegment(productId)}';
  static const String manualLinkQuote = '/alerts/manual-link/quote';
  static const String manualLinkAlert = '/alerts/manual-link';
  static const String alertEvents = '/alerts/events';
  static const String checkAlertsNow = '/alerts/check-now';
  static String disableAlert(String id) =>
      '/alerts/${_pathSegment(id)}/disable';
  static String enableAlert(String id) => '/alerts/${_pathSegment(id)}/enable';
  static String deleteAlert(String id) => '/alerts/${_pathSegment(id)}';

  static String _pathSegment(String value) {
    return Uri.encodeComponent(value.trim());
  }
}
