// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Uzbek (`uz`).
class AppLocalizationsUz extends AppLocalizations {
  AppLocalizationsUz([String locale = 'uz']) : super(locale);

  @override
  String get navHome => 'Agent';

  @override
  String get navSearch => 'Qidiruv';

  @override
  String get navProfile => 'Profil';

  @override
  String get aboutTitle => 'Dealio haqida';

  @override
  String get aboutSubtitle => 'Aqlliroq xarid qilish uchun yaratilgan';

  @override
  String get languageTitle => 'Ilova tili';

  @override
  String get languageSubtitle => 'Qidiruv va AI natijalari shu tilda chiqadi';

  @override
  String get langEnglish => 'Ingliz';

  @override
  String get langRussian => 'Rus';

  @override
  String get langSpanish => 'Ispan';

  @override
  String get langUzbek => 'O\'zbek';

  @override
  String get langChinese => 'Xitoy';

  @override
  String searchPlanUnlimited(String plan) {
    return '$plan rejim - cheksiz qidiruv';
  }

  @override
  String searchPlanRemaining(String plan, int remaining) {
    return '$plan rejim - $remaining ta qidiruv qoldi';
  }

  @override
  String get searchValidationQueryRequired => 'Mahsulot kiriting';

  @override
  String get searchQueryHint => 'masalan, iPhone 13 128GB';

  @override
  String get commonRetry => 'Qayta urinish';

  @override
  String get searchUseUS => 'US dan foydalanish';

  @override
  String get searchFreeModeHint =>
      'FREE rejim: global do\'konlar davlatga qarab avtomatik yuklanadi.';

  @override
  String get searchManualStoreHint =>
      'Global do\'kon linki/domeni (amazon.com)';

  @override
  String get commonAdd => 'Qo\'shish';

  @override
  String get searchStoreSearchHint => 'Do\'kon qidirish...';

  @override
  String get searchStoresEmpty =>
      'Tanlangan davlat do\'konlari shu yerda chiqadi.';

  @override
  String get searchStoresLoadFailed =>
      'Do\'konlarni yuklab bo\'lmadi. Qayta urinib ko\'ring.';

  @override
  String get searchErrorCountryRequired =>
      'Davlat majburiy. Avval davlatni tanlang.';

  @override
  String get searchPlanLimitTitle => 'Reja limiti tugadi';

  @override
  String get searchPlanLimitMessage =>
      'Rejangiz limiti tugagan. Davom etish uchun yangilang.';

  @override
  String get searchErrorEnterStoreDomain =>
      'Do\'kon domeni yoki URL kiriting. Masalan: amazon.com';

  @override
  String get searchErrorStoreAlreadySelected =>
      'Bu do\'kon allaqachon tanlangan.';

  @override
  String searchErrorStoreLimit(int max) {
    return 'Maksimal $max ta do\'kon tanlash mumkin.';
  }

  @override
  String get commonEdit => 'Tahrirlash';

  @override
  String get resultsLoadingTitle => 'Global do\'konlar skan qilinmoqda...';

  @override
  String get alertsCheckNow => 'Hozir tekshirish';

  @override
  String get alertSheetAllStores => 'Barcha do\'konlar';

  @override
  String get alertSheetUserConsent => 'Bir-tegish checkout uchun roziman';

  @override
  String get alertsTargetNA => 'Maqsad: N/A';

  @override
  String get alertSheetStatHigh => 'Yuqori';

  @override
  String get settingsLogoutSubtitle => 'Qurilmadan xavfsiz chiqish';

  @override
  String get alertSheetTitle => 'Narx alertini yaratish';

  @override
  String get favoritesTitle => 'Sevimlilar';

  @override
  String get resultsEmptyDescription =>
      'Kalit so\'zlar, davlat yoki do\'kon sozlamalarini o\'zgartirib ko\'ring.';

  @override
  String get planPlus => 'Plus';

  @override
  String get resultsLoadingSubtitle =>
      'Takliflar va AI moslik realtime yig\'ilmoqda.';

  @override
  String get resultsStage2ReadySubtitle =>
      'AI profili yaratildi, do\'kon ishonchliligi tekshirilmoqda.';

  @override
  String alertsTriggers(int count) {
    return 'Triggerlar: $count';
  }

  @override
  String get alertsDealButton => 'Taklifni ochish';

  @override
  String alertSheetCurrentTarget(String target, String observed) {
    return 'Joriy: $observed  Maqsad: $target';
  }

  @override
  String settingsSearchesLeft(int remaining, int limit) {
    return '$remaining/$limit qidiruv qoldi';
  }

