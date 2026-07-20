// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get navHome => 'Agent';

  @override
  String get navSearch => 'Search';

  @override
  String get navProfile => 'Profile';

  @override
  String get aboutTitle => 'About Dealio';

  @override
  String get aboutSubtitle => 'Built for smarter shopping';

  @override
  String get languageTitle => 'App Language';

  @override
  String get languageSubtitle => 'Search and AI results follow this language';

  @override
  String get langEnglish => 'English';

  @override
  String get langRussian => 'Russian';

  @override
  String get langSpanish => 'Spanish';

  @override
  String get langUzbek => 'Uzbek';

  @override
  String get langChinese => 'Chinese';

  @override
  String searchPlanUnlimited(String plan) {
    return '$plan Plan - Unlimited search';
  }

  @override
  String searchPlanRemaining(String plan, int remaining) {
    return '$plan Plan - $remaining searches left';
  }

  @override
  String get searchValidationQueryRequired => 'Please enter a product';

  @override
  String get searchQueryHint => 'e.g. iPhone 13 128GB';

  @override
  String get commonRetry => 'Retry';

  @override
  String get searchUseUS => 'Use US';

  @override
  String get searchFreeModeHint =>
      'FREE mode: global stores are loaded automatically by country.';

  @override
  String get searchManualStoreHint => 'Global store link/domain (amazon.com)';

  @override
  String get commonAdd => 'Add';

  @override
  String get searchStoreSearchHint => 'Search stores...';

  @override
  String get searchStoresEmpty =>
      'Stores for the selected country will appear here.';

  @override
  String get searchStoresLoadFailed =>
      'Failed to load stores. Please try again.';

  @override
  String get searchErrorCountryRequired =>
      'Country is required. Please select a country first.';

  @override
  String get searchPlanLimitTitle => 'Plan Limit Reached';

  @override
  String get searchPlanLimitMessage =>
      'Your plan limit is reached. Upgrade to continue.';

  @override
  String get searchErrorEnterStoreDomain =>
      'Enter a store domain or URL. Example: amazon.com';

  @override
  String get searchErrorStoreAlreadySelected =>
      'This store is already selected.';

  @override
  String searchErrorStoreLimit(int max) {
    return 'You can select up to $max stores.';
  }

  @override
  String get commonEdit => 'Edit';

  @override
  String get resultsLoadingTitle => 'Scanning global stores...';

  @override
  String get alertsCheckNow => 'Check now';

  @override
  String get alertSheetAllStores => 'All stores';

  @override
  String get alertSheetUserConsent => 'I approve one-tap checkout';

  @override
  String get alertsTargetNA => 'Target: N/A';

  @override
  String get alertSheetStatHigh => 'High';

  @override
  String get settingsLogoutSubtitle => 'Securely sign out from this device';

  @override
  String get alertSheetTitle => 'Create Price Alert';

  @override
  String get favoritesTitle => 'Favorites';

  @override
  String get resultsEmptyDescription =>
      'Try refining your keywords, country, or store settings.';

  @override
  String get planPlus => 'Plus';

  @override
  String get resultsLoadingSubtitle =>
      'Aggregating offers and AI matching in realtime.';

  @override
  String get resultsStage2ReadySubtitle =>
      'AI profile generated, validating store confidence.';

  @override
  String alertsTriggers(int count) {
    return 'Triggers: $count';
  }

  @override
  String get alertsDealButton => 'Open deal';

  @override
  String alertSheetCurrentTarget(String target, String observed) {
    return 'Current: $observed  Target: $target';
  }

  @override
  String settingsSearchesLeft(int remaining, int limit) {
    return '$remaining/$limit searches left';
  }

  @override
  String get planFree => 'Free';

  @override
  String get commonLogout => 'Logout';

  @override
  String get alertEventsEmpty => 'No alert events yet.';

  @override
  String get commonSettings => 'Settings';

  @override
  String alertEventsError(String error) {
    return 'Failed to load events: $error';
  }

  @override
  String get resultsStage1ReadySubtitle =>
      'Market scan complete, preparing AI profile.';

  @override
  String get alertSheetRefreshQuote => 'Refresh quote';

  @override
  String get alertsEmptySubtitle =>
      'Create your first alert from search results to track price drops.';

  @override
  String get alertSheetArmAutoBuy => 'Arm auto-buy';

  @override
  String get resultsUpgradePlanTitle => 'Upgrade your plan';

  @override
  String get alertSheetKvontTitle => 'KVONT Auto-buy Controls';

  @override
  String get commonCancel => 'Cancel';

  @override
  String get commonDelete => 'Delete';

  @override
  String get resultsUnexpectedError =>
      'Something unexpected happened during search.';

  @override
  String get resultsEmptyTitle => 'No matching products found';

  @override
  String get alertSheetWaitingPrice => 'Waiting for realtime price...';

  @override
  String get settingsThemeTitle => 'Theme';

  @override
  String get favoritesEmptyTitle => 'No favorites yet';

  @override
  String get commonUpgrade => 'Upgrade';

  @override
  String get favoritesAnalyze => 'Analyze';

  @override
  String get resultsStageFindingTitle => 'Finding best offers';

  @override
  String get alertSheetTriggerSetup => 'Trigger setup';

  @override
  String get resultsStageFindingSubtitle =>
      'Collecting initial market signals.';

  @override
  String get alertSheetSaveButton => 'Save Alert';

  @override
  String get alertSheetRealtimeMonitoring => 'Realtime monitoring';

  @override
  String get resultsStage2ReadyTitle => 'Stage 2 ready';

  @override
  String get settingsSubscriptionUnavailable => 'Subscription unavailable';

  @override
  String get resultsUpgradeNow => 'Upgrade now';

  @override
  String get alertSheetKvontSubtitle =>
      'These options only prepare notification actions; payment still needs your confirmation.';

  @override
  String get resultsAdjustParameters => 'Adjust search parameters';

  @override
  String get commonClear => 'Clear';

  @override
  String settingsPlanLabel(String plan) {
    return '$plan Plan';
  }

  @override
  String alertsTargetValue(String price) {
    return 'Target: \$$price';
  }

  @override
  String get alertSheetStoreTargeting => 'Store targeting';

  @override
  String get resultsUpgradePlanMessage =>
      'Move to a higher plan for more searches and deeper AI analysis.';

  @override
  String get alertSheetCooldownLabel => 'Cooldown (minutes)';

  @override
  String get settingsDarkEnabled => 'Dark mode enabled';

  @override
  String get alertsKvontPaywallMessage =>
      'Unlock realtime alerts, price trend analytics, and checkout-ready links.';

  @override
  String get alertsKvontUpgradeMessage =>
      'Upgrade to KVONT for realtime monitoring, trend charts, and auto-buy prep.';

  @override
  String resultsProductsOptimized(int count) {
    return '$count products optimized';
  }

  @override
  String get settingsNotificationsSubtitle => 'Price alerts and app updates';

  @override
  String get planKvont => 'Kvont';

  @override
  String get planPro => 'Pro';

  @override
  String get resultsNeuralGlitch => 'Search issue';

  @override
  String get alertSheetTargetInvalid =>
      'Target must be lower than current price.';

  @override
  String get alertsKvontPaywallTitle => 'KVONT Super Alerts';

  @override
  String get alertSheetStatTarget => 'Target';

  @override
  String get alertSheetCheckoutPrepared => 'Checkout link prepared';

  @override
  String get alertSheetStatLow => 'Low';

  @override
  String get settingsPrivacySubtitle => 'Manage privacy preferences';

  @override
  String get resultsStage3ReadyTitle => 'Stage 3 ready';

  @override
  String alertsLastTrigger(String time) {
    return 'Last trigger: $time';
  }

  @override
  String get resultsSearchQuotaTitle => 'Search quota';

  @override
  String get resultsSearchLimitReached => 'Search limit reached';

  @override
  String get alertSheetRealtimeUnavailable =>
      'Realtime price unavailable. Refresh quote and try again.';

  @override
  String get alertsDeleteTitle => 'Delete alert?';

  @override
  String get alertsEmptyTitle => 'No active alerts';

  @override
  String alertsCheckNowResult(String checked, String errors, String triggered) {
    return 'Checked: $checked  Triggered: $triggered  Errors: $errors';
  }

  @override
  String get alertEventsTitle => 'Alert Events';

  @override
  String get resultsStage3ReadySubtitle =>
      'Final ranking is ready with best alternatives.';

  @override
  String get alertSheetTrendTitle => 'Price trend (recent)';

  @override
  String get commonManage => 'Manage';

  @override
  String get favoritesStartShopping => 'Start shopping';

  @override
  String get settingsNotificationsTitle => 'Notifications';

  @override
  String get settingsLightEnabled => 'Light mode enabled';

  @override
  String get alertSheetCooldownHelper =>
      'Minimum 5 minutes, maximum 1440 minutes.';

  @override
  String get alertsKvontSubtitle =>
      'Realtime worker keeps your alerts synced with store prices.';

  @override
  String get alertsCreateTooltip => 'Create alert';

  @override
  String get settingsPrivacyTitle => 'Privacy & Security';

  @override
  String alertEventsTriggeredAt(String targetPrice, String triggerPrice) {
    return 'Triggered at \$$triggerPrice (target \$$targetPrice)';
  }

  @override
  String get alertSheetRealtimeMonitoringSubtitle =>
      'Continuously checks prices for faster triggers.';

  @override
  String get resultsNeuralSearch => 'Neural Search';

  @override
  String get alertsKvontActive => 'KVONT realtime monitoring active';

  @override
  String get alertSheetRealtimePriceLabel => 'Realtime price';

  @override
  String get alertsTitle => 'Alerts';

  @override
  String get alertSheetDropAmount => 'Drop \$';

  @override
  String get alertEventsViewDeal => 'View deal';

  @override
  String get alertSheetSaved => 'Alert created successfully.';

  @override
  String get resultsStage1ReadyTitle => 'Stage 1 ready';

  @override
  String get alertsDeleteMessage =>
      'This action removes the alert and its realtime monitoring.';

  @override
  String get alertSheetDropPercent => 'Drop %';

  @override
  String get favoritesSubtitle =>
      'Your saved products and quick re-check list.';

  @override
  String get resultsTryAgain => 'Try again';

  @override
  String get favoritesEmptySubtitle =>
      'Save products to track better prices and safer alternatives.';

  @override
  String get alertsNever => 'Never';

  @override
  String get alertsHistoryTooltip => 'Alert history';

  @override
  String get onboardingSlide1Desc =>
      'Instantly compare deals across global retailers to find the best price.';

  @override
  String get authEmailLabel => 'Email';

  @override
  String get onboardingSlide2Desc =>
      'AI verifies product originality and seller reliability before you buy.';

  @override
  String get authEmailHint => 'you@example.com';

  @override
  String get loginCreateAccount => 'Create new account';

  @override
  String authFullNameMinChars(int min) {
    return 'Minimum $min characters';
  }

  @override
  String get profilePaymentMethodsSubtitle => 'Credit cards & wallets';

  @override
  String get loginBackOnboarding => 'Back to onboarding';

  @override
  String get onboardingNext => 'Next';

  @override
  String get profileNotifications => 'Notifications';

  @override
  String get profileSecurity => 'Security';

  @override
  String get loginButton => 'Login';

  @override
  String get authPasswordLabel => 'Password';

  @override
  String get splashTagline => 'Deals You Can Trust';

  @override
  String get onboardingSlide3Desc =>
      'Understand real buyer feedback with smart sentiment summaries.';

  @override
  String get onboardingGetStarted => 'Get Started';

  @override
  String get authFullNameLabel => 'Full Name';

  @override
  String get registerCreateAccount => 'Create Account';

  @override
  String get authPasswordHint => 'Enter your password';

  @override
  String get profileSettingsPreferences => 'Settings & Preferences';

  @override
  String get onboardingSlide4Title => 'Smart Alerts';

  @override
  String get registerSubtitle =>
      'Join Dealio and unlock smart shopping workflows';

  @override
  String get onboardingBack => 'Back';

  @override
  String get loginWelcomeBack => 'Welcome Back';

  @override
  String get onboardingSkip => 'Skip';

  @override
  String get loginForgotPassword => 'Forgot Password?';

  @override
  String get onboardingSlide1Title => 'Global Price Comparison';

  @override
  String get registerButton => 'Sign Up';

  @override
  String authPasswordMinChars(int min) {
    return 'Minimum $min characters';
  }

  @override
  String get loginSignInContinue => 'Sign in to continue';

  @override
  String get profileName => 'Alex Robinson';

  @override
  String profilePointsProgress(String total, String current) {
    return '$current / $total points';
  }

  @override
  String get onboardingSlide4Desc =>
      'Get notified when your target price is reached and act fast.';

  @override
  String get profileLogout => 'Log Out';

  @override
  String get profileGoldStatus => 'GOLD STATUS';

  @override
  String get registerSuccessTitle => 'Registration Success';

  @override
  String get profilePaymentMethods => 'Payment Methods';

  @override
  String get profileNotificationsSubtitle => 'Deal alerts & app updates';

  @override
  String get profileCashbackBalance => 'Cashback Balance';

  @override
  String get onboardingSlide2Title => 'Authenticity Check';

  @override
  String profileNextReward(String amount) {
    return 'Next Reward: $amount';
  }

  @override
  String get authEmailInvalid => 'Enter a valid email';

  @override
  String get authEmailRequired => 'Email is required';

  @override
  String get authPasswordRequired => 'Password is required';

  @override
  String get authFullNameRequired => 'Full name is required';

  @override
  String get registerAlreadyHaveAccount => 'Already have account? Login';

  @override
  String get onboardingSlide3Title => 'Reviews & Insights';

  @override
  String get profileSecuritySubtitle => 'Biometrics & passwords';

  @override
  String get navFavorites => 'Favorites';

  @override
  String get favoritesLoadFailed => 'Saved list is out of sync';

  @override
  String get favoritesLoadSubtitle =>
      'Dealio could not refresh your saved products right now. Check your connection, then sync again.';

  @override
  String get favoritesLoadAction => 'Refresh saved list';

  @override
  String get favoritesProductFallback => 'Product';

  @override
  String get favoritesNoNotes => 'Saved product';

  @override
  String get favoritesSaveTooltip => 'Save to favorites';

  @override
  String get favoritesRemoveTooltip => 'Remove from favorites';

  @override
  String get favoritesSaved => 'Saved to favorites.';

  @override
  String get favoritesRemoved => 'Removed from favorites.';

  @override
  String get favoritesActionFailed => 'Could not update saved list. Try again.';

  @override
  String get notificationsTitle => 'Notifications';

  @override
  String get notificationsClearTitle => 'Clear all?';

  @override
  String get notificationsClearMessage =>
      'Are you sure you want to dismiss all notifications?';

  @override
  String get notificationsUnavailableTitle => 'Notifications unavailable';

  @override
  String get notificationsUnavailableSubtitle =>
      'We could not load alerts right now. Please try again soon.';

  @override
  String notificationsAtStore(String store) {
    return ' at $store';
  }

  @override
  String notificationsAlertMatched(String price, String store) {
    return 'A tracked product matched your alert$price$store.';
  }

  @override
  String get notificationsBackInStock => 'Back in stock';

  @override
  String get notificationsDealFound => 'Deal found';

  @override
  String get notificationsPriceAlert => 'Price alert';

  @override
  String get notificationsJustNow => 'Just now';

  @override
  String notificationsMinutesAgo(int count) {
    return '${count}m ago';
  }

  @override
  String notificationsHoursAgo(int count) {
    return '${count}h ago';
  }

  @override
  String notificationsDaysAgo(int count) {
    return '${count}d ago';
  }

  @override
  String get notificationsTabAll => 'All';

  @override
  String get notificationsTabPriceAlerts => 'Price Alerts';

  @override
  String get notificationsTabAiInsights => 'AI Insights';

  @override
  String get notificationsTabSustainability => 'Sustainability';

  @override
  String get notificationsTabStoreUpdates => 'Store Updates';

  @override
  String get notificationsViewProduct => 'View Product';

  @override
  String get notificationsReanalyze => 'Re-analyze';

  @override
  String get notificationsEmptyTitle => 'No notifications yet';

  @override
  String get notificationsEmptySubtitle =>
      'Create price alerts to receive real-time deal updates here.';

  @override
  String get alertPickerTitle => 'Create price alert';

  @override
  String get alertPickerSubtitle =>
      'Choose how you want to start. Search is best for comparison; manual link tracks one exact store page.';

  @override
  String get alertPickerSearchTitle => 'Search product';

  @override
  String get alertPickerSearchSubtitle =>
      'Find a product first, compare stores, then create an alert.';

  @override
  String get alertPickerManualTitle => 'Manual store link';

  @override
  String get alertPickerManualSubtitle =>
      'Paste any public product URL and monitor that exact page.';

  @override
  String get alertPickerPlanLimits =>
      'Plan limits still apply: Free 3/month, Plus 10/month, Pro 100/month, KVONT 1000/month.';

  @override
  String get alertManualInvalidUrl =>
      'Paste a full public http(s) product URL.';

  @override
  String get alertManualPriceUnavailable =>
      'Current price is unavailable for this link.';

  @override
  String get alertManualLimitTitle => 'Price alert limit reached';

  @override
  String get alertManualLimitMessage =>
      'Your monthly alert quota is finished. Upgrade to create more alerts and unlock faster monitoring.';

  @override
  String get alertManualCreated => 'Price alert created from store link.';

  @override
  String get alertManualTitle => 'Manual link alert';

  @override
  String get alertManualSubtitle =>
      'Paste a product URL. Dealio will read the price and monitor that exact store page.';

  @override
  String get alertManualStepLink => '1. Store product link';

  @override
  String get alertManualAnalyzeLink => 'Analyze link';

  @override
  String get alertManualSecurityNote =>
      'For security, only public http(s) product pages are accepted. Local/private network links are blocked on the backend.';

  @override
  String get alertManualWaitingAnalysis => 'Waiting for analysis';

  @override
  String get alertManualAnalyzeForPrice =>
      'Analyze the link to detect current price.';

  @override
  String alertManualQuoteConfidence(String store, String confidence) {
    return '$store - confidence $confidence';
  }

  @override
  String get alertManualStoreFallback => 'Store';

  @override
  String get alertManualStepSignal => '2. Price signal';

  @override
  String get alertManualAnalyzeTargetHint =>
      'Analyze the link first so we can calculate your target.';

  @override
  String get alertSheetStatNow => 'Now';

  @override
  String get alertSheetStoreNameOptional => 'Store name (optional)';

  @override
  String get alertSheetCustomStoreLink => 'Or paste any store link';

  @override
  String get alertSheetCheckStore => 'Check this store';

  @override
  String get alertSheetCustomStoreInvalid =>
      'Enter a full http(s) product URL so Dealio can safely track this store.';

  @override
  String alertSheetCustomStoreScope(String domain) {
    return 'Custom store scope: $domain';
  }

  @override
  String get alertSheetAdvancedOptions => 'Advanced options';

  @override
  String get alertSheetAdvancedSubtitle =>
      'Cooldown and KVONT one-tap readiness.';

  @override
  String get resultsTopPick => 'TOP PICK';

  @override
  String get resultsPriceSyncing => 'PRICE SYNCING';

  @override
  String get resultsBestLivePrice => 'BEST LIVE PRICE';

  @override
  String get resultsCheckingStores => 'Checking stores';

  @override
  String get resultsReady => 'Ready';

  @override
  String get resultsLive => 'Live';

  @override
  String get resultsDealioTake => 'Dealio take';

  @override
  String get resultsPricePending => 'Price pending';

  @override
  String get resultsFinalAiDelayed =>
      'Final AI ranking was delayed, but store results are ready.';

  @override
  String get resultsStoreValidationDelayed =>
      'Store validation was delayed, continuing with available matches.';

  @override
  String get resultsProductFallback => 'Product';

  @override
  String get resultsSmartMatch => 'Smart match';

  @override
  String get resultsLiveOffersTitle => 'Live store prices';

  @override
  String get resultsLiveOffersSubtitle =>
      'Real offers returned for this search.';

  @override
  String get resultsBestBadge => 'BEST';

  @override
  String get resultsOfferAvailable => 'Available';

  @override
  String get resultsOfferUnavailable => 'Unavailable';

  @override
  String get resultsFitLabel => 'FIT';

  @override
  String resultsFitScore(int score) {
    return '$score fit';
  }

  @override
  String get resultsCountryFallback => 'Global';

  @override
  String get resultsProviderFallback => 'Smart';

  @override
  String get resultsOpenProductTooltip => 'View product details';

  @override
  String get resultsOpenDealTooltip => 'Open store deal';

  @override
  String get resultsCreateAlertTooltip => 'Create price alert';

  @override
  String get resultsMatchesSubtitle =>
      'Real products returned for this search.';

  @override
  String get resultsNoLiveOffers =>
      'Live store prices appear when verified offers are available.';

  @override
  String get resultsStoreFallback => 'Store';

  @override
  String get aiChatTitle => 'Dealio';

  @override
  String get aiChatSubtitle => 'Shopping-only personal advisor';

  @override
  String get aiChatNewChat => 'New chat';

  @override
  String get aiChatHistory => 'Chats';

  @override
  String get aiChatRenameChat => 'Rename chat';

  @override
  String get aiChatDeleteChat => 'Delete chat';

  @override
  String get aiChatRenameTitle => 'Rename chat';

  @override
  String get aiChatRenameHint => 'Chat name';

  @override
  String get aiChatRenameSave => 'Save name';

  @override
  String get aiChatDeleteTitle => 'Delete chat?';

  @override
  String get aiChatDeleteBody =>
      'This removes the chat from your history. You can start a new one anytime.';

  @override
  String get aiChatDeleteConfirm => 'Delete chat';

  @override
  String get aiChatActionFailed =>
      'Could not update this chat. Please try again.';

  @override
  String get aiChatManualActions => 'Manual tools';

  @override
  String get aiChatAddToChat => 'Add to chat';

  @override
  String get aiChatAttachBarcode => 'Barcode scan';

  @override
  String get aiChatAttachImage => 'Image search';

  @override
  String get aiChatEmptyNameFallback => 'Friend';

  @override
  String aiChatEmptyTitle(String name) {
    return '$name, what are we buying today?';
  }

  @override
  String get aiChatEmptySubtitle => 'I\'m ready.';

  @override
  String get aiChatErrorReply =>
      'Temporary AI issue. Please retry, or share your budget, country, and top priorities so I can guide you safely.';

  @override
  String get aiChatInputHint => 'Write to Dealio...';

  @override
  String get aiChatThinkingAnalyzing => 'Analyzing your request';

  @override
  String get aiChatThinkingSearching => 'Searching trusted stores';

  @override
  String get aiChatThinkingPricing => 'Checking price signals';

  @override
  String get aiChatThinkingRanking => 'Ranking best options';

  @override
  String get aiChatEmptyHintPrefix => 'Try';

  @override
  String get aiChatEmptyHintCamera =>
      'Find a phone with a strong camera under \$900';

  @override
  String get aiChatEmptyHintBudget => 'Compare trusted stores for my budget';

  @override
  String get aiChatEmptyHintAlert => 'Tell me when this product drops in price';

  @override
  String get aiAgentActionNeeds => 'Ask needs';

  @override
  String get aiAgentActionResults => 'Best results';

  @override
  String get aiAgentActionAlert => 'Price alert';

  @override
  String get aiAgentActionAdvice => 'Advice';

  @override
  String get aiAgentActionCompare => 'Compare stores';

  @override
  String get aiAgentFeedbackHelpful => 'Helpful';

  @override
  String get aiAgentFeedbackImprove => 'Improve';

  @override
  String get aiAgentFeedbackSaved => 'Feedback noted';

  @override
  String get aiAgentFeedbackHelpfulThanks => 'Thanks — signal noted.';

  @override
  String get aiAgentFeedbackImproveThanks =>
      'Got it — I’ll tune the next answer.';

  @override
  String get aiAgentPromptNeeds =>
      'Ask me 3 short questions to understand my needs, budget, country, and priorities before recommending products.';

  @override
  String get aiAgentPromptResults =>
      'Show the best product options as a concise ranked list with price, trust, pros, cons, and the safest next step.';

  @override
  String get aiAgentPromptAdvice =>
      'Give me a short buying recommendation: what to choose, what to avoid, and why.';

  @override
  String get aiAgentPromptCompareStores =>
      'Compare trusted stores for this product by price, delivery, return policy, authenticity, and risk.';

  @override
  String get aiStructuredDecision => 'DEALIO DECISION';

  @override
  String get aiStructuredBestMatches => 'BEST MATCHES';

  @override
  String get aiStructuredQuestions => 'QUESTIONS';

  @override
  String get aiStructuredPriceWatch => 'PRICE WATCH';

  @override
  String get aiStructuredPriceWatchSubtitle =>
      'I can watch this price and notify you when it becomes safer to buy.';

  @override
  String get aiStructuredStartAlert => 'Track';

  @override
  String get aiAgentAlertTitle => 'Watch this price?';

  @override
  String get aiAgentAlertSubtitle =>
      'Dealio will check fresh prices and notify you when the target is reached.';

  @override
  String get aiAgentAlertLoading => 'Checking the latest price...';

  @override
  String get aiAgentAlertQuoteUnavailable =>
      'I could not read a reliable price yet. Paste a product link or use advanced setup.';

  @override
  String get aiAgentAlertPasteLink =>
      'Paste a product link so Dealio can track it.';

  @override
  String get aiAgentAlertLinkHint => 'https://store.com/product...';

  @override
  String get aiAgentAlertCheckLink => 'Check link';

  @override
  String get aiAgentAlertCreate => 'Create alert';

  @override
  String get aiAgentAlertAdvanced => 'Advanced setup';

  @override
  String get aiAgentAlertSelectedProduct => 'Selected product';

  @override
  String get aiAgentAlertCurrent => 'Now';

  @override
  String get aiAgentAlertTarget => 'Target';

  @override
  String get aiAgentAlertAnyStore => 'Any trusted store';

  @override
  String aiAgentAlertStoreScope(String store) {
    return 'Tracking scope: $store';
  }

  @override
  String get aiAgentAlertPriceUnknown => 'Unknown';

  @override
  String get aiAgentAlertNeedProduct =>
      'I need a product or store link to create this alert.';

  @override
  String get aiAgentAlertCreatedMessage =>
      'Price watch is live. I’ll notify you when the target is reached.';

  @override
  String aiAgentSearchResults(String query, int count) {
    return 'I found $count strong result(s) for “$query”.';
  }

  @override
  String aiAgentSearchNoResults(String query) {
    return 'I could not find strong product matches for “$query” yet. Try adding budget, country, or store preference.';
  }

  @override
  String get aiAgentSearchFailed =>
      'Agent search is temporarily unavailable. I can still help refine the query.';

  @override
  String aiStructuredMatchScore(int score) {
    return '$score% match';
  }

  @override
  String get aiChatUserLabel => 'You';

  @override
  String get aiChatAssistantLabel => 'Dealio AI';

  @override
  String get searchHistoryEmpty => 'Recent searches will appear here';

  @override
  String get searchHeaderTitle => 'Dealio Search';

  @override
  String searchQuotaCompact(String plan, int remaining) {
    return '$plan • $remaining left';
  }

  @override
  String searchQuotaUnlimitedCompact(String plan) {
    return '$plan • unlimited';
  }

  @override
  String get searchInputLabel => 'Search';

  @override
  String get searchButtonLabel => 'Search';

  @override
  String get searchAiNeedsTitle => 'Dealio AI';

  @override
  String get searchAiNeedsSubtitle => 'Write your needs to Dealio.';

  @override
  String get searchAiNeedsHint =>
      'Example: strong battery, good camera, lightweight, under \$900...';

  @override
  String get searchNeedChipCamera => 'camera';

  @override
  String get searchNeedChipBattery => 'battery';

  @override
  String get searchNeedChipBudget => 'under \$900';

  @override
  String get searchNeedChipDurable => 'durable';

  @override
  String get searchRecentTitle => 'Recent searches';

  @override
  String get searchFiltersTitle => 'Filters';

  @override
  String get searchFiltersSubtitle => 'Country, stores, and budget';

  @override
  String get searchFiltersButton => 'Filters';

  @override
  String get searchFiltersApply => 'Apply filters';

  @override
  String get searchFiltersClearStores => 'Clear stores';

  @override
  String get searchBudgetLabel => 'Budget';

  @override
  String get searchBudgetActive => 'Budget set';

  @override
  String get searchBudgetHint => 'Optional max price';

  @override
  String get searchBudgetInvalid => 'Enter a valid budget';

  @override
  String get searchCountryLabel => 'Country';

  @override
  String get searchStoresLabel => 'Choose stores only when needed.';

  @override
  String get searchAdvancedTitle => 'Advanced';

  @override
  String get searchGlobalScope => 'Global stores';

  @override
  String searchSelectedScope(int count) {
    return '$count selected stores';
  }

  @override
  String searchHistoryStores(int count) {
    return '$count stores';
  }

  @override
  String get searchHistoryContext => 'context';

  @override
  String get searchCountryFallback => 'Country';
}
