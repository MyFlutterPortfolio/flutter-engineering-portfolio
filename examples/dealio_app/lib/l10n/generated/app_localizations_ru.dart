// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get navHome => 'Агент';

  @override
  String get navSearch => 'Поиск';

  @override
  String get navProfile => 'Профиль';

  @override
  String get aboutTitle => 'О Dealio';

  @override
  String get aboutSubtitle => 'Создано для умных покупок';

  @override
  String get languageTitle => 'Язык приложения';

  @override
  String get languageSubtitle => 'Поиск и AI-результаты будут на этом языке';

  @override
  String get langEnglish => 'Английский';

  @override
  String get langRussian => 'Русский';

  @override
  String get langSpanish => 'Испанский';

  @override
  String get langUzbek => 'Узбекский';

  @override
  String get langChinese => 'Китайский';

  @override
  String searchPlanUnlimited(String plan) {
    return 'Тариф $plan - безлимитный поиск';
  }

  @override
  String searchPlanRemaining(String plan, int remaining) {
    return 'Тариф $plan - осталось $remaining поисков';
  }

  @override
  String get searchValidationQueryRequired => 'Введите товар';

  @override
  String get searchQueryHint => 'например, iPhone 13 128GB';

  @override
  String get commonRetry => 'Повторить';

  @override
  String get searchUseUS => 'Использовать US';

  @override
  String get searchFreeModeHint =>
      'FREE режим: глобальные магазины загружаются автоматически по стране.';

  @override
  String get searchManualStoreHint => 'Ссылка/домен магазина (amazon.com)';

  @override
  String get commonAdd => 'Добавить';

  @override
  String get searchStoreSearchHint => 'Поиск магазинов...';

  @override
  String get searchStoresEmpty =>
      'Здесь появятся магазины для выбранной страны.';

  @override
  String get searchStoresLoadFailed =>
      'Не удалось загрузить магазины. Попробуйте снова.';

  @override
  String get searchErrorCountryRequired =>
      'Страна обязательна. Сначала выберите страну.';

  @override
  String get searchPlanLimitTitle => 'Лимит тарифа достигнут';

  @override
  String get searchPlanLimitMessage =>
      'Лимит вашего тарифа исчерпан. Обновите план.';

  @override
  String get searchErrorEnterStoreDomain =>
      'Введите домен или URL магазина. Например: amazon.com';

  @override
  String get searchErrorStoreAlreadySelected => 'Этот магазин уже выбран.';

  @override
  String searchErrorStoreLimit(int max) {
    return 'Можно выбрать не более $max магазинов.';
  }

  @override
  String get commonEdit => 'Изменить';

  @override
  String get resultsLoadingTitle => 'Сканирование глобальных магазинов...';

  @override
  String get alertsCheckNow => 'Проверить доступность';

  @override
  String get alertSheetAllStores => 'Все магазины';

  @override
  String get alertSheetUserConsent => 'I approve one-tap checkout';

  @override
  String get alertsTargetNA => 'Цель: Н/Д';

  @override
  String get alertSheetStatHigh => 'Высокое';

  @override
  String get settingsLogoutSubtitle =>
      'Безопасный выход из системы с этого устройства';

  @override
  String get alertSheetTitle => 'Создать «Ценовое уведомление»';

  @override
  String get favoritesTitle => 'Избранное';

  @override
  String get resultsEmptyDescription =>
      'Попробуйте уточнить ключевые слова, страну или магазины.';

  @override
  String get planPlus => 'Плюс';

  @override
  String get resultsLoadingSubtitle =>
      'Агрегирование предложений и сопоставление ИИ в режиме реального времени.';

  @override
  String get resultsStage2ReadySubtitle =>
      'Создан профиль ИИ, подтверждающий доверие магазина.';

  @override
  String alertsTriggers(int count) {
    return 'Триггеры: $count';
  }

  @override
  String get alertsDealButton => 'Открыть сделку';

  @override
  String alertSheetCurrentTarget(String target, String observed) {
    return 'Текущий: $observed  Цель: $target';
  }

  @override
  String settingsSearchesLeft(int remaining, int limit) {
    return '$remaining/$limit поиск слева';
  }

  @override
  String get planFree => 'Без оплаты';

  @override
  String get commonLogout => 'Выйти';

  @override
  String get alertEventsEmpty => 'Пока нет тревожных событий.';

  @override
  String get commonSettings => 'Настройки';

  @override
  String alertEventsError(String error) {
    return 'Не удалось загрузить события: $error';
  }

  @override
  String get resultsStage1ReadySubtitle =>
      'Сканирование рынка завершено, подготовка профиля ИИ.';

  @override
  String get alertSheetRefreshQuote => 'Обновить ценовое предложение';

  @override
  String get alertsEmptySubtitle =>
      'Создайте первое оповещение из результатов поиска, чтобы отслеживать падение цен.';

  @override
  String get alertSheetArmAutoBuy => 'Автоматическая покупка рычага';

  @override
  String get resultsUpgradePlanTitle => 'Обновите свой тарифный план';

  @override
  String get alertSheetKvontTitle => 'Элементы управления KVONT Auto-buy';

  @override
  String get commonCancel => 'Отмена';

  @override
  String get commonDelete => 'Удалить';

  @override
  String get resultsUnexpectedError =>
      'Во время поиска произошла непредвиденная ситуация.';

  @override
  String get resultsEmptyTitle => 'Соответствующие продукты не найдены';

  @override
  String get alertSheetWaitingPrice => 'Ожидание цены в реальном времени...';

  @override
  String get settingsThemeTitle => 'Тема';

  @override
  String get favoritesEmptyTitle => 'У вас еще нет избранных.';

  @override
  String get commonUpgrade => 'Продвижение';

  @override
  String get favoritesAnalyze => 'Анализ';

  @override
  String get resultsStageFindingTitle => 'Поиск лучших предложений';

  @override
  String get alertSheetTriggerSetup => 'Настройка триггера';

  @override
  String get resultsStageFindingSubtitle => 'Сбор начальных рыночных сигналов.';

  @override
  String get alertSheetSaveButton => 'Сохранить оповещение';

  @override
  String get alertSheetRealtimeMonitoring => 'Мониторинг в реальном времени';

  @override
  String get resultsStage2ReadyTitle => 'Этап 2 готов';

  @override
  String get settingsSubscriptionUnavailable => 'Подписка недоступна';

  @override
  String get resultsUpgradeNow => 'Обновить сейчас';

  @override
  String get alertSheetKvontSubtitle =>
      'These options only prepare notification actions; payment still needs your confirmation.';

  @override
  String get resultsAdjustParameters => 'Настройка параметров поиска';

  @override
  String get commonClear => 'Сброс';

  @override
  String settingsPlanLabel(String plan) {
    return 'План $plan';
  }

  @override
  String alertsTargetValue(String price) {
    return 'Цель: \$$price';
  }

  @override
  String get alertSheetStoreTargeting => 'Таргетинг магазина';

  @override
  String get resultsUpgradePlanMessage =>
      'Перейдите на более высокий план для большего количества поисков и более глубокого анализа ИИ.';

  @override
  String get alertSheetCooldownLabel => 'Охлаждение (минуты)';

  @override
  String get settingsDarkEnabled => 'Включен затемненный режим.';

  @override
  String get alertsKvontPaywallMessage =>
      'Разблокируйте оповещения в реальном времени, аналитику ценовых тенденций и ссылки, готовые к оплате.';

  @override
  String get alertsKvontUpgradeMessage =>
      'Перейдите на KVONT для мониторинга в реальном времени, графиков тенденций и подготовки к автоматической покупке.';

  @override
  String resultsProductsOptimized(int count) {
    return 'Продукты $count оптимизированы';
  }

  @override
  String get settingsNotificationsSubtitle =>
      'Уведомления о ценах и обновления приложения';

  @override
  String get planKvont => 'Квонт';

  @override
  String get planPro => 'Pro';

  @override
  String get resultsNeuralGlitch => 'Проблема поиска';

  @override
  String get alertSheetTargetInvalid => 'Цель должна быть ниже текущей цены.';

  @override
  String get alertsKvontPaywallTitle => 'Супер оповещения KVONT';

  @override
  String get alertSheetStatTarget => 'Цель';

  @override
  String get alertSheetCheckoutPrepared =>
      'Ссылка для оформления заказа подготовлена';

  @override
  String get alertSheetStatLow => 'Низкая';

  @override
  String get settingsPrivacySubtitle =>
      'Управление настройками конфиденциальности';

  @override
  String get resultsStage3ReadyTitle => 'Этап 3 готов';

  @override
  String alertsLastTrigger(String time) {
    return 'Последний триггер: $time';
  }

  @override
  String get resultsSearchQuotaTitle => 'Квота поиска';

  @override
  String get resultsSearchLimitReached => 'Достигнут предел поиска';

  @override
  String get alertSheetRealtimeUnavailable =>
      'Цена в реальном времени недоступна. Обновите расценки и повторите попытку.';

  @override
  String get alertsDeleteTitle => 'Удалить оповещение';

  @override
  String get alertsEmptyTitle => 'Активные оповещения';

  @override
  String alertsCheckNowResult(String checked, String errors, String triggered) {
    return 'Проверил: $checked  Запущен: $triggered  Ошибки: $errors';
  }

  @override
  String get alertEventsTitle => 'События оповещения';

  @override
  String get resultsStage3ReadySubtitle =>
      'Окончательный рейтинг готов с лучшими альтернативами.';

  @override
  String get alertSheetTrendTitle => 'Ценовой тренд (недавний)';

  @override
  String get commonManage => 'Управление';

  @override
  String get favoritesStartShopping => '?????? ???????';

  @override
  String get settingsNotificationsTitle => 'Уведомление';

  @override
  String get settingsLightEnabled => 'Светлый режим включен';

  @override
  String get alertSheetCooldownHelper =>
      'Минимум 5 минут, максимум 1440 минут.';

  @override
  String get alertsKvontSubtitle =>
      'Сотрудник в реальном времени синхронизирует ваши оповещения с ценами в магазине.';

  @override
  String get alertsCreateTooltip => 'Создать оповещение';

  @override
  String get settingsPrivacyTitle => 'Конфиденциальность и безопасность';

  @override
  String alertEventsTriggeredAt(String targetPrice, String triggerPrice) {
    return 'Запускается при \$$triggerPrice (цель \$$targetPrice)';
  }

  @override
  String get alertSheetRealtimeMonitoringSubtitle =>
      'Постоянно проверяет цены для более быстрых триггеров.';

  @override
  String get resultsNeuralSearch => 'Нейронный поиск';

  @override
  String get alertsKvontActive => 'Мониторинг KVONT в реальном времени активен';

  @override
  String get alertSheetRealtimePriceLabel => 'Цена в реальном времени';

  @override
  String get alertsTitle => 'Предупреждения';

  @override
  String get alertSheetDropAmount => 'Бросить';

  @override
  String get alertEventsViewDeal => 'ПОСМОТРЕТЬ КУПОН';

  @override
  String get alertSheetSaved => 'Оповещение успешно создано.';

  @override
  String get resultsStage1ReadyTitle => 'Этап 1 готов';

  @override
  String get alertsDeleteMessage =>
      'Это действие удаляет оповещение и его мониторинг в реальном времени.';

  @override
  String get alertSheetDropPercent => 'Бросить';

  @override
  String get favoritesSubtitle =>
      'Ваши сохраненные продукты и список быстрой повторной проверки.';

  @override
  String get resultsTryAgain => 'Повторить попытку';

  @override
  String get favoritesEmptySubtitle =>
      'Сохраняйте продукты, чтобы отслеживать лучшие цены и более безопасные альтернативы.';

  @override
  String get alertsNever => 'Никогда';

  @override
  String get alertsHistoryTooltip => 'журнал оповещений';

  @override
  String get onboardingSlide1Desc =>
      'Мгновенно сравнивайте предложения от мировых ритейлеров, чтобы найти лучшую цену.';

  @override
  String get authEmailLabel => 'Адрес эл. почты';

  @override
  String get onboardingSlide2Desc =>
      'ИИ проверяет оригинальность продукта и надежность продавца перед покупкой.';

  @override
  String get authEmailHint => 'you@example.com';

  @override
  String get loginCreateAccount => 'Создать новую учетную запись';

  @override
  String authFullNameMinChars(int min) {
    return 'Минимум символов $min';
  }

  @override
  String get profilePaymentMethodsSubtitle => 'Кредитные карты и кошельки';

  @override
  String get loginBackOnboarding => 'Назад к адаптации';

  @override
  String get onboardingNext => 'След.';

  @override
  String get profileNotifications => 'Уведомление';

  @override
  String get profileSecurity => 'Безопасность';

  @override
  String get loginButton => 'Войти';

  @override
  String get authPasswordLabel => 'Пароль';

  @override
  String get splashTagline => 'Сделки, которым можно доверять';

  @override
  String get onboardingSlide3Desc =>
      'Понимайте реальную обратную связь с покупателями с помощью интеллектуальных сводок настроений.';

  @override
  String get onboardingGetStarted => 'Начало работы';

  @override
  String get authFullNameLabel => 'Имя и фамилия';

  @override
  String get registerCreateAccount => 'Создать счет';

  @override
  String get authPasswordHint => 'Введите пароль';

  @override
  String get profileSettingsPreferences => '◎ [Настройки]-[Предпочтения]';

  @override
  String get onboardingSlide4Title => 'Умные оповещения';

  @override
  String get registerSubtitle =>
      'Присоединяйтесь к Dealio и разблокируйте умные рабочие процессы покупок';

  @override
  String get onboardingBack => 'Назад';

  @override
  String get loginWelcomeBack => 'С возвращением!';

  @override
  String get onboardingSkip => 'пропустить';

  @override
  String get loginForgotPassword => 'Забыли пароль?';

  @override
  String get onboardingSlide1Title => 'Сравнение мировых цен';

  @override
  String get registerButton => 'Регистрация';

  @override
  String authPasswordMinChars(int min) {
    return 'Минимум символов $min';
  }

  @override
  String get loginSignInContinue => 'Войдите, чтобы продолжить';

  @override
  String get profileName => 'Алекс Робинсон';

  @override
  String profilePointsProgress(String total, String current) {
    return 'Точки $current /$total';
  }

  @override
  String get onboardingSlide4Desc =>
      'Получайте уведомления, когда ваша целевая цена будет достигнута, и действуйте быстро.';

  @override
  String get profileLogout => 'Выйти';

  @override
  String get profileGoldStatus => 'Gold status';

  @override
  String get registerSuccessTitle => 'Успешная регистрация';

  @override
  String get profilePaymentMethods => 'Платежные методы';

  @override
  String get profileNotificationsSubtitle =>
      'Оповещения о сделках и обновления приложений';

  @override
  String get profileCashbackBalance => 'Баланс кэшбэка';

  @override
  String get onboardingSlide2Title => 'Проверка подлинности';

  @override
  String profileNextReward(String amount) {
    return 'Следующая награда: $amount';
  }

  @override
  String get authEmailInvalid => 'Введите корректный адрес электронной почты';

  @override
  String get authEmailRequired => 'Укажите адрес эл. почты';

  @override
  String get authPasswordRequired => 'Нужно ввести пароль ';

  @override
  String get authFullNameRequired => 'Укажите полное имя';

  @override
  String get registerAlreadyHaveAccount => 'Уже есть аккаунт? Авторизоваться';

  @override
  String get onboardingSlide3Title => 'Отзывы и аналитика';

  @override
  String get profileSecuritySubtitle => 'Биометрия и пароли';

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
  String get aiChatNewChat => 'Новый чат';

  @override
  String get aiChatHistory => 'Чаты';

  @override
  String get aiChatRenameChat => 'Переименовать чат';

  @override
  String get aiChatDeleteChat => 'Удалить чат';

  @override
  String get aiChatRenameTitle => 'Переименовать чат';

  @override
  String get aiChatRenameHint => 'Название чата';

  @override
  String get aiChatRenameSave => 'Сохранить имя';

  @override
  String get aiChatDeleteTitle => 'Удалить чат?';

  @override
  String get aiChatDeleteBody =>
      'Чат будет убран из истории. Вы сможете начать новый в любое время.';

  @override
  String get aiChatDeleteConfirm => 'Удалить чат';

  @override
  String get aiChatActionFailed =>
      'Не удалось обновить этот чат. Попробуйте ещё раз.';

  @override
  String get aiChatManualActions => 'Ручные инструменты';

  @override
  String get aiChatAddToChat => 'Добавить в чат';

  @override
  String get aiChatAttachBarcode => 'Скан штрихкода';

  @override
  String get aiChatAttachImage => 'Поиск по фото';

  @override
  String get aiChatEmptyNameFallback => 'Друг';

  @override
  String aiChatEmptyTitle(String name) {
    return '$name, что покупаем сегодня?';
  }

  @override
  String get aiChatEmptySubtitle => 'Я готов.';

  @override
  String get aiChatErrorReply =>
      'Temporary AI issue. Please retry, or share your budget, country, and top priorities so I can guide you safely.';

  @override
  String get aiChatInputHint => 'Напишите Dealio...';

  @override
  String get aiChatThinkingAnalyzing => 'Анализирую запрос';

  @override
  String get aiChatThinkingSearching => 'Ищу надежные магазины';

  @override
  String get aiChatThinkingPricing => 'Проверяю ценовые сигналы';

  @override
  String get aiChatThinkingRanking => 'Ранжирую лучшие варианты';

  @override
  String get aiChatEmptyHintPrefix => 'Например';

  @override
  String get aiChatEmptyHintCamera =>
      'Найди телефон с хорошей камерой до \$900';

  @override
  String get aiChatEmptyHintBudget => 'Сравни надежные магазины под мой бюджет';

  @override
  String get aiChatEmptyHintAlert => 'Сообщи, когда этот товар подешевеет';

  @override
  String get aiAgentActionNeeds => 'Уточнить нужды';

  @override
  String get aiAgentActionResults => 'Лучшие варианты';

  @override
  String get aiAgentActionAlert => 'Ценовое оповещение';

  @override
  String get aiAgentActionAdvice => 'Совет';

  @override
  String get aiAgentActionCompare => 'Сравнить магазины';

  @override
  String get aiAgentFeedbackHelpful => 'Полезно';

  @override
  String get aiAgentFeedbackImprove => 'Улучшить';

  @override
  String get aiAgentFeedbackSaved => 'Отзыв учтен';

  @override
  String get aiAgentFeedbackHelpfulThanks => 'Спасибо — сигнал учтен.';

  @override
  String get aiAgentFeedbackImproveThanks => 'Понял — настрою следующий ответ.';

  @override
  String get aiAgentPromptNeeds =>
      'Задай мне 3 коротких вопроса, чтобы понять мои потребности, бюджет, страну и приоритеты перед рекомендацией товаров.';

  @override
  String get aiAgentPromptResults =>
      'Покажи лучшие варианты товаров кратким рейтингом с ценой, доверием, плюсами, минусами и самым безопасным следующим шагом.';

  @override
  String get aiAgentPromptAdvice =>
      'Дай короткий совет по покупке: что выбрать, чего избегать и почему.';

  @override
  String get aiAgentPromptCompareStores =>
      'Сравни надежные магазины для этого товара по цене, доставке, возврату, подлинности и риску.';

  @override
  String get aiStructuredDecision => 'РЕШЕНИЕ DEALIO';

  @override
  String get aiStructuredBestMatches => 'ЛУЧШИЕ ВАРИАНТЫ';

  @override
  String get aiStructuredQuestions => 'ВОПРОСЫ';

  @override
  String get aiStructuredPriceWatch => 'ОТСЛЕЖИВАНИЕ ЦЕНЫ';

  @override
  String get aiStructuredPriceWatchSubtitle =>
      'Я могу следить за ценой и сообщить, когда покупать станет безопаснее.';

  @override
  String get aiStructuredStartAlert => 'Следить';

  @override
  String get aiAgentAlertTitle => 'Следить за этой ценой?';

  @override
  String get aiAgentAlertSubtitle =>
      'Dealio будет проверять свежие цены и уведомит, когда цель будет достигнута.';

  @override
  String get aiAgentAlertLoading => 'Проверяю актуальную цену...';

  @override
  String get aiAgentAlertQuoteUnavailable =>
      'Пока не удалось надежно прочитать цену. Вставьте ссылку на товар или используйте расширенную настройку.';

  @override
  String get aiAgentAlertPasteLink =>
      'Вставьте ссылку на товар, чтобы Dealio мог отслеживать его.';

  @override
  String get aiAgentAlertLinkHint => 'https://store.com/product...';

  @override
  String get aiAgentAlertCheckLink => 'Проверить ссылку';

  @override
  String get aiAgentAlertCreate => 'Создать alert';

  @override
  String get aiAgentAlertAdvanced => 'Расширенная настройка';

  @override
  String get aiAgentAlertSelectedProduct => 'Выбранный товар';

  @override
  String get aiAgentAlertCurrent => 'Сейчас';

  @override
  String get aiAgentAlertTarget => 'Цель';

  @override
  String get aiAgentAlertAnyStore => 'Любой надежный магазин';

  @override
  String aiAgentAlertStoreScope(String store) {
    return 'Область отслеживания: $store';
  }

  @override
  String get aiAgentAlertPriceUnknown => 'Неизвестно';

  @override
  String get aiAgentAlertNeedProduct =>
      'Нужен товар или ссылка на магазин, чтобы создать alert.';

  @override
  String get aiAgentAlertCreatedMessage =>
      'Отслеживание цены включено. Я сообщу, когда цель будет достигнута.';

  @override
  String aiAgentSearchResults(String query, int count) {
    return 'Я нашел $count сильных результатов по запросу «$query».';
  }

  @override
  String aiAgentSearchNoResults(String query) {
    return 'Пока не удалось найти сильные совпадения для «$query». Добавьте бюджет, страну или предпочтительный магазин.';
  }

  @override
  String get aiAgentSearchFailed =>
      'Agent search временно недоступен. Я все еще могу помочь уточнить запрос.';

  @override
  String aiStructuredMatchScore(int score) {
    return '$score% совпадение';
  }

  @override
  String get aiChatUserLabel => 'You';

  @override
  String get aiChatAssistantLabel => 'Dealio AI';

  @override
  String get searchHistoryEmpty => '???????? ?????? ???????? ?????';

  @override
  String get searchHeaderTitle => 'Dealio Search';

  @override
  String searchQuotaCompact(String plan, int remaining) {
    return '$plan • ???????? $remaining';
  }

  @override
  String searchQuotaUnlimitedCompact(String plan) {
    return '$plan • ??? ??????';
  }

  @override
  String get searchInputLabel => '?????';

  @override
  String get searchButtonLabel => '??????';

  @override
  String get searchAiNeedsTitle => 'Dealio AI';

  @override
  String get searchAiNeedsSubtitle => '???????? Dealio ???? ???????????.';

  @override
  String get searchAiNeedsHint =>
      '????????: ??????? ???????, ??????? ??????, ??????, ?? \$900...';

  @override
  String get searchNeedChipCamera => '??????';

  @override
  String get searchNeedChipBattery => '???????';

  @override
  String get searchNeedChipBudget => '?? \$900';

  @override
  String get searchNeedChipDurable => '????????';

  @override
  String get searchRecentTitle => '???????? ??????';

  @override
  String get searchFiltersTitle => '???????';

  @override
  String get searchFiltersSubtitle => '??????, ???????? ? ??????';

  @override
  String get searchFiltersButton => '???????';

  @override
  String get searchFiltersApply => '????????? ???????';

  @override
  String get searchFiltersClearStores => '???????? ????????';

  @override
  String get searchBudgetLabel => '??????';

  @override
  String get searchBudgetActive => '?????? ?????';

  @override
  String get searchBudgetHint => '???????????? ???????????? ????';

  @override
  String get searchBudgetInvalid => '??????? ?????????? ??????';

  @override
  String get searchCountryLabel => '??????';

  @override
  String get searchStoresLabel =>
      '????????? ???????? ?????? ??? ?????????????.';

  @override
  String get searchAdvancedTitle => '?????????????';

  @override
  String get searchGlobalScope => '?????????? ????????';

  @override
  String searchSelectedScope(int count) {
    return '$count ????????? ?????????';
  }

  @override
  String searchHistoryStores(int count) {
    return '$count ?????????';
  }

  @override
  String get searchHistoryContext => '????????';

  @override
  String get searchCountryFallback => '??????';
}