  @override
  String get planFree => 'Free';

  @override
  String get commonLogout => 'Chiqish';

  @override
  String get alertEventsEmpty => 'Hali alert voqealari yo\'q.';

  @override
  String get commonSettings => 'Sozlamalar';

  @override
  String alertEventsError(String error) {
    return 'Voqealarni yuklab bo\'lmadi: $error';
  }

  @override
  String get resultsStage1ReadySubtitle =>
      'Bozor skani tugadi, AI profili tayyorlanmoqda.';

  @override
  String get alertSheetRefreshQuote => 'Quote yangilash';

  @override
  String get alertsEmptySubtitle =>
      'Narx tushishini kuzatish uchun qidiruv natijasidan birinchi alertni yarating.';

  @override
  String get alertSheetArmAutoBuy => 'Auto-buy ni yoqish';

  @override
  String get resultsUpgradePlanTitle => 'Rejani yangilang';

  @override
  String get alertSheetKvontTitle => 'KVONT Auto-buy boshqaruvi';

  @override
  String get commonCancel => 'Bekor qilish';

  @override
  String get commonDelete => 'O\'chirish';

  @override
  String get resultsUnexpectedError =>
      'Qidiruvda kutilmagan xatolik yuz berdi.';

  @override
  String get resultsEmptyTitle => 'Mos mahsulot topilmadi';

  @override
  String get alertSheetWaitingPrice => 'Realtime narx kutilmoqda...';

  @override
  String get settingsThemeTitle => 'Mavzu';

  @override
  String get favoritesEmptyTitle => 'Sevimlilar hozircha yo\'q';

  @override
  String get commonUpgrade => 'Yangilash';

  @override
  String get favoritesAnalyze => 'Tahlil qilish';

  @override
  String get resultsStageFindingTitle => 'Eng yaxshi takliflar topilmoqda';

  @override
  String get alertSheetTriggerSetup => 'Trigger sozlamalari';

  @override
  String get resultsStageFindingSubtitle =>
      'Bozor bo\'yicha dastlabki signallar yig\'ilmoqda.';

  @override
  String get alertSheetSaveButton => 'Alertni saqlash';

  @override
  String get alertSheetRealtimeMonitoring => 'Realtime monitoring';

  @override
  String get resultsStage2ReadyTitle => '2-bosqich tayyor';

  @override
  String get settingsSubscriptionUnavailable =>
      'Obuna ma\'lumotini olib bo\'lmadi';

  @override
  String get resultsUpgradeNow => 'Hozir yangilash';

  @override
  String get alertSheetKvontSubtitle =>
      'Bu sozlamalar faqat bildirishnoma harakatlarini tayyorlaydi; tolov baribir sizning tasdiqingizni talab qiladi.';

  @override
  String get resultsAdjustParameters => 'Qidiruv parametrlarini sozlash';

  @override
  String get commonClear => 'Tozalash';

  @override
  String settingsPlanLabel(String plan) {
    return '$plan rejim';
  }

  @override
  String alertsTargetValue(String price) {
    return 'Maqsad: \$$price';
  }

  @override
  String get alertSheetStoreTargeting => 'Do\'kon tanlash';

  @override
  String get resultsUpgradePlanMessage =>
      'Ko\'proq qidiruv va chuqurroq AI tahlil uchun yuqori rejimga o\'ting.';

  @override
  String get alertSheetCooldownLabel => 'Cooldown (daqiqalarda)';

  @override
  String get settingsDarkEnabled => 'Tungi rejim yoqilgan';

  @override
  String get alertsKvontPaywallMessage =>
      'Realtime alertlar, narx trend tahlili va checkout linklarni oching.';

  @override
  String get alertsKvontUpgradeMessage =>
      'Realtime monitoring, trend grafiklar va auto-buy tayyorlash uchun KVONTga o\'ting.';

  @override
  String resultsProductsOptimized(int count) {
    return '$count ta mahsulot optimallashtirildi';
  }

  @override
  String get settingsNotificationsSubtitle =>
      'Narx alertlari va ilova yangiliklari';

  @override
  String get planKvont => 'Kvont';

  @override
  String get planPro => 'Pro';

  @override
  String get resultsNeuralGlitch => 'Qidiruv muammosi';

  @override
  String get alertSheetTargetInvalid =>
      'Maqsad narx joriy narxdan past bo\'lishi kerak.';

  @override
  String get alertsKvontPaywallTitle => 'KVONT Super Alertlar';

  @override
  String get alertSheetStatTarget => 'Maqsad';

