import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_ru.dart';
import 'app_localizations_uz.dart';
import 'app_localizations_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('ru'),
    Locale('es'),
    Locale('uz'),
    Locale('zh'),
  ];

  /// No description provided for @navHome.
  ///
  /// In en, this message translates to:
  /// **'Agent'**
  String get navHome;

  /// No description provided for @navSearch.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get navSearch;

  /// No description provided for @navProfile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get navProfile;

  /// No description provided for @aboutTitle.
  ///
  /// In en, this message translates to:
  /// **'About Dealio'**
  String get aboutTitle;

  /// No description provided for @aboutSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Built for smarter shopping'**
  String get aboutSubtitle;

  /// No description provided for @languageTitle.
  ///
  /// In en, this message translates to:
  /// **'App Language'**
  String get languageTitle;

  /// No description provided for @languageSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Search and AI results follow this language'**
  String get languageSubtitle;

  /// No description provided for @langEnglish.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get langEnglish;

  /// No description provided for @langRussian.
  ///
  /// In en, this message translates to:
  /// **'Russian'**
  String get langRussian;

  /// No description provided for @langSpanish.
  ///
  /// In en, this message translates to:
  /// **'Spanish'**
  String get langSpanish;

  /// No description provided for @langUzbek.
  ///
  /// In en, this message translates to:
  /// **'Uzbek'**
  String get langUzbek;

  /// No description provided for @langChinese.
  ///
  /// In en, this message translates to:
  /// **'Chinese'**
  String get langChinese;

  /// No description provided for @searchPlanUnlimited.
  ///
  /// In en, this message translates to:
  /// **'{plan} Plan - Unlimited search'**
  String searchPlanUnlimited(String plan);

  /// No description provided for @searchPlanRemaining.
  ///
  /// In en, this message translates to:
  /// **'{plan} Plan - {remaining} searches left'**
  String searchPlanRemaining(String plan, int remaining);

  /// No description provided for @searchValidationQueryRequired.
  ///
  /// In en, this message translates to:
  /// **'Please enter a product'**
  String get searchValidationQueryRequired;

  /// No description provided for @searchQueryHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. iPhone 13 128GB'**
  String get searchQueryHint;

  /// No description provided for @commonRetry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get commonRetry;

  /// No description provided for @searchUseUS.
  ///
  /// In en, this message translates to:
  /// **'Use US'**
  String get searchUseUS;

  /// No description provided for @searchFreeModeHint.
  ///
  /// In en, this message translates to:
  /// **'FREE mode: global stores are loaded automatically by country.'**
  String get searchFreeModeHint;

  /// No description provided for @searchManualStoreHint.
  ///
  /// In en, this message translates to:
  /// **'Global store link/domain (amazon.com)'**
  String get searchManualStoreHint;

  /// No description provided for @commonAdd.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get commonAdd;

  /// No description provided for @searchStoreSearchHint.
  ///
  /// In en, this message translates to:
  /// **'Search stores...'**
  String get searchStoreSearchHint;

  /// No description provided for @searchStoresEmpty.
  ///
  /// In en, this message translates to:
  /// **'Stores for the selected country will appear here.'**
  String get searchStoresEmpty;

  /// No description provided for @searchStoresLoadFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to load stores. Please try again.'**
  String get searchStoresLoadFailed;

  /// No description provided for @searchErrorCountryRequired.
  ///
  /// In en, this message translates to:
  /// **'Country is required. Please select a country first.'**
  String get searchErrorCountryRequired;

  /// No description provided for @searchPlanLimitTitle.
  ///
  /// In en, this message translates to:
  /// **'Plan Limit Reached'**
  String get searchPlanLimitTitle;

  /// No description provided for @searchPlanLimitMessage.
  ///
  /// In en, this message translates to:
  /// **'Your plan limit is reached. Upgrade to continue.'**
  String get searchPlanLimitMessage;

  /// No description provided for @searchErrorEnterStoreDomain.
  ///
  /// In en, this message translates to:
  /// **'Enter a store domain or URL. Example: amazon.com'**
  String get searchErrorEnterStoreDomain;

  /// No description provided for @searchErrorStoreAlreadySelected.
  ///
  /// In en, this message translates to:
  /// **'This store is already selected.'**
  String get searchErrorStoreAlreadySelected;

  /// No description provided for @searchErrorStoreLimit.
  ///
  /// In en, this message translates to:
  /// **'You can select up to {max} stores.'**
  String searchErrorStoreLimit(int max);

  /// No description provided for @commonEdit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get commonEdit;

  /// No description provided for @resultsLoadingTitle.
  ///
  /// In en, this message translates to:
  /// **'Scanning global stores...'**
  String get resultsLoadingTitle;

  /// No description provided for @alertsCheckNow.
  ///
  /// In en, this message translates to:
  /// **'Check now'**
  String get alertsCheckNow;

  /// No description provided for @alertSheetAllStores.
  ///
  /// In en, this message translates to:
  /// **'All stores'**
  String get alertSheetAllStores;

  /// No description provided for @alertSheetUserConsent.
  ///
  /// In en, this message translates to:
  /// **'I approve one-tap checkout'**
  String get alertSheetUserConsent;

  /// No description provided for @alertsTargetNA.
  ///
  /// In en, this message translates to:
  /// **'Target: N/A'**
  String get alertsTargetNA;

  /// No description provided for @alertSheetStatHigh.
  ///
  /// In en, this message translates to:
  /// **'High'**
  String get alertSheetStatHigh;

  /// No description provided for @settingsLogoutSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Securely sign out from this device'**
  String get settingsLogoutSubtitle;

  /// No description provided for @alertSheetTitle.
  ///
  /// In en, this message translates to:
  /// **'Create Price Alert'**
  String get alertSheetTitle;

  /// No description provided for @favoritesTitle.
  ///
  /// In en, this message translates to:
  /// **'Favorites'**
  String get favoritesTitle;

  /// No description provided for @resultsEmptyDescription.
  ///
  /// In en, this message translates to:
  /// **'Try refining your keywords, country, or store settings.'**
  String get resultsEmptyDescription;

  /// No description provided for @planPlus.
  ///
  /// In en, this message translates to:
  /// **'Plus'**
  String get planPlus;

  /// No description provided for @resultsLoadingSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Aggregating offers and AI matching in realtime.'**
  String get resultsLoadingSubtitle;

  /// No description provided for @resultsStage2ReadySubtitle.
  ///
  /// In en, this message translates to:
  /// **'AI profile generated, validating store confidence.'**
  String get resultsStage2ReadySubtitle;

  /// No description provided for @alertsTriggers.
  ///
  /// In en, this message translates to:
  /// **'Triggers: {count}'**
  String alertsTriggers(int count);

  /// No description provided for @alertsDealButton.
  ///
  /// In en, this message translates to:
  /// **'Open deal'**
  String get alertsDealButton;

  /// No description provided for @alertSheetCurrentTarget.
  ///
  /// In en, this message translates to:
  /// **'Current: {observed}  Target: {target}'**
  String alertSheetCurrentTarget(String target, String observed);

  /// No description provided for @settingsSearchesLeft.
  ///
  /// In en, this message translates to:
  /// **'{remaining}/{limit} searches left'**
  String settingsSearchesLeft(int remaining, int limit);

  /// No description provided for @planFree.
  ///
  /// In en, this message translates to:
  /// **'Free'**
  String get planFree;

  /// No description provided for @commonLogout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get commonLogout;

  /// No description provided for @alertEventsEmpty.
  ///
  /// In en, this message translates to:
  /// **'No alert events yet.'**
  String get alertEventsEmpty;

  /// No description provided for @commonSettings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get commonSettings;

  /// No description provided for @alertEventsError.
  ///
  /// In en, this message translates to:
  /// **'Failed to load events: {error}'**
  String alertEventsError(String error);

  /// No description provided for @resultsStage1ReadySubtitle.
  ///
  /// In en, this message translates to:
  /// **'Market scan complete, preparing AI profile.'**
  String get resultsStage1ReadySubtitle;

  /// No description provided for @alertSheetRefreshQuote.
  ///
  /// In en, this message translates to:
  /// **'Refresh quote'**
  String get alertSheetRefreshQuote;

  /// No description provided for @alertsEmptySubtitle.
  ///
  /// In en, this message translates to:
  /// **'Create your first alert from search results to track price drops.'**
  String get alertsEmptySubtitle;

  /// No description provided for @alertSheetArmAutoBuy.
  ///
  /// In en, this message translates to:
  /// **'Arm auto-buy'**
  String get alertSheetArmAutoBuy;

  /// No description provided for @resultsUpgradePlanTitle.
  ///
  /// In en, this message translates to:
  /// **'Upgrade your plan'**
  String get resultsUpgradePlanTitle;

  /// No description provided for @alertSheetKvontTitle.
  ///
  /// In en, this message translates to:
  /// **'KVONT Auto-buy Controls'**
  String get alertSheetKvontTitle;

  /// No description provided for @commonCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get commonCancel;

  /// No description provided for @commonDelete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get commonDelete;

  /// No description provided for @resultsUnexpectedError.
  ///
  /// In en, this message translates to:
  /// **'Something unexpected happened during search.'**
  String get resultsUnexpectedError;

  /// No description provided for @resultsEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'No matching products found'**
  String get resultsEmptyTitle;

  /// No description provided for @alertSheetWaitingPrice.
  ///
  /// In en, this message translates to:
  /// **'Waiting for realtime price...'**
  String get alertSheetWaitingPrice;

  /// No description provided for @settingsThemeTitle.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get settingsThemeTitle;

  /// No description provided for @favoritesEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'No favorites yet'**
  String get favoritesEmptyTitle;

  /// No description provided for @commonUpgrade.
  ///
  /// In en, this message translates to:
  /// **'Upgrade'**
  String get commonUpgrade;

  /// No description provided for @favoritesAnalyze.
  ///
  /// In en, this message translates to:
  /// **'Analyze'**
  String get favoritesAnalyze;

  /// No description provided for @resultsStageFindingTitle.
  ///
  /// In en, this message translates to:
  /// **'Finding best offers'**
  String get resultsStageFindingTitle;

  /// No description provided for @alertSheetTriggerSetup.
  ///
  /// In en, this message translates to:
  /// **'Trigger setup'**
  String get alertSheetTriggerSetup;

  /// No description provided for @resultsStageFindingSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Collecting initial market signals.'**
  String get resultsStageFindingSubtitle;

  /// No description provided for @alertSheetSaveButton.
  ///
  /// In en, this message translates to:
  /// **'Save Alert'**
  String get alertSheetSaveButton;

  /// No description provided for @alertSheetRealtimeMonitoring.
  ///
  /// In en, this message translates to:
  /// **'Realtime monitoring'**
  String get alertSheetRealtimeMonitoring;

  /// No description provided for @resultsStage2ReadyTitle.
  ///
  /// In en, this message translates to:
  /// **'Stage 2 ready'**
  String get resultsStage2ReadyTitle;

  /// No description provided for @settingsSubscriptionUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Subscription unavailable'**
  String get settingsSubscriptionUnavailable;

  /// No description provided for @resultsUpgradeNow.
  ///
  /// In en, this message translates to:
  /// **'Upgrade now'**
  String get resultsUpgradeNow;

  /// No description provided for @alertSheetKvontSubtitle.
  ///
  /// In en, this message translates to:
  /// **'These options only prepare notification actions; payment still needs your confirmation.'**
  String get alertSheetKvontSubtitle;

  /// No description provided for @resultsAdjustParameters.
  ///
  /// In en, this message translates to:
  /// **'Adjust search parameters'**
  String get resultsAdjustParameters;

  /// No description provided for @commonClear.
  ///
  /// In en, this message translates to:
  /// **'Clear'**
  String get commonClear;

  /// No description provided for @settingsPlanLabel.
  ///
  /// In en, this message translates to:
  /// **'{plan} Plan'**
  String settingsPlanLabel(String plan);

  /// No description provided for @alertsTargetValue.
  ///
  /// In en, this message translates to:
  /// **'Target: \${price}'**
  String alertsTargetValue(String price);

  /// No description provided for @alertSheetStoreTargeting.
  ///
  /// In en, this message translates to:
  /// **'Store targeting'**
  String get alertSheetStoreTargeting;

  /// No description provided for @resultsUpgradePlanMessage.
  ///
  /// In en, this message translates to:
  /// **'Move to a higher plan for more searches and deeper AI analysis.'**
  String get resultsUpgradePlanMessage;

  /// No description provided for @alertSheetCooldownLabel.
  ///
  /// In en, this message translates to:
  /// **'Cooldown (minutes)'**
  String get alertSheetCooldownLabel;

  /// No description provided for @settingsDarkEnabled.
  ///
  /// In en, this message translates to:
  /// **'Dark mode enabled'**
  String get settingsDarkEnabled;

  /// No description provided for @alertsKvontPaywallMessage.
  ///
  /// In en, this message translates to:
  /// **'Unlock realtime alerts, price trend analytics, and checkout-ready links.'**
  String get alertsKvontPaywallMessage;

  /// No description provided for @alertsKvontUpgradeMessage.
  ///
  /// In en, this message translates to:
  /// **'Upgrade to KVONT for realtime monitoring, trend charts, and auto-buy prep.'**
  String get alertsKvontUpgradeMessage;

  /// No description provided for @resultsProductsOptimized.
  ///
  /// In en, this message translates to:
  /// **'{count} products optimized'**
  String resultsProductsOptimized(int count);

  /// No description provided for @settingsNotificationsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Price alerts and app updates'**
  String get settingsNotificationsSubtitle;

  /// No description provided for @planKvont.
  ///
  /// In en, this message translates to:
  /// **'Kvont'**
  String get planKvont;

  /// No description provided for @planPro.
  ///
  /// In en, this message translates to:
  /// **'Pro'**
  String get planPro;

  /// No description provided for @resultsNeuralGlitch.
  ///
  /// In en, this message translates to:
  /// **'Search issue'**
  String get resultsNeuralGlitch;

  /// No description provided for @alertSheetTargetInvalid.
  ///
  /// In en, this message translates to:
  /// **'Target must be lower than current price.'**
  String get alertSheetTargetInvalid;

  /// No description provided for @alertsKvontPaywallTitle.
  ///
  /// In en, this message translates to:
  /// **'KVONT Super Alerts'**
  String get alertsKvontPaywallTitle;

  /// No description provided for @alertSheetStatTarget.
  ///
  /// In en, this message translates to:
  /// **'Target'**
  String get alertSheetStatTarget;

  /// No description provided for @alertSheetCheckoutPrepared.
  ///
  /// In en, this message translates to:
  /// **'Checkout link prepared'**
  String get alertSheetCheckoutPrepared;

  /// No description provided for @alertSheetStatLow.
  ///
  /// In en, this message translates to:
  /// **'Low'**
  String get alertSheetStatLow;

  /// No description provided for @settingsPrivacySubtitle.
  ///
  /// In en, this message translates to:
  /// **'Manage privacy preferences'**
  String get settingsPrivacySubtitle;

  /// No description provided for @resultsStage3ReadyTitle.
  ///
  /// In en, this message translates to:
  /// **'Stage 3 ready'**
  String get resultsStage3ReadyTitle;

  /// No description provided for @alertsLastTrigger.
  ///
  /// In en, this message translates to:
  /// **'Last trigger: {time}'**
  String alertsLastTrigger(String time);

  /// No description provided for @resultsSearchQuotaTitle.
  ///
  /// In en, this message translates to:
  /// **'Search quota'**
  String get resultsSearchQuotaTitle;

  /// No description provided for @resultsSearchLimitReached.
  ///
  /// In en, this message translates to:
  /// **'Search limit reached'**
  String get resultsSearchLimitReached;

  /// No description provided for @alertSheetRealtimeUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Realtime price unavailable. Refresh quote and try again.'**
  String get alertSheetRealtimeUnavailable;

  /// No description provided for @alertsDeleteTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete alert?'**
  String get alertsDeleteTitle;

  /// No description provided for @alertsEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'No active alerts'**
  String get alertsEmptyTitle;

  /// No description provided for @alertsCheckNowResult.
  ///
  /// In en, this message translates to:
  /// **'Checked: {checked}  Triggered: {triggered}  Errors: {errors}'**
  String alertsCheckNowResult(String checked, String errors, String triggered);

  /// No description provided for @alertEventsTitle.
  ///
  /// In en, this message translates to:
  /// **'Alert Events'**
  String get alertEventsTitle;

  /// No description provided for @resultsStage3ReadySubtitle.
  ///
  /// In en, this message translates to:
  /// **'Final ranking is ready with best alternatives.'**
  String get resultsStage3ReadySubtitle;

  /// No description provided for @alertSheetTrendTitle.
  ///
  /// In en, this message translates to:
  /// **'Price trend (recent)'**
  String get alertSheetTrendTitle;

  /// No description provided for @commonManage.
  ///
  /// In en, this message translates to:
  /// **'Manage'**
  String get commonManage;

  /// No description provided for @favoritesStartShopping.
  ///
  /// In en, this message translates to:
  /// **'Start shopping'**
  String get favoritesStartShopping;

  /// No description provided for @settingsNotificationsTitle.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get settingsNotificationsTitle;

  /// No description provided for @settingsLightEnabled.
  ///
  /// In en, this message translates to:
  /// **'Light mode enabled'**
  String get settingsLightEnabled;

  /// No description provided for @alertSheetCooldownHelper.
  ///
  /// In en, this message translates to:
  /// **'Minimum 5 minutes, maximum 1440 minutes.'**
  String get alertSheetCooldownHelper;

  /// No description provided for @alertsKvontSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Realtime worker keeps your alerts synced with store prices.'**
  String get alertsKvontSubtitle;

  /// No description provided for @alertsCreateTooltip.
  ///
  /// In en, this message translates to:
  /// **'Create alert'**
  String get alertsCreateTooltip;

  /// No description provided for @settingsPrivacyTitle.
  ///
  /// In en, this message translates to:
  /// **'Privacy & Security'**
  String get settingsPrivacyTitle;

  /// No description provided for @alertEventsTriggeredAt.
  ///
  /// In en, this message translates to:
  /// **'Triggered at \${triggerPrice} (target \${targetPrice})'**
  String alertEventsTriggeredAt(String targetPrice, String triggerPrice);

  /// No description provided for @alertSheetRealtimeMonitoringSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Continuously checks prices for faster triggers.'**
  String get alertSheetRealtimeMonitoringSubtitle;

  /// No description provided for @resultsNeuralSearch.
  ///
  /// In en, this message translates to:
  /// **'Neural Search'**
  String get resultsNeuralSearch;

  /// No description provided for @alertsKvontActive.
  ///
  /// In en, this message translates to:
  /// **'KVONT realtime monitoring active'**
  String get alertsKvontActive;

  /// No description provided for @alertSheetRealtimePriceLabel.
  ///
  /// In en, this message translates to:
  /// **'Realtime price'**
  String get alertSheetRealtimePriceLabel;

  /// No description provided for @alertsTitle.
  ///
  /// In en, this message translates to:
  /// **'Alerts'**
  String get alertsTitle;

  /// No description provided for @alertSheetDropAmount.
  ///
  /// In en, this message translates to:
  /// **'Drop \$'**
  String get alertSheetDropAmount;

  /// No description provided for @alertEventsViewDeal.
  ///
  /// In en, this message translates to:
  /// **'View deal'**
  String get alertEventsViewDeal;

  /// No description provided for @alertSheetSaved.
  ///
  /// In en, this message translates to:
  /// **'Alert created successfully.'**
  String get alertSheetSaved;

  /// No description provided for @resultsStage1ReadyTitle.
  ///
  /// In en, this message translates to:
  /// **'Stage 1 ready'**
  String get resultsStage1ReadyTitle;

  /// No description provided for @alertsDeleteMessage.
  ///
  /// In en, this message translates to:
  /// **'This action removes the alert and its realtime monitoring.'**
  String get alertsDeleteMessage;

  /// No description provided for @alertSheetDropPercent.
  ///
  /// In en, this message translates to:
  /// **'Drop %'**
  String get alertSheetDropPercent;

  /// No description provided for @favoritesSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Your saved products and quick re-check list.'**
  String get favoritesSubtitle;

  /// No description provided for @resultsTryAgain.
  ///
  /// In en, this message translates to:
  /// **'Try again'**
  String get resultsTryAgain;

  /// No description provided for @favoritesEmptySubtitle.
  ///
  /// In en, this message translates to:
  /// **'Save products to track better prices and safer alternatives.'**
  String get favoritesEmptySubtitle;

  /// No description provided for @alertsNever.
  ///
  /// In en, this message translates to:
  /// **'Never'**
  String get alertsNever;

  /// No description provided for @alertsHistoryTooltip.
  ///
  /// In en, this message translates to:
  /// **'Alert history'**
  String get alertsHistoryTooltip;

  /// No description provided for @onboardingSlide1Desc.
  ///
  /// In en, this message translates to:
  /// **'Instantly compare deals across global retailers to find the best price.'**
  String get onboardingSlide1Desc;

  /// No description provided for @authEmailLabel.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get authEmailLabel;

  /// No description provided for @onboardingSlide2Desc.
  ///
  /// In en, this message translates to:
  /// **'AI verifies product originality and seller reliability before you buy.'**
  String get onboardingSlide2Desc;

  /// No description provided for @authEmailHint.
  ///
  /// In en, this message translates to:
  /// **'you@example.com'**
  String get authEmailHint;

  /// No description provided for @loginCreateAccount.
  ///
  /// In en, this message translates to:
  /// **'Create new account'**
  String get loginCreateAccount;

  /// No description provided for @authFullNameMinChars.
  ///
  /// In en, this message translates to:
  /// **'Minimum {min} characters'**
  String authFullNameMinChars(int min);

  /// No description provided for @profilePaymentMethodsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Credit cards & wallets'**
  String get profilePaymentMethodsSubtitle;

  /// No description provided for @loginBackOnboarding.
  ///
  /// In en, this message translates to:
  /// **'Back to onboarding'**
  String get loginBackOnboarding;

  /// No description provided for @onboardingNext.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get onboardingNext;

  /// No description provided for @profileNotifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get profileNotifications;

  /// No description provided for @profileSecurity.
  ///
  /// In en, this message translates to:
  /// **'Security'**
  String get profileSecurity;

  /// No description provided for @loginButton.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get loginButton;

  /// No description provided for @authPasswordLabel.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get authPasswordLabel;

  /// No description provided for @splashTagline.
  ///
  /// In en, this message translates to:
  /// **'Deals You Can Trust'**
  String get splashTagline;

  /// No description provided for @onboardingSlide3Desc.
  ///
  /// In en, this message translates to:
  /// **'Understand real buyer feedback with smart sentiment summaries.'**
  String get onboardingSlide3Desc;

  /// No description provided for @onboardingGetStarted.
  ///
  /// In en, this message translates to:
  /// **'Get Started'**
  String get onboardingGetStarted;

  /// No description provided for @authFullNameLabel.
  ///
  /// In en, this message translates to:
  /// **'Full Name'**
  String get authFullNameLabel;

  /// No description provided for @registerCreateAccount.
  ///
  /// In en, this message translates to:
  /// **'Create Account'**
  String get registerCreateAccount;

  /// No description provided for @authPasswordHint.
  ///
  /// In en, this message translates to:
  /// **'Enter your password'**
  String get authPasswordHint;

  /// No description provided for @profileSettingsPreferences.
  ///
  /// In en, this message translates to:
  /// **'Settings & Preferences'**
  String get profileSettingsPreferences;

  /// No description provided for @onboardingSlide4Title.
  ///
  /// In en, this message translates to:
  /// **'Smart Alerts'**
  String get onboardingSlide4Title;

  /// No description provided for @registerSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Join Dealio and unlock smart shopping workflows'**
  String get registerSubtitle;

  /// No description provided for @onboardingBack.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get onboardingBack;

  /// No description provided for @loginWelcomeBack.
  ///
  /// In en, this message translates to:
  /// **'Welcome Back'**
  String get loginWelcomeBack;

  /// No description provided for @onboardingSkip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get onboardingSkip;

  /// No description provided for @loginForgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot Password?'**
  String get loginForgotPassword;

  /// No description provided for @onboardingSlide1Title.
  ///
  /// In en, this message translates to:
  /// **'Global Price Comparison'**
  String get onboardingSlide1Title;

  /// No description provided for @registerButton.
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get registerButton;

  /// No description provided for @authPasswordMinChars.
  ///
  /// In en, this message translates to:
  /// **'Minimum {min} characters'**
  String authPasswordMinChars(int min);

  /// No description provided for @loginSignInContinue.
  ///
  /// In en, this message translates to:
  /// **'Sign in to continue'**
  String get loginSignInContinue;

  /// No description provided for @profileName.
  ///
  /// In en, this message translates to:
  /// **'Alex Robinson'**
  String get profileName;

  /// No description provided for @profilePointsProgress.
  ///
  /// In en, this message translates to:
  /// **'{current} / {total} points'**
  String profilePointsProgress(String total, String current);

  /// No description provided for @onboardingSlide4Desc.
  ///
  /// In en, this message translates to:
  /// **'Get notified when your target price is reached and act fast.'**
  String get onboardingSlide4Desc;

  /// No description provided for @profileLogout.
  ///
  /// In en, this message translates to:
  /// **'Log Out'**
  String get profileLogout;

  /// No description provided for @profileGoldStatus.
  ///
  /// In en, this message translates to:
  /// **'GOLD STATUS'**
  String get profileGoldStatus;

  /// No description provided for @registerSuccessTitle.
  ///
  /// In en, this message translates to:
  /// **'Registration Success'**
  String get registerSuccessTitle;

  /// No description provided for @profilePaymentMethods.
  ///
  /// In en, this message translates to:
  /// **'Payment Methods'**
  String get profilePaymentMethods;

  /// No description provided for @profileNotificationsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Deal alerts & app updates'**
  String get profileNotificationsSubtitle;

  /// No description provided for @profileCashbackBalance.
  ///
  /// In en, this message translates to:
  /// **'Cashback Balance'**
  String get profileCashbackBalance;

  /// No description provided for @onboardingSlide2Title.
  ///
  /// In en, this message translates to:
  /// **'Authenticity Check'**
  String get onboardingSlide2Title;

  /// No description provided for @profileNextReward.
  ///
  /// In en, this message translates to:
  /// **'Next Reward: {amount}'**
  String profileNextReward(String amount);

  /// No description provided for @authEmailInvalid.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid email'**
  String get authEmailInvalid;

  /// No description provided for @authEmailRequired.
  ///
  /// In en, this message translates to:
  /// **'Email is required'**
  String get authEmailRequired;

  /// No description provided for @authPasswordRequired.
  ///
  /// In en, this message translates to:
  /// **'Password is required'**
  String get authPasswordRequired;

  /// No description provided for @authFullNameRequired.
  ///
  /// In en, this message translates to:
  /// **'Full name is required'**
  String get authFullNameRequired;

  /// No description provided for @registerAlreadyHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Already have account? Login'**
  String get registerAlreadyHaveAccount;

  /// No description provided for @onboardingSlide3Title.
  ///
  /// In en, this message translates to:
  /// **'Reviews & Insights'**
  String get onboardingSlide3Title;

  /// No description provided for @profileSecuritySubtitle.
  ///
  /// In en, this message translates to:
  /// **'Biometrics & passwords'**
  String get profileSecuritySubtitle;

  /// No description provided for @navFavorites.
  ///
  /// In en, this message translates to:
  /// **'Favorites'**
  String get navFavorites;

  /// No description provided for @favoritesLoadFailed.
  ///
  /// In en, this message translates to:
  /// **'Saved list is out of sync'**
  String get favoritesLoadFailed;

  /// No description provided for @favoritesLoadSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Dealio could not refresh your saved products right now. Check your connection, then sync again.'**
  String get favoritesLoadSubtitle;

  /// No description provided for @favoritesLoadAction.
  ///
  /// In en, this message translates to:
  /// **'Refresh saved list'**
  String get favoritesLoadAction;

  /// No description provided for @favoritesProductFallback.
  ///
  /// In en, this message translates to:
  /// **'Product'**
  String get favoritesProductFallback;

  /// No description provided for @favoritesNoNotes.
  ///
  /// In en, this message translates to:
  /// **'Saved product'**
  String get favoritesNoNotes;

  /// No description provided for @favoritesSaveTooltip.
  ///
  /// In en, this message translates to:
  /// **'Save to favorites'**
  String get favoritesSaveTooltip;

  /// No description provided for @favoritesRemoveTooltip.
  ///
  /// In en, this message translates to:
  /// **'Remove from favorites'**
  String get favoritesRemoveTooltip;

  /// No description provided for @favoritesSaved.
  ///
  /// In en, this message translates to:
  /// **'Saved to favorites.'**
  String get favoritesSaved;

  /// No description provided for @favoritesRemoved.
  ///
  /// In en, this message translates to:
  /// **'Removed from favorites.'**
  String get favoritesRemoved;

  /// No description provided for @favoritesActionFailed.
  ///
  /// In en, this message translates to:
  /// **'Could not update saved list. Try again.'**
  String get favoritesActionFailed;

  /// No description provided for @notificationsTitle.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notificationsTitle;

  /// No description provided for @notificationsClearTitle.
  ///
  /// In en, this message translates to:
  /// **'Clear all?'**
  String get notificationsClearTitle;

  /// No description provided for @notificationsClearMessage.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to dismiss all notifications?'**
  String get notificationsClearMessage;

  /// No description provided for @notificationsUnavailableTitle.
  ///
  /// In en, this message translates to:
  /// **'Notifications unavailable'**
  String get notificationsUnavailableTitle;

  /// No description provided for @notificationsUnavailableSubtitle.
  ///
  /// In en, this message translates to:
  /// **'We could not load alerts right now. Please try again soon.'**
  String get notificationsUnavailableSubtitle;

  /// No description provided for @notificationsAtStore.
  ///
  /// In en, this message translates to:
  /// **' at {store}'**
  String notificationsAtStore(String store);

  /// No description provided for @notificationsAlertMatched.
  ///
  /// In en, this message translates to:
  /// **'A tracked product matched your alert{price}{store}.'**
  String notificationsAlertMatched(String price, String store);

  /// No description provided for @notificationsBackInStock.
  ///
  /// In en, this message translates to:
  /// **'Back in stock'**
  String get notificationsBackInStock;

  /// No description provided for @notificationsDealFound.
  ///
  /// In en, this message translates to:
  /// **'Deal found'**
  String get notificationsDealFound;

  /// No description provided for @notificationsPriceAlert.
  ///
  /// In en, this message translates to:
  /// **'Price alert'**
  String get notificationsPriceAlert;

  /// No description provided for @notificationsJustNow.
  ///
  /// In en, this message translates to:
  /// **'Just now'**
  String get notificationsJustNow;

  /// No description provided for @notificationsMinutesAgo.
  ///
  /// In en, this message translates to:
  /// **'{count}m ago'**
  String notificationsMinutesAgo(int count);

  /// No description provided for @notificationsHoursAgo.
  ///
  /// In en, this message translates to:
  /// **'{count}h ago'**
  String notificationsHoursAgo(int count);

  /// No description provided for @notificationsDaysAgo.
  ///
  /// In en, this message translates to:
  /// **'{count}d ago'**
  String notificationsDaysAgo(int count);

  /// No description provided for @notificationsTabAll.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get notificationsTabAll;

  /// No description provided for @notificationsTabPriceAlerts.
  ///
  /// In en, this message translates to:
  /// **'Price Alerts'**
  String get notificationsTabPriceAlerts;

  /// No description provided for @notificationsTabAiInsights.
  ///
  /// In en, this message translates to:
  /// **'AI Insights'**
  String get notificationsTabAiInsights;

  /// No description provided for @notificationsTabSustainability.
  ///
  /// In en, this message translates to:
  /// **'Sustainability'**
  String get notificationsTabSustainability;

  /// No description provided for @notificationsTabStoreUpdates.
  ///
  /// In en, this message translates to:
  /// **'Store Updates'**
  String get notificationsTabStoreUpdates;

  /// No description provided for @notificationsViewProduct.
  ///
  /// In en, this message translates to:
  /// **'View Product'**
  String get notificationsViewProduct;

  /// No description provided for @notificationsReanalyze.
  ///
  /// In en, this message translates to:
  /// **'Re-analyze'**
  String get notificationsReanalyze;

  /// No description provided for @notificationsEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'No notifications yet'**
  String get notificationsEmptyTitle;

  /// No description provided for @notificationsEmptySubtitle.
  ///
  /// In en, this message translates to:
  /// **'Create price alerts to receive real-time deal updates here.'**
  String get notificationsEmptySubtitle;

  /// No description provided for @alertPickerTitle.
  ///
  /// In en, this message translates to:
  /// **'Create price alert'**
  String get alertPickerTitle;

  /// No description provided for @alertPickerSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Choose how you want to start. Search is best for comparison; manual link tracks one exact store page.'**
  String get alertPickerSubtitle;

  /// No description provided for @alertPickerSearchTitle.
  ///
  /// In en, this message translates to:
  /// **'Search product'**
  String get alertPickerSearchTitle;

  /// No description provided for @alertPickerSearchSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Find a product first, compare stores, then create an alert.'**
  String get alertPickerSearchSubtitle;

  /// No description provided for @alertPickerManualTitle.
  ///
  /// In en, this message translates to:
  /// **'Manual store link'**
  String get alertPickerManualTitle;

  /// No description provided for @alertPickerManualSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Paste any public product URL and monitor that exact page.'**
  String get alertPickerManualSubtitle;

  /// No description provided for @alertPickerPlanLimits.
  ///
  /// In en, this message translates to:
  /// **'Plan limits still apply: Free 3/month, Plus 10/month, Pro 100/month, KVONT 1000/month.'**
  String get alertPickerPlanLimits;

  /// No description provided for @alertManualInvalidUrl.
  ///
  /// In en, this message translates to:
  /// **'Paste a full public http(s) product URL.'**
  String get alertManualInvalidUrl;

  /// No description provided for @alertManualPriceUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Current price is unavailable for this link.'**
  String get alertManualPriceUnavailable;

  /// No description provided for @alertManualLimitTitle.
  ///
  /// In en, this message translates to:
  /// **'Price alert limit reached'**
  String get alertManualLimitTitle;

  /// No description provided for @alertManualLimitMessage.
  ///
  /// In en, this message translates to:
  /// **'Your monthly alert quota is finished. Upgrade to create more alerts and unlock faster monitoring.'**
  String get alertManualLimitMessage;

  /// No description provided for @alertManualCreated.
  ///
  /// In en, this message translates to:
  /// **'Price alert created from store link.'**
  String get alertManualCreated;

  /// No description provided for @alertManualTitle.
  ///
  /// In en, this message translates to:
  /// **'Manual link alert'**
  String get alertManualTitle;

  /// No description provided for @alertManualSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Paste a product URL. Dealio will read the price and monitor that exact store page.'**
  String get alertManualSubtitle;

  /// No description provided for @alertManualStepLink.
  ///
  /// In en, this message translates to:
  /// **'1. Store product link'**
  String get alertManualStepLink;

  /// No description provided for @alertManualAnalyzeLink.
  ///
  /// In en, this message translates to:
  /// **'Analyze link'**
  String get alertManualAnalyzeLink;

  /// No description provided for @alertManualSecurityNote.
  ///
  /// In en, this message translates to:
  /// **'For security, only public http(s) product pages are accepted. Local/private network links are blocked on the backend.'**
  String get alertManualSecurityNote;

  /// No description provided for @alertManualWaitingAnalysis.
  ///
  /// In en, this message translates to:
  /// **'Waiting for analysis'**
  String get alertManualWaitingAnalysis;

  /// No description provided for @alertManualAnalyzeForPrice.
  ///
  /// In en, this message translates to:
  /// **'Analyze the link to detect current price.'**
  String get alertManualAnalyzeForPrice;

  /// No description provided for @alertManualQuoteConfidence.
  ///
  /// In en, this message translates to:
  /// **'{store} - confidence {confidence}'**
  String alertManualQuoteConfidence(String store, String confidence);

  /// No description provided for @alertManualStoreFallback.
  ///
  /// In en, this message translates to:
  /// **'Store'**
  String get alertManualStoreFallback;

  /// No description provided for @alertManualStepSignal.
  ///
  /// In en, this message translates to:
  /// **'2. Price signal'**
  String get alertManualStepSignal;

  /// No description provided for @alertManualAnalyzeTargetHint.
  ///
  /// In en, this message translates to:
  /// **'Analyze the link first so we can calculate your target.'**
  String get alertManualAnalyzeTargetHint;

  /// No description provided for @alertSheetStatNow.
  ///
  /// In en, this message translates to:
  /// **'Now'**
  String get alertSheetStatNow;

  /// No description provided for @alertSheetStoreNameOptional.
  ///
  /// In en, this message translates to:
  /// **'Store name (optional)'**
  String get alertSheetStoreNameOptional;

  /// No description provided for @alertSheetCustomStoreLink.
  ///
  /// In en, this message translates to:
  /// **'Or paste any store link'**
  String get alertSheetCustomStoreLink;

  /// No description provided for @alertSheetCheckStore.
  ///
  /// In en, this message translates to:
  /// **'Check this store'**
  String get alertSheetCheckStore;

  /// No description provided for @alertSheetCustomStoreInvalid.
  ///
  /// In en, this message translates to:
  /// **'Enter a full http(s) product URL so Dealio can safely track this store.'**
  String get alertSheetCustomStoreInvalid;

  /// No description provided for @alertSheetCustomStoreScope.
  ///
  /// In en, this message translates to:
  /// **'Custom store scope: {domain}'**
  String alertSheetCustomStoreScope(String domain);

  /// No description provided for @alertSheetAdvancedOptions.
  ///
  /// In en, this message translates to:
  /// **'Advanced options'**
  String get alertSheetAdvancedOptions;

  /// No description provided for @alertSheetAdvancedSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Cooldown and KVONT one-tap readiness.'**
  String get alertSheetAdvancedSubtitle;

  /// No description provided for @resultsTopPick.
  ///
  /// In en, this message translates to:
  /// **'TOP PICK'**
  String get resultsTopPick;

  /// No description provided for @resultsPriceSyncing.
  ///
  /// In en, this message translates to:
  /// **'PRICE SYNCING'**
  String get resultsPriceSyncing;

  /// No description provided for @resultsBestLivePrice.
  ///
  /// In en, this message translates to:
  /// **'BEST LIVE PRICE'**
  String get resultsBestLivePrice;

  /// No description provided for @resultsCheckingStores.
  ///
  /// In en, this message translates to:
  /// **'Checking stores'**
  String get resultsCheckingStores;

  /// No description provided for @resultsReady.
  ///
  /// In en, this message translates to:
  /// **'Ready'**
  String get resultsReady;

  /// No description provided for @resultsLive.
  ///
  /// In en, this message translates to:
  /// **'Live'**
  String get resultsLive;

  /// No description provided for @resultsDealioTake.
  ///
  /// In en, this message translates to:
  /// **'Dealio take'**
  String get resultsDealioTake;

  /// No description provided for @resultsPricePending.
  ///
  /// In en, this message translates to:
  /// **'Price pending'**
  String get resultsPricePending;

  /// No description provided for @resultsFinalAiDelayed.
  ///
  /// In en, this message translates to:
  /// **'Final AI ranking was delayed, but store results are ready.'**
  String get resultsFinalAiDelayed;

  /// No description provided for @resultsStoreValidationDelayed.
  ///
  /// In en, this message translates to:
  /// **'Store validation was delayed, continuing with available matches.'**
  String get resultsStoreValidationDelayed;

  /// No description provided for @resultsProductFallback.
  ///
  /// In en, this message translates to:
  /// **'Product'**
  String get resultsProductFallback;

  /// No description provided for @resultsSmartMatch.
  ///
  /// In en, this message translates to:
  /// **'Smart match'**
  String get resultsSmartMatch;

  /// No description provided for @resultsLiveOffersTitle.
  ///
  /// In en, this message translates to:
  /// **'Live store prices'**
  String get resultsLiveOffersTitle;

  /// No description provided for @resultsLiveOffersSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Real offers returned for this search.'**
  String get resultsLiveOffersSubtitle;

  /// No description provided for @resultsBestBadge.
  ///
  /// In en, this message translates to:
  /// **'BEST'**
  String get resultsBestBadge;

  /// No description provided for @resultsOfferAvailable.
  ///
  /// In en, this message translates to:
  /// **'Available'**
  String get resultsOfferAvailable;

  /// No description provided for @resultsOfferUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Unavailable'**
  String get resultsOfferUnavailable;

  /// No description provided for @resultsFitLabel.
  ///
  /// In en, this message translates to:
  /// **'FIT'**
  String get resultsFitLabel;

  /// No description provided for @resultsFitScore.
  ///
  /// In en, this message translates to:
  /// **'{score} fit'**
  String resultsFitScore(int score);

  /// No description provided for @resultsCountryFallback.
  ///
  /// In en, this message translates to:
  /// **'Global'**
  String get resultsCountryFallback;

  /// No description provided for @resultsProviderFallback.
  ///
  /// In en, this message translates to:
  /// **'Smart'**
  String get resultsProviderFallback;

  /// No description provided for @resultsOpenProductTooltip.
  ///
  /// In en, this message translates to:
  /// **'View product details'**
  String get resultsOpenProductTooltip;

  /// No description provided for @resultsOpenDealTooltip.
  ///
  /// In en, this message translates to:
  /// **'Open store deal'**
  String get resultsOpenDealTooltip;

  /// No description provided for @resultsCreateAlertTooltip.
  ///
  /// In en, this message translates to:
  /// **'Create price alert'**
  String get resultsCreateAlertTooltip;

  /// No description provided for @resultsMatchesSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Real products returned for this search.'**
  String get resultsMatchesSubtitle;

  /// No description provided for @resultsNoLiveOffers.
  ///
  /// In en, this message translates to:
  /// **'Live store prices appear when verified offers are available.'**
  String get resultsNoLiveOffers;

  /// No description provided for @resultsStoreFallback.
  ///
  /// In en, this message translates to:
  /// **'Store'**
  String get resultsStoreFallback;

  /// No description provided for @aiChatTitle.
  ///
  /// In en, this message translates to:
  /// **'Dealio'**
  String get aiChatTitle;

  /// No description provided for @aiChatSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Shopping-only personal advisor'**
  String get aiChatSubtitle;

  /// No description provided for @aiChatNewChat.
  ///
  /// In en, this message translates to:
  /// **'New chat'**
  String get aiChatNewChat;

  /// No description provided for @aiChatHistory.
  ///
  /// In en, this message translates to:
  /// **'Chats'**
  String get aiChatHistory;

  /// No description provided for @aiChatRenameChat.
  ///
  /// In en, this message translates to:
  /// **'Rename chat'**
  String get aiChatRenameChat;

  /// No description provided for @aiChatDeleteChat.
  ///
  /// In en, this message translates to:
  /// **'Delete chat'**
  String get aiChatDeleteChat;

  /// No description provided for @aiChatRenameTitle.
  ///
  /// In en, this message translates to:
  /// **'Rename chat'**
  String get aiChatRenameTitle;

  /// No description provided for @aiChatRenameHint.
  ///
  /// In en, this message translates to:
  /// **'Chat name'**
  String get aiChatRenameHint;

  /// No description provided for @aiChatRenameSave.
  ///
  /// In en, this message translates to:
  /// **'Save name'**
  String get aiChatRenameSave;

  /// No description provided for @aiChatDeleteTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete chat?'**
  String get aiChatDeleteTitle;

  /// No description provided for @aiChatDeleteBody.
  ///
  /// In en, this message translates to:
  /// **'This removes the chat from your history. You can start a new one anytime.'**
  String get aiChatDeleteBody;

  /// No description provided for @aiChatDeleteConfirm.
  ///
  /// In en, this message translates to:
  /// **'Delete chat'**
  String get aiChatDeleteConfirm;

  /// No description provided for @aiChatActionFailed.
  ///
  /// In en, this message translates to:
  /// **'Could not update this chat. Please try again.'**
  String get aiChatActionFailed;

  /// No description provided for @aiChatManualActions.
  ///
  /// In en, this message translates to:
  /// **'Manual tools'**
  String get aiChatManualActions;

  /// No description provided for @aiChatAddToChat.
  ///
  /// In en, this message translates to:
  /// **'Add to chat'**
  String get aiChatAddToChat;

  /// No description provided for @aiChatAttachBarcode.
  ///
  /// In en, this message translates to:
  /// **'Barcode scan'**
  String get aiChatAttachBarcode;

  /// No description provided for @aiChatAttachImage.
  ///
  /// In en, this message translates to:
  /// **'Image search'**
  String get aiChatAttachImage;

  /// No description provided for @aiChatEmptyNameFallback.
  ///
  /// In en, this message translates to:
  /// **'Friend'**
  String get aiChatEmptyNameFallback;

  /// No description provided for @aiChatEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'{name}, what are we buying today?'**
  String aiChatEmptyTitle(String name);

  /// No description provided for @aiChatEmptySubtitle.
  ///
  /// In en, this message translates to:
  /// **'I\'m ready.'**
  String get aiChatEmptySubtitle;

  /// No description provided for @aiChatErrorReply.
  ///
  /// In en, this message translates to:
  /// **'Temporary AI issue. Please retry, or share your budget, country, and top priorities so I can guide you safely.'**
  String get aiChatErrorReply;

  /// No description provided for @aiChatInputHint.
  ///
  /// In en, this message translates to:
  /// **'Write to Dealio...'**
  String get aiChatInputHint;

  /// No description provided for @aiChatThinkingAnalyzing.
  ///
  /// In en, this message translates to:
  /// **'Analyzing your request'**
  String get aiChatThinkingAnalyzing;

  /// No description provided for @aiChatThinkingSearching.
  ///
  /// In en, this message translates to:
  /// **'Searching trusted stores'**
  String get aiChatThinkingSearching;

  /// No description provided for @aiChatThinkingPricing.
  ///
  /// In en, this message translates to:
  /// **'Checking price signals'**
  String get aiChatThinkingPricing;

  /// No description provided for @aiChatThinkingRanking.
  ///
  /// In en, this message translates to:
  /// **'Ranking best options'**
  String get aiChatThinkingRanking;

  /// No description provided for @aiChatEmptyHintPrefix.
  ///
  /// In en, this message translates to:
  /// **'Try'**
  String get aiChatEmptyHintPrefix;

  /// No description provided for @aiChatEmptyHintCamera.
  ///
  /// In en, this message translates to:
  /// **'Find a phone with a strong camera under \$900'**
  String get aiChatEmptyHintCamera;

  /// No description provided for @aiChatEmptyHintBudget.
  ///
  /// In en, this message translates to:
  /// **'Compare trusted stores for my budget'**
  String get aiChatEmptyHintBudget;

  /// No description provided for @aiChatEmptyHintAlert.
  ///
  /// In en, this message translates to:
  /// **'Tell me when this product drops in price'**
  String get aiChatEmptyHintAlert;

  /// No description provided for @aiAgentActionNeeds.
  ///
  /// In en, this message translates to:
  /// **'Ask needs'**
  String get aiAgentActionNeeds;

  /// No description provided for @aiAgentActionResults.
  ///
  /// In en, this message translates to:
  /// **'Best results'**
  String get aiAgentActionResults;

  /// No description provided for @aiAgentActionAlert.
  ///
  /// In en, this message translates to:
  /// **'Price alert'**
  String get aiAgentActionAlert;

  /// No description provided for @aiAgentActionAdvice.
  ///
  /// In en, this message translates to:
  /// **'Advice'**
  String get aiAgentActionAdvice;

  /// No description provided for @aiAgentActionCompare.
  ///
  /// In en, this message translates to:
  /// **'Compare stores'**
  String get aiAgentActionCompare;

  /// No description provided for @aiAgentFeedbackHelpful.
  ///
  /// In en, this message translates to:
  /// **'Helpful'**
  String get aiAgentFeedbackHelpful;

  /// No description provided for @aiAgentFeedbackImprove.
  ///
  /// In en, this message translates to:
  /// **'Improve'**
  String get aiAgentFeedbackImprove;

  /// No description provided for @aiAgentFeedbackSaved.
  ///
  /// In en, this message translates to:
  /// **'Feedback noted'**
  String get aiAgentFeedbackSaved;

  /// No description provided for @aiAgentFeedbackHelpfulThanks.
  ///
  /// In en, this message translates to:
  /// **'Thanks — signal noted.'**
  String get aiAgentFeedbackHelpfulThanks;

  /// No description provided for @aiAgentFeedbackImproveThanks.
  ///
  /// In en, this message translates to:
  /// **'Got it — I’ll tune the next answer.'**
  String get aiAgentFeedbackImproveThanks;

  /// No description provided for @aiAgentPromptNeeds.
  ///
  /// In en, this message translates to:
  /// **'Ask me 3 short questions to understand my needs, budget, country, and priorities before recommending products.'**
  String get aiAgentPromptNeeds;

  /// No description provided for @aiAgentPromptResults.
  ///
  /// In en, this message translates to:
  /// **'Show the best product options as a concise ranked list with price, trust, pros, cons, and the safest next step.'**
  String get aiAgentPromptResults;

  /// No description provided for @aiAgentPromptAdvice.
  ///
  /// In en, this message translates to:
  /// **'Give me a short buying recommendation: what to choose, what to avoid, and why.'**
  String get aiAgentPromptAdvice;

  /// No description provided for @aiAgentPromptCompareStores.
  ///
  /// In en, this message translates to:
  /// **'Compare trusted stores for this product by price, delivery, return policy, authenticity, and risk.'**
  String get aiAgentPromptCompareStores;

  /// No description provided for @aiStructuredDecision.
  ///
  /// In en, this message translates to:
  /// **'DEALIO DECISION'**
  String get aiStructuredDecision;

  /// No description provided for @aiStructuredBestMatches.
  ///
  /// In en, this message translates to:
  /// **'BEST MATCHES'**
  String get aiStructuredBestMatches;

  /// No description provided for @aiStructuredQuestions.
  ///
  /// In en, this message translates to:
  /// **'QUESTIONS'**
  String get aiStructuredQuestions;

  /// No description provided for @aiStructuredPriceWatch.
  ///
  /// In en, this message translates to:
  /// **'PRICE WATCH'**
  String get aiStructuredPriceWatch;

  /// No description provided for @aiStructuredPriceWatchSubtitle.
  ///
  /// In en, this message translates to:
  /// **'I can watch this price and notify you when it becomes safer to buy.'**
  String get aiStructuredPriceWatchSubtitle;

  /// No description provided for @aiStructuredStartAlert.
  ///
  /// In en, this message translates to:
  /// **'Track'**
  String get aiStructuredStartAlert;

  /// No description provided for @aiAgentAlertTitle.
  ///
  /// In en, this message translates to:
  /// **'Watch this price?'**
  String get aiAgentAlertTitle;

  /// No description provided for @aiAgentAlertSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Dealio will check fresh prices and notify you when the target is reached.'**
  String get aiAgentAlertSubtitle;

  /// No description provided for @aiAgentAlertLoading.
  ///
  /// In en, this message translates to:
  /// **'Checking the latest price...'**
  String get aiAgentAlertLoading;

  /// No description provided for @aiAgentAlertQuoteUnavailable.
  ///
  /// In en, this message translates to:
  /// **'I could not read a reliable price yet. Paste a product link or use advanced setup.'**
  String get aiAgentAlertQuoteUnavailable;

  /// No description provided for @aiAgentAlertPasteLink.
  ///
  /// In en, this message translates to:
  /// **'Paste a product link so Dealio can track it.'**
  String get aiAgentAlertPasteLink;

  /// No description provided for @aiAgentAlertLinkHint.
  ///
  /// In en, this message translates to:
  /// **'https://store.com/product...'**
  String get aiAgentAlertLinkHint;

  /// No description provided for @aiAgentAlertCheckLink.
  ///
  /// In en, this message translates to:
  /// **'Check link'**
  String get aiAgentAlertCheckLink;

  /// No description provided for @aiAgentAlertCreate.
  ///
  /// In en, this message translates to:
  /// **'Create alert'**
  String get aiAgentAlertCreate;

  /// No description provided for @aiAgentAlertAdvanced.
  ///
  /// In en, this message translates to:
  /// **'Advanced setup'**
  String get aiAgentAlertAdvanced;

  /// No description provided for @aiAgentAlertSelectedProduct.
  ///
  /// In en, this message translates to:
  /// **'Selected product'**
  String get aiAgentAlertSelectedProduct;

  /// No description provided for @aiAgentAlertCurrent.
  ///
  /// In en, this message translates to:
  /// **'Now'**
  String get aiAgentAlertCurrent;

  /// No description provided for @aiAgentAlertTarget.
  ///
  /// In en, this message translates to:
  /// **'Target'**
  String get aiAgentAlertTarget;

  /// No description provided for @aiAgentAlertAnyStore.
  ///
  /// In en, this message translates to:
  /// **'Any trusted store'**
  String get aiAgentAlertAnyStore;

  /// No description provided for @aiAgentAlertStoreScope.
  ///
  /// In en, this message translates to:
  /// **'Tracking scope: {store}'**
  String aiAgentAlertStoreScope(String store);

  /// No description provided for @aiAgentAlertPriceUnknown.
  ///
  /// In en, this message translates to:
  /// **'Unknown'**
  String get aiAgentAlertPriceUnknown;

  /// No description provided for @aiAgentAlertNeedProduct.
  ///
  /// In en, this message translates to:
  /// **'I need a product or store link to create this alert.'**
  String get aiAgentAlertNeedProduct;

  /// No description provided for @aiAgentAlertCreatedMessage.
  ///
  /// In en, this message translates to:
  /// **'Price watch is live. I’ll notify you when the target is reached.'**
  String get aiAgentAlertCreatedMessage;

  /// No description provided for @aiAgentSearchResults.
  ///
  /// In en, this message translates to:
  /// **'I found {count} strong result(s) for “{query}”.'**
  String aiAgentSearchResults(String query, int count);

  /// No description provided for @aiAgentSearchNoResults.
  ///
  /// In en, this message translates to:
  /// **'I could not find strong product matches for “{query}” yet. Try adding budget, country, or store preference.'**
  String aiAgentSearchNoResults(String query);

  /// No description provided for @aiAgentSearchFailed.
  ///
  /// In en, this message translates to:
  /// **'Agent search is temporarily unavailable. I can still help refine the query.'**
  String get aiAgentSearchFailed;

  /// No description provided for @aiStructuredMatchScore.
  ///
  /// In en, this message translates to:
  /// **'{score}% match'**
  String aiStructuredMatchScore(int score);

  /// No description provided for @aiChatUserLabel.
  ///
  /// In en, this message translates to:
  /// **'You'**
  String get aiChatUserLabel;

  /// No description provided for @aiChatAssistantLabel.
  ///
  /// In en, this message translates to:
  /// **'Dealio AI'**
  String get aiChatAssistantLabel;

  /// No description provided for @searchHistoryEmpty.
  ///
  /// In en, this message translates to:
  /// **'Recent searches will appear here'**
  String get searchHistoryEmpty;

  /// No description provided for @searchHeaderTitle.
  ///
  /// In en, this message translates to:
  /// **'Dealio Search'**
  String get searchHeaderTitle;

  /// No description provided for @searchQuotaCompact.
  ///
  /// In en, this message translates to:
  /// **'{plan} • {remaining} left'**
  String searchQuotaCompact(String plan, int remaining);

  /// No description provided for @searchQuotaUnlimitedCompact.
  ///
  /// In en, this message translates to:
  /// **'{plan} • unlimited'**
  String searchQuotaUnlimitedCompact(String plan);

  /// No description provided for @searchInputLabel.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get searchInputLabel;

  /// No description provided for @searchButtonLabel.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get searchButtonLabel;

  /// No description provided for @searchAiNeedsTitle.
  ///
  /// In en, this message translates to:
  /// **'Dealio AI'**
  String get searchAiNeedsTitle;

  /// No description provided for @searchAiNeedsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Write your needs to Dealio.'**
  String get searchAiNeedsSubtitle;

  /// No description provided for @searchAiNeedsHint.
  ///
  /// In en, this message translates to:
  /// **'Example: strong battery, good camera, lightweight, under \$900...'**
  String get searchAiNeedsHint;

  /// No description provided for @searchNeedChipCamera.
  ///
  /// In en, this message translates to:
  /// **'camera'**
  String get searchNeedChipCamera;

  /// No description provided for @searchNeedChipBattery.
  ///
  /// In en, this message translates to:
  /// **'battery'**
  String get searchNeedChipBattery;

  /// No description provided for @searchNeedChipBudget.
  ///
  /// In en, this message translates to:
  /// **'under \$900'**
  String get searchNeedChipBudget;

  /// No description provided for @searchNeedChipDurable.
  ///
  /// In en, this message translates to:
  /// **'durable'**
  String get searchNeedChipDurable;

  /// No description provided for @searchRecentTitle.
  ///
  /// In en, this message translates to:
  /// **'Recent searches'**
  String get searchRecentTitle;

  /// No description provided for @searchFiltersTitle.
  ///
  /// In en, this message translates to:
  /// **'Filters'**
  String get searchFiltersTitle;

  /// No description provided for @searchFiltersSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Country, stores, and budget'**
  String get searchFiltersSubtitle;

  /// No description provided for @searchFiltersButton.
  ///
  /// In en, this message translates to:
  /// **'Filters'**
  String get searchFiltersButton;

  /// No description provided for @searchFiltersApply.
  ///
  /// In en, this message translates to:
  /// **'Apply filters'**
  String get searchFiltersApply;

  /// No description provided for @searchFiltersClearStores.
  ///
  /// In en, this message translates to:
  /// **'Clear stores'**
  String get searchFiltersClearStores;

  /// No description provided for @searchBudgetLabel.
  ///
  /// In en, this message translates to:
  /// **'Budget'**
  String get searchBudgetLabel;

  /// No description provided for @searchBudgetActive.
  ///
  /// In en, this message translates to:
  /// **'Budget set'**
  String get searchBudgetActive;

  /// No description provided for @searchBudgetHint.
  ///
  /// In en, this message translates to:
  /// **'Optional max price'**
  String get searchBudgetHint;

  /// No description provided for @searchBudgetInvalid.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid budget'**
  String get searchBudgetInvalid;

  /// No description provided for @searchCountryLabel.
  ///
  /// In en, this message translates to:
  /// **'Country'**
  String get searchCountryLabel;

  /// No description provided for @searchStoresLabel.
  ///
  /// In en, this message translates to:
  /// **'Choose stores only when needed.'**
  String get searchStoresLabel;

  /// No description provided for @searchAdvancedTitle.
  ///
  /// In en, this message translates to:
  /// **'Advanced'**
  String get searchAdvancedTitle;

  /// No description provided for @searchGlobalScope.
  ///
  /// In en, this message translates to:
  /// **'Global stores'**
  String get searchGlobalScope;

  /// No description provided for @searchSelectedScope.
  ///
  /// In en, this message translates to:
  /// **'{count} selected stores'**
  String searchSelectedScope(int count);

  /// No description provided for @searchHistoryStores.
  ///
  /// In en, this message translates to:
  /// **'{count} stores'**
  String searchHistoryStores(int count);

  /// No description provided for @searchHistoryContext.
  ///
  /// In en, this message translates to:
  /// **'context'**
  String get searchHistoryContext;

  /// No description provided for @searchCountryFallback.
  ///
  /// In en, this message translates to:
  /// **'Country'**
  String get searchCountryFallback;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'es', 'ru', 'uz', 'zh'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'ru':
      return AppLocalizationsRu();
    case 'uz':
      return AppLocalizationsUz();
    case 'zh':
      return AppLocalizationsZh();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