  @override
  String get alertSheetCheckoutPrepared => 'Checkout havola tayyor';

  @override
  String get alertSheetStatLow => 'Past';

  @override
  String get settingsPrivacySubtitle => 'Maxfiylik sozlamalarini boshqarish';

  @override
  String get resultsStage3ReadyTitle => '3-bosqich tayyor';

  @override
  String alertsLastTrigger(String time) {
    return 'Oxirgi trigger: $time';
  }

  @override
  String get resultsSearchQuotaTitle => 'Qidiruv kvotasi';

  @override
  String get resultsSearchLimitReached => 'Qidiruv limiti tugadi';

  @override
  String get alertSheetRealtimeUnavailable =>
      'Realtime narx mavjud emas. Quote yangilab qayta urinib ko\'ring.';

  @override
  String get alertsDeleteTitle => 'Alert o\'chirilsinmi?';

  @override
  String get alertsEmptyTitle => 'Faol alertlar yo\'q';

  @override
  String alertsCheckNowResult(String checked, String errors, String triggered) {
    return 'Tekshirildi: $checked  Trigger: $triggered  Xatolar: $errors';
  }

  @override
  String get alertEventsTitle => 'Alert voqealari';

  @override
  String get resultsStage3ReadySubtitle =>
      'Yakuniy reyting eng yaxshi alternativalar bilan tayyor.';

  @override
  String get alertSheetTrendTitle => 'Narx trendi (so\'nggi)';

  @override
  String get commonManage => 'Boshqarish';

  @override
  String get favoritesStartShopping => 'Qidiruvni boshlash';

  @override
  String get settingsNotificationsTitle => 'Bildirishnomalar';

  @override
  String get settingsLightEnabled => 'Yorug\' rejim yoqilgan';

  @override
  String get alertSheetCooldownHelper =>
      'Kamida 5 daqiqa, ko\'pi bilan 1440 daqiqa.';

  @override
  String get alertsKvontSubtitle =>
      'Realtime worker alertlaringizni do\'kon narxlari bilan sinxron tutadi.';

  @override
  String get alertsCreateTooltip => 'Alert yaratish';

  @override
  String get settingsPrivacyTitle => 'Maxfiylik va xavfsizlik';

  @override
  String alertEventsTriggeredAt(String targetPrice, String triggerPrice) {
    return 'Ishga tushdi: \$$triggerPrice (maqsad \$$targetPrice)';
  }

  @override
  String get alertSheetRealtimeMonitoringSubtitle =>
      'Tez trigger uchun narxlar uzluksiz tekshiriladi.';

  @override
  String get resultsNeuralSearch => 'Neural Search';

  @override
  String get alertsKvontActive => 'KVONT realtime monitoring faol';

  @override
  String get alertSheetRealtimePriceLabel => 'Realtime narx';

  @override
  String get alertsTitle => 'Alertlar';

  @override
  String get alertSheetDropAmount => 'Pasayish \$';

  @override
  String get alertEventsViewDeal => 'Taklifni ko\'rish';

  @override
  String get alertSheetSaved => 'Alert muvaffaqiyatli yaratildi.';

  @override
  String get resultsStage1ReadyTitle => '1-bosqich tayyor';

  @override
  String get alertsDeleteMessage =>
      'Bu amal alert va uning realtime monitoringini o\'chiradi.';

  @override
  String get alertSheetDropPercent => 'Pasayish %';

  @override
  String get favoritesSubtitle =>
      'Saqlangan mahsulotlar va tez qayta tekshiruv ro\'yxati.';

  @override
  String get resultsTryAgain => 'Qayta urinish';

  @override
  String get favoritesEmptySubtitle =>
      'Yaxshi narx va xavfsiz alternativalarni kuzatish uchun mahsulot saqlang.';

  @override
  String get alertsNever => 'Hech qachon';

  @override
  String get alertsHistoryTooltip => 'Alert tarixi';

  @override
  String get onboardingSlide1Desc =>
      'Eng yaxshi narxni topish uchun global do\'konlar takliflarini tez solishtiring.';

  @override
  String get authEmailLabel => 'Email';

  @override
  String get onboardingSlide2Desc =>
      'AI mahsulot aslligi va sotuvchi ishonchliligini xariddan oldin tekshiradi.';

  @override
  String get authEmailHint => 'you@example.com';

  @override
  String get loginCreateAccount => 'Yangi akkaunt yaratish';

  @override
  String authFullNameMinChars(int min) {
    return 'Kamida $min ta belgi';
  }

  @override
  String get profilePaymentMethodsSubtitle => 'Karta va hamyonlar';

  @override
  String get loginBackOnboarding => 'Onboardingga qaytish';

  @override
  String get onboardingNext => 'Keyingi';

  @override
  String get profileNotifications => 'Bildirishnomalar';

  @override
  String get profileSecurity => 'Xavfsizlik';

  @override
  String get loginButton => 'Kirish';

  @override
  String get authPasswordLabel => 'Parol';

  @override
  String get splashTagline => 'Ishonchli takliflar';

  @override
  String get onboardingSlide3Desc =>
      'Haqiqiy xaridor fikrlarini smart sentiment tahlili bilan tushuning.';

  @override
  String get onboardingGetStarted => 'Boshlash';

  @override
  String get authFullNameLabel => 'To\'liq ism';

  @override
  String get registerCreateAccount => 'Akkaunt yaratish';

  @override
  String get authPasswordHint => 'Parolingizni kiriting';

  @override
  String get profileSettingsPreferences => 'Sozlamalar va afzalliklar';

  @override
  String get onboardingSlide4Title => 'Aqlli alertlar';

  @override
  String get registerSubtitle =>
      'Dealio ga qo\'shiling va aqlli shopping imkoniyatlarini oching';

  @override
  String get onboardingBack => 'Orqaga';

  @override
  String get loginWelcomeBack => 'Xush kelibsiz';

  @override
  String get onboardingSkip => 'O\'tkazib yuborish';

  @override
  String get loginForgotPassword => 'Parolni unutdingizmi?';

  @override
  String get onboardingSlide1Title => 'Global narx taqqoslash';

  @override
  String get registerButton => 'Ro\'yxatdan o\'tish';

  @override
  String authPasswordMinChars(int min) {
    return 'Kamida $min ta belgi';
  }

  @override
  String get loginSignInContinue => 'Davom etish uchun tizimga kiring';

  @override
  String get profileName => 'Alex Robinson';

  @override
  String profilePointsProgress(String total, String current) {
    return '$current / $total ball';
  }

  @override
  String get onboardingSlide4Desc =>
      'Maqsad narxga yetganda darhol bildirishnoma oling va tez harakat qiling.';

  @override
  String get profileLogout => 'Chiqish';

  @override
  String get profileGoldStatus => 'OLTIN STATUS';

  @override
  String get registerSuccessTitle => 'Ro\'yxatdan o\'tish muvaffaqiyatli';

  @override
  String get profilePaymentMethods => 'To\'lov usullari';

  @override
  String get profileNotificationsSubtitle =>
      'Deal alertlari va ilova yangiliklari';

  @override
  String get profileCashbackBalance => 'Cashback balansi';

  @override
  String get onboardingSlide2Title => 'Asllik tekshiruvi';

  @override
  String profileNextReward(String amount) {
    return 'Keyingi mukofot: $amount';
  }

  @override
  String get authEmailInvalid => 'To\'g\'ri email kiriting';

  @override
  String get authEmailRequired => 'Email majburiy';

  @override
  String get authPasswordRequired => 'Parol majburiy';

  @override
  String get authFullNameRequired => 'To\'liq ism majburiy';

  @override
  String get registerAlreadyHaveAccount => 'Akkauntingiz bormi? Kirish';

  @override
  String get onboardingSlide3Title => 'Sharhlar va insightlar';

  @override
  String get profileSecuritySubtitle => 'Biometriya va parollar';

  @override
  String get navFavorites => 'Sevimlilar';

  @override
  String get favoritesLoadFailed => 'Saqlanganlar sinxronlanmadi';

  @override
  String get favoritesLoadSubtitle =>
      'Dealio hozir sevimlilar ro\'yxatini yangilay olmadi. Internetni tekshirib, yana sinab ko\'ring.';

  @override
  String get favoritesLoadAction => 'Ro\'yxatni yangilash';

  @override
  String get favoritesProductFallback => 'Mahsulot';

  @override
  String get favoritesNoNotes => 'Saqlangan mahsulot';

  @override
  String get favoritesSaveTooltip => 'Sevimlilarga saqlash';

  @override
  String get favoritesRemoveTooltip => 'Sevimlilardan olib tashlash';

  @override
  String get favoritesSaved => 'Sevimlilarga saqlandi.';

  @override
  String get favoritesRemoved => 'Sevimlilardan olib tashlandi.';

  @override
  String get favoritesActionFailed =>
      'Saqlanganlar ro\'yxatini yangilab bo\'lmadi. Qayta urinib ko\'ring.';

  @override
  String get notificationsTitle => 'Bildirishnomalar';

  @override
  String get notificationsClearTitle => 'Hammasi tozalansinmi?';

  @override
  String get notificationsClearMessage =>
      'Barcha bildirishnomalarni yopishni xohlaysizmi?';

  @override
  String get notificationsUnavailableTitle => 'Bildirishnomalar mavjud emas';

  @override
  String get notificationsUnavailableSubtitle =>
      'Alertlarni hozir yuklab bo\'lmadi. Keyinroq qayta urinib ko\'ring.';

  @override
  String notificationsAtStore(String store) {
    return ' - $store';
  }

  @override
  String notificationsAlertMatched(String price, String store) {
    return 'Kuzatilayotgan mahsulot alert shartiga mos keldi$price$store.';
  }

  @override
  String get notificationsBackInStock => 'Qayta omborda';

  @override
  String get notificationsDealFound => 'Taklif topildi';

  @override
  String get notificationsPriceAlert => 'Narx alerti';

  @override
  String get notificationsJustNow => 'Hozirgina';

  @override
  String notificationsMinutesAgo(int count) {
    return '$count daqiqa oldin';
  }

  @override
  String notificationsHoursAgo(int count) {
    return '$count soat oldin';
  }

  @override
  String notificationsDaysAgo(int count) {
    return '$count kun oldin';
  }

  @override
  String get notificationsTabAll => 'Hammasi';

  @override
  String get notificationsTabPriceAlerts => 'Narx alertlari';

  @override
  String get notificationsTabAiInsights => 'AI maslahatlar';

  @override
  String get notificationsTabSustainability => 'Barqarorlik';

  @override
  String get notificationsTabStoreUpdates => 'Dokon yangiliklari';

  @override
  String get notificationsViewProduct => 'Mahsulotni ko\'rish';

  @override
  String get notificationsReanalyze => 'Qayta tahlil';

  @override
  String get notificationsEmptyTitle => 'Hozircha bildirishnoma yo\'q';

  @override
  String get notificationsEmptySubtitle =>
      'Real-time taklif yangiliklari uchun narx alertlarini yarating.';

  @override
  String get alertPickerTitle => 'Narx alerti yaratish';

  @override
  String get alertPickerSubtitle =>
      'Qanday boshlashni tanlang. Qidiruv solishtirish uchun, manual link esa aniq dokon sahifasi uchun qulay.';

  @override
  String get alertPickerSearchTitle => 'Mahsulot qidirish';

  @override
  String get alertPickerSearchSubtitle =>
      'Avval mahsulotni toping, dokonlarni solishtiring, keyin alert yarating.';

  @override
  String get alertPickerManualTitle => 'Manual dokon linki';

  @override
  String get alertPickerManualSubtitle =>
      'Ochiq product URL kiriting va aynan shu sahifani kuzating.';

  @override
  String get alertPickerPlanLimits =>
      'Plan limitlari amal qiladi: Free 3/oy, Plus 10/oy, Pro 100/oy, KVONT 1000/oy.';

  @override
  String get alertManualInvalidUrl =>
      'Toliq public http(s) product URL kiriting.';

  @override
  String get alertManualPriceUnavailable =>
      'Bu link uchun joriy narx mavjud emas.';

  @override
  String get alertManualLimitTitle => 'Narx alert limiti tugadi';

  @override
  String get alertManualLimitMessage =>
      'Oylik alert kvotangiz tugadi. Koproq alert va tezroq monitoring uchun planingizni yangilang.';

  @override
  String get alertManualCreated => 'Dokon linkidan narx alerti yaratildi.';

  @override
  String get alertManualTitle => 'Manual link alert';

  @override
  String get alertManualSubtitle =>
      'Product URL kiriting. Dealio narxni oqib, aynan shu dokon sahifasini kuzatadi.';

  @override
  String get alertManualStepLink => '1. Dokon product linki';

  @override
  String get alertManualAnalyzeLink => 'Linkni tahlil qilish';

  @override
  String get alertManualSecurityNote =>
      'Xavfsizlik uchun faqat public http(s) product sahifalari qabul qilinadi. Local/private network linklari backendda bloklanadi.';

  @override
  String get alertManualWaitingAnalysis => 'Tahlil kutilmoqda';

  @override
  String get alertManualAnalyzeForPrice =>
      'Joriy narxni aniqlash uchun linkni tahlil qiling.';

  @override
  String alertManualQuoteConfidence(String store, String confidence) {
    return '$store - ishonch $confidence';
  }

  @override
  String get alertManualStoreFallback => 'Dokon';

  @override
  String get alertManualStepSignal => '2. Narx signali';

  @override
  String get alertManualAnalyzeTargetHint =>
      'Targetni hisoblash uchun avval linkni tahlil qiling.';

  @override
  String get alertSheetStatNow => 'Hozir';

  @override
  String get alertSheetStoreNameOptional => 'Dokon nomi (ixtiyoriy)';

  @override
  String get alertSheetCustomStoreLink => 'Yoki dokon linkini kiriting';

  @override
  String get alertSheetCheckStore => 'Bu dokonni tekshirish';

  @override
  String get alertSheetCustomStoreInvalid =>
      'Dealio xavfsiz kuzatishi uchun toliq http(s) product URL kiriting.';

  @override
  String alertSheetCustomStoreScope(String domain) {
    return 'Custom dokon doirasi: $domain';
  }

  @override
  String get alertSheetAdvancedOptions => 'Qoshimcha sozlamalar';

  @override
  String get alertSheetAdvancedSubtitle =>
      'Cooldown va KVONT bir-tegish tayyorgarligi.';

  @override
  String get resultsTopPick => 'ENG MOS';

  @override
  String get resultsPriceSyncing => 'NARX SINXRONLANMOQDA';

  @override
  String get resultsBestLivePrice => 'ENG YAXSHI LIVE NARX';

  @override
  String get resultsCheckingStores => 'Dokonlar tekshirilmoqda';

  @override
  String get resultsReady => 'Tayyor';

  @override
  String get resultsLive => 'Live';

  @override
  String get resultsDealioTake => 'Dealio xulosasi';

  @override
  String get resultsPricePending => 'Narx kutilmoqda';

  @override
  String get resultsFinalAiDelayed =>
      'Yakuniy AI reyting kechikdi, lekin dokon natijalari tayyor.';

  @override
  String get resultsStoreValidationDelayed =>
      'Dokon tekshiruvi kechikdi, mavjud natijalar bilan davom etamiz.';

  @override
  String get resultsProductFallback => 'Mahsulot';

  @override
  String get resultsSmartMatch => 'Aqlli moslik';

  @override
  String get resultsLiveOffersTitle => 'Live dokon narxlari';

  @override
  String get resultsLiveOffersSubtitle =>
      'Bu qidiruvdan qaytgan real takliflar.';

  @override
  String get resultsBestBadge => 'ENG YAXSHI';

  @override
  String get resultsOfferAvailable => 'Mavjud';

  @override
  String get resultsOfferUnavailable => 'Mavjud emas';

  @override
  String get resultsFitLabel => 'MOS';

  @override
  String resultsFitScore(int score) {
    return '$score mos';
  }

  @override
  String get resultsCountryFallback => 'Global';

  @override
  String get resultsProviderFallback => 'Smart';

  @override
  String get resultsOpenProductTooltip => 'Mahsulot tafsilotlari';

  @override
  String get resultsOpenDealTooltip => 'Dokon taklifini ochish';

  @override
  String get resultsCreateAlertTooltip => 'Narx alerti yaratish';

  @override
  String get resultsMatchesSubtitle =>
      'Bu qidiruvdan qaytgan real mahsulotlar.';

  @override
  String get resultsNoLiveOffers =>
      'Tasdiqlangan takliflar kelganda live dokon narxlari shu yerda korinadi.';

  @override
  String get resultsStoreFallback => 'Dokon';

  @override
  String get aiChatTitle => 'Dealio';

  @override
  String get aiChatSubtitle => 'Faqat shopping uchun shaxsiy maslahatchi';

  @override
  String get aiChatNewChat => 'Yangi chat';

  @override
  String get aiChatHistory => 'Chatlar';

  @override
  String get aiChatRenameChat => 'Chat nomini o\'zgartirish';

  @override
  String get aiChatDeleteChat => 'Chatni o\'chirish';

  @override
  String get aiChatRenameTitle => 'Chat nomini o\'zgartirish';

  @override
  String get aiChatRenameHint => 'Chat nomi';

  @override
  String get aiChatRenameSave => 'Nomni saqlash';

  @override
  String get aiChatDeleteTitle => 'Chat o\'chirilsinmi?';

  @override
  String get aiChatDeleteBody =>
      'Bu chat tarixingizdan olib tashlanadi. Istalgan payt yangi chat boshlashingiz mumkin.';

  @override
  String get aiChatDeleteConfirm => 'Chatni o\'chirish';

  @override
  String get aiChatActionFailed =>
      'Bu chatni yangilab bo\'lmadi. Qayta urinib ko\'ring.';

  @override
  String get aiChatManualActions => 'Manual vositalar';

  @override
  String get aiChatAddToChat => 'Chatga qo‘shish';

  @override
  String get aiChatAttachBarcode => 'Barcode skan';

  @override
  String get aiChatAttachImage => 'Rasm orqali qidirish';

  @override
  String get aiChatEmptyNameFallback => 'Do‘stim';

  @override
  String aiChatEmptyTitle(String name) {
    return '$name, bugun nimalar sotib olamiz!';
  }

  @override
  String get aiChatEmptySubtitle => 'Men tayyorman.';

  @override
  String get aiChatErrorReply =>
      'AI vaqtincha javob bera olmadi. Qayta urinib koring yoki budjet, davlat va eng muhim talablarni yozing.';

  @override
  String get aiChatInputHint => 'Dealio\'ga yozing...';

  @override
  String get aiChatThinkingAnalyzing => 'So‘rovingiz tahlil qilinmoqda';

  @override
  String get aiChatThinkingSearching => 'Do‘konlar qidirilmoqda';

  @override
  String get aiChatThinkingPricing => 'Narx tekshirilmoqda';

  @override
  String get aiChatThinkingRanking => 'Variantlar saralanmoqda';

  @override
  String get aiChatEmptyHintPrefix => 'Masalan';

  @override
  String get aiChatEmptyHintCamera =>
      'Kuchli kamerali telefonni \$900 gacha top';

  @override
  String get aiChatEmptyHintBudget =>
      'Budjetimga mos ishonchli do‘konlarni solishtir';

  @override
  String get aiChatEmptyHintAlert => 'Bu mahsulot arzonlashsa menga xabar ber';

  @override
  String get aiAgentActionNeeds => 'Ehtiyojni so‘rash';

  @override
  String get aiAgentActionResults => 'Eng mos natijalar';

  @override
  String get aiAgentActionAlert => 'Narx alerti';

  @override
  String get aiAgentActionAdvice => 'Maslahat';

  @override
  String get aiAgentActionCompare => 'Do‘konlarni solishtirish';

  @override
  String get aiAgentFeedbackHelpful => 'Foydali';

  @override
  String get aiAgentFeedbackImprove => 'Yaxshila';

  @override
  String get aiAgentFeedbackSaved => 'Fikr qabul qilindi';

  @override
  String get aiAgentFeedbackHelpfulThanks => 'Rahmat — signal qabul qilindi.';

  @override
  String get aiAgentFeedbackImproveThanks =>
      'Tushunarli — keyingi javobni moslayman.';

  @override
  String get aiAgentPromptNeeds =>
      'Mahsulot tavsiya qilishdan oldin ehtiyojim, budjetim, davlatim va ustuvor talablarimni tushunish uchun menga 3 ta qisqa savol ber.';

  @override
  String get aiAgentPromptResults =>
      'Eng yaxshi mahsulot variantlarini narx, ishonchlilik, afzallik, kamchilik va eng xavfsiz keyingi qadam bilan qisqa reyting qilib ko‘rsat.';

  @override
  String get aiAgentPromptAdvice =>
      'Qisqa xarid maslahati ber: nimani tanlash kerak, nimadan saqlanish kerak va nima uchun.';

  @override
  String get aiAgentPromptCompareStores =>
      'Bu mahsulot uchun ishonchli do‘konlarni narx, yetkazib berish, qaytarish siyosati, haqiqiylik va risk bo‘yicha solishtir.';

  @override
  String get aiStructuredDecision => 'DEALIO QARORI';

  @override
  String get aiStructuredBestMatches => 'ENG MOS NATIJALAR';

  @override
  String get aiStructuredQuestions => 'SAVOLLAR';

  @override
  String get aiStructuredPriceWatch => 'NARX KUZATUVI';

  @override
  String get aiStructuredPriceWatchSubtitle =>
      'Bu narxni kuzatib, sotib olish xavfsizroq bo‘lganda xabar bera olaman.';

  @override
  String get aiStructuredStartAlert => 'Kuzatish';

  @override
  String get aiAgentAlertTitle => 'Bu narxni kuzataymi?';

  @override
  String get aiAgentAlertSubtitle =>
      'Dealio yangi narxlarni tekshiradi va maqsad narxga yetganda xabar beradi.';

  @override
  String get aiAgentAlertLoading => 'So‘nggi narx tekshirilmoqda...';

  @override
  String get aiAgentAlertQuoteUnavailable =>
      'Hozircha ishonchli narxni o‘qiy olmadim. Mahsulot linkini kiriting yoki advanced sozlamadan foydalaning.';

  @override
  String get aiAgentAlertPasteLink =>
      'Dealio kuzatishi uchun mahsulot linkini kiriting.';

  @override
  String get aiAgentAlertLinkHint => 'https://store.com/product...';

  @override
  String get aiAgentAlertCheckLink => 'Linkni tekshirish';

  @override
  String get aiAgentAlertCreate => 'Alert yaratish';

  @override
  String get aiAgentAlertAdvanced => 'Advanced sozlama';

  @override
  String get aiAgentAlertSelectedProduct => 'Tanlangan mahsulot';

  @override
  String get aiAgentAlertCurrent => 'Hozir';

  @override
  String get aiAgentAlertTarget => 'Maqsad';

  @override
  String get aiAgentAlertAnyStore => 'Ishonchli do‘konlar';

  @override
  String aiAgentAlertStoreScope(String store) {
    return 'Kuzatuv doirasi: $store';
  }

  @override
  String get aiAgentAlertPriceUnknown => 'Nomaʼlum';

  @override
  String get aiAgentAlertNeedProduct =>
      'Bu alertni yaratish uchun mahsulot yoki do‘kon linki kerak.';

  @override
  String get aiAgentAlertCreatedMessage =>
      'Narx kuzatuvi yoqildi. Maqsad narxga yetganda sizga xabar beraman.';

  @override
  String aiAgentSearchResults(String query, int count) {
    return '“$query” uchun $count ta kuchli natija topdim.';
  }

  @override
  String aiAgentSearchNoResults(String query) {
    return '“$query” uchun hali kuchli mahsulot mosliklarini topa olmadim. Budjet, davlat yoki do‘kon talabini qo‘shib yozing.';
  }

  @override
  String get aiAgentSearchFailed =>
      'Agent qidiruvi vaqtincha ishlamayapti. So‘rovni aniqlashtirishda baribir yordam bera olaman.';

  @override
  String aiStructuredMatchScore(int score) {
    return '$score% mos';
  }

  @override
  String get aiChatUserLabel => 'Siz';

  @override
  String get aiChatAssistantLabel => 'Dealio AI';

  @override
  String get searchHistoryEmpty => 'Oxirgi qidiruvlar shu yerda chiqadi';

  @override
  String get searchHeaderTitle => 'Dealio Search';

  @override
  String searchQuotaCompact(String plan, int remaining) {
    return '$plan • $remaining qoldi';
  }

  @override
  String searchQuotaUnlimitedCompact(String plan) {
    return '$plan • cheksiz';
  }

  @override
  String get searchInputLabel => 'Qidiruv';

  @override
  String get searchButtonLabel => 'Qidirish';

  @override
  String get searchAiNeedsTitle => 'Dealio AI';

  @override
  String get searchAiNeedsSubtitle => 'Dealio\'ga ehtiyojlaringizni yozing.';

  @override
  String get searchAiNeedsHint =>
      'Masalan: kuchli batareya, yaxshi kamera, yengil, \$900 gacha...';

  @override
  String get searchNeedChipCamera => 'kamera';

  @override
  String get searchNeedChipBattery => 'batareya';

  @override
  String get searchNeedChipBudget => '\$900 gacha';

  @override
  String get searchNeedChipDurable => 'chidamli';

  @override
  String get searchRecentTitle => 'Oxirgi qidiruvlar';

  @override
  String get searchFiltersTitle => 'Filterlar';

  @override
  String get searchFiltersSubtitle => 'Davlat, do\'konlar va budjet';

  @override
  String get searchFiltersButton => 'Filterlar';

  @override
  String get searchFiltersApply => 'Filterlarni qo\'llash';

  @override
  String get searchFiltersClearStores => 'Do\'konlarni tozalash';

  @override
  String get searchBudgetLabel => 'Budjet';

  @override
  String get searchBudgetActive => 'Budjet bor';

  @override
  String get searchBudgetHint => 'Ixtiyoriy maksimal narx';

  @override
  String get searchBudgetInvalid => 'To\'g\'ri budjet kiriting';

  @override
  String get searchCountryLabel => 'Davlat';

  @override
  String get searchStoresLabel => 'Faqat kerak bo\'lsa do\'kon tanlang.';

  @override
  String get searchAdvancedTitle => 'Qo\'shimcha';

  @override
  String get searchGlobalScope => 'Global do\'konlar';

  @override
  String searchSelectedScope(int count) {
    return '$count tanlangan do\'kon';
  }

  @override
  String searchHistoryStores(int count) {
    return '$count do\'kon';
  }

  @override
  String get searchHistoryContext => 'kontekst';

  @override
  String get searchCountryFallback => 'Davlat';
}
