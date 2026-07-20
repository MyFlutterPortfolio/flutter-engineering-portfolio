// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get navHome => 'Agente';

  @override
  String get navSearch => 'Buscar';

  @override
  String get navProfile => 'Perfil';

  @override
  String get aboutTitle => 'Acerca de Dealio';

  @override
  String get aboutSubtitle => 'Creado para comprar mejor';

  @override
  String get languageTitle => 'Idioma de la app';

  @override
  String get languageSubtitle =>
      'La busqueda y los resultados de IA seguiran este idioma';

  @override
  String get langEnglish => 'Ingles';

  @override
  String get langRussian => 'Ruso';

  @override
  String get langSpanish => 'Espanol';

  @override
  String get langUzbek => 'Uzbeko';

  @override
  String get langChinese => 'Chino';

  @override
  String searchPlanUnlimited(String plan) {
    return 'Plan $plan - busqueda ilimitada';
  }

  @override
  String searchPlanRemaining(String plan, int remaining) {
    return 'Plan $plan - quedan $remaining busquedas';
  }

  @override
  String get searchValidationQueryRequired => 'Introduce un producto';

  @override
  String get searchQueryHint => 'ej. iPhone 13 128GB';

  @override
  String get commonRetry => 'Reintentar';

  @override
  String get searchUseUS => 'Usar US';

  @override
  String get searchFreeModeHint =>
      'Modo FREE: las tiendas globales se cargan automaticamente por pais.';

  @override
  String get searchManualStoreHint => 'Enlace/dominio de tienda (amazon.com)';

  @override
  String get commonAdd => 'Anadir';

  @override
  String get searchStoreSearchHint => 'Buscar tiendas...';

  @override
  String get searchStoresEmpty =>
      'Las tiendas del pais seleccionado apareceran aqui.';

  @override
  String get searchStoresLoadFailed =>
      'No se pudieron cargar las tiendas. Intentalo de nuevo.';

  @override
  String get searchErrorCountryRequired =>
      'El pais es obligatorio. Primero selecciona un pais.';

  @override
  String get searchPlanLimitTitle => 'Limite del plan alcanzado';

  @override
  String get searchPlanLimitMessage =>
      'Has alcanzado el limite de tu plan. Actualiza para continuar.';

  @override
  String get searchErrorEnterStoreDomain =>
      'Introduce un dominio o URL de tienda. Ejemplo: amazon.com';

  @override
  String get searchErrorStoreAlreadySelected =>
      'Esta tienda ya esta seleccionada.';

  @override
  String searchErrorStoreLimit(int max) {
    return 'Puedes seleccionar hasta $max tiendas.';
  }

  @override
  String get commonEdit => 'Editar';

  @override
  String get resultsLoadingTitle => 'Escaneando tiendas globales...';

  @override
  String get alertsCheckNow => 'Revisar ahora';

  @override
  String get alertSheetAllStores => 'Todas las tiendas';

  @override
  String get alertSheetUserConsent => 'I approve one-tap checkout';

  @override
  String get alertsTargetNA => 'Objetivo: N/A';

  @override
  String get alertSheetStatHigh => 'M?ximo';

  @override
  String get settingsLogoutSubtitle =>
      'Cerrar sesi?n de forma segura en este dispositivo';

  @override
  String get alertSheetTitle => 'Crear alerta de precio';

  @override
  String get favoritesTitle => 'Favoritos';

  @override
  String get resultsEmptyDescription =>
      'Intenta ajustar palabras clave, pais o tiendas.';

  @override
  String get planPlus => 'Plus';

  @override
  String get resultsLoadingSubtitle =>
      'Agregando ofertas y matching de IA en tiempo real.';

  @override
  String get resultsStage2ReadySubtitle =>
      'Perfil de IA generado, validando confianza de tiendas.';

  @override
  String alertsTriggers(int count) {
    return 'Activaciones: $count';
  }

  @override
  String get alertsDealButton => 'Abrir oferta';

  @override
  String alertSheetCurrentTarget(String target, String observed) {
    return 'Actual: $observed  Objetivo: $target';
  }

  @override
  String settingsSearchesLeft(int remaining, int limit) {
    return 'B?squedas restantes: $remaining/$limit';
  }

  @override
  String get planFree => 'Free';

  @override
  String get commonLogout => 'Cerrar sesi?n';

  @override
  String get alertEventsEmpty => 'A?n no hay eventos de alerta.';

  @override
  String get commonSettings => 'Ajustes';

  @override
  String alertEventsError(String error) {
    return 'Error al cargar eventos: $error';
  }

  @override
  String get resultsStage1ReadySubtitle =>
      'Escaneo de mercado completo, preparando perfil de IA.';

  @override
  String get alertSheetRefreshQuote => 'Actualizar cotizaci?n';

  @override
  String get alertsEmptySubtitle =>
      'Crea tu primera alerta desde resultados de b?squeda para seguir bajadas de precio.';

  @override
  String get alertSheetArmAutoBuy => 'Activar auto-buy';

  @override
  String get resultsUpgradePlanTitle => 'Mejora tu plan';

  @override
  String get alertSheetKvontTitle => 'Controles Auto-buy KVONT';

  @override
  String get commonCancel => 'Cancelar';

  @override
  String get commonDelete => 'Eliminar';

  @override
  String get resultsUnexpectedError =>
      'Ocurri? un error inesperado durante la b?squeda.';

  @override
  String get resultsEmptyTitle => 'No se encontraron productos coincidentes';

  @override
  String get alertSheetWaitingPrice => 'Esperando precio en tiempo real...';

  @override
  String get settingsThemeTitle => 'Tema';

  @override
  String get favoritesEmptyTitle => 'A?n no hay favoritos';

  @override
  String get commonUpgrade => 'Mejorar';

  @override
  String get favoritesAnalyze => 'Analizar';

  @override
  String get resultsStageFindingTitle => 'Buscando mejores ofertas';

  @override
  String get alertSheetTriggerSetup => 'Configuraci?n de activaci?n';

  @override
  String get resultsStageFindingSubtitle =>
      'Recopilando se?ales iniciales del mercado.';

  @override
  String get alertSheetSaveButton => 'Guardar alerta';

  @override
  String get alertSheetRealtimeMonitoring => 'Monitoreo en tiempo real';

  @override
  String get resultsStage2ReadyTitle => 'Etapa 2 lista';

  @override
  String get settingsSubscriptionUnavailable => 'Suscripci?n no disponible';

  @override
  String get resultsUpgradeNow => 'Mejorar ahora';

  @override
  String get alertSheetKvontSubtitle =>
      'These options only prepare notification actions; payment still needs your confirmation.';

  @override
  String get resultsAdjustParameters => 'Ajustar par?metros de b?squeda';

  @override
  String get commonClear => 'Limpiar';

  @override
  String settingsPlanLabel(String plan) {
    return 'Plan $plan';
  }

  @override
  String alertsTargetValue(String price) {
    return 'Objetivo: \$$price';
  }

  @override
  String get alertSheetStoreTargeting => 'Selecci?n de tienda';

  @override
  String get resultsUpgradePlanMessage =>
      'Pasa a un plan superior para m?s b?squedas y an?lisis de IA m?s profundo.';

  @override
  String get alertSheetCooldownLabel => 'Cooldown (minutos)';

  @override
  String get settingsDarkEnabled => 'Modo oscuro activado';

  @override
  String get alertsKvontPaywallMessage =>
      'Desbloquea alertas en tiempo real, an?lisis de tendencia y enlaces listos para checkout.';

  @override
  String get alertsKvontUpgradeMessage =>
      'Mejora a KVONT para monitoreo en tiempo real, gr?ficos de tendencia y preparaci?n de auto-buy.';

  @override
  String resultsProductsOptimized(int count) {
    return '$count productos optimizados';
  }

  @override
  String get settingsNotificationsSubtitle =>
      'Alertas de precio y novedades de la app';

  @override
  String get planKvont => 'Kvont';

  @override
  String get planPro => 'Pro';

  @override
  String get resultsNeuralGlitch => 'Problema de busqueda';

  @override
  String get alertSheetTargetInvalid =>
      'El objetivo debe ser menor que el precio actual.';

  @override
  String get alertsKvontPaywallTitle => 'KVONT Super Alerts';

  @override
  String get alertSheetStatTarget => 'Objetivo';

  @override
  String get alertSheetCheckoutPrepared => 'Enlace de checkout preparado';

  @override
  String get alertSheetStatLow => 'M?nimo';

  @override
  String get settingsPrivacySubtitle => 'Gestionar preferencias de privacidad';

  @override
  String get resultsStage3ReadyTitle => 'Etapa 3 lista';

  @override
  String alertsLastTrigger(String time) {
    return '?ltima activaci?n: $time';
  }

  @override
  String get resultsSearchQuotaTitle => 'Cuota de b?squeda';

  @override
  String get resultsSearchLimitReached => 'L?mite de b?squeda alcanzado';

  @override
  String get alertSheetRealtimeUnavailable =>
      'Precio en tiempo real no disponible. Actualiza la cotizaci?n e int?ntalo de nuevo.';

  @override
  String get alertsDeleteTitle => '?Eliminar alerta?';

  @override
  String get alertsEmptyTitle => 'No hay alertas activas';

  @override
  String alertsCheckNowResult(String checked, String errors, String triggered) {
    return 'Revisado: $checked  Activado: $triggered  Errores: $errors';
  }

  @override
  String get alertEventsTitle => 'Eventos de alerta';

  @override
  String get resultsStage3ReadySubtitle =>
      'Ranking final listo con mejores alternativas.';

  @override
  String get alertSheetTrendTitle => 'Tendencia de precio (reciente)';

  @override
  String get commonManage => 'Gestionar';

  @override
  String get favoritesStartShopping => 'Empezar a comprar';

  @override
  String get settingsNotificationsTitle => 'Notificaciones';

  @override
  String get settingsLightEnabled => 'Modo claro activado';

  @override
  String get alertSheetCooldownHelper =>
      'M?nimo 5 minutos, m?ximo 1440 minutos.';

  @override
  String get alertsKvontSubtitle =>
      'El worker en tiempo real sincroniza tus alertas con precios de tiendas.';

  @override
  String get alertsCreateTooltip => 'Crear alerta';

  @override
  String get settingsPrivacyTitle => 'Privacidad y seguridad';

  @override
  String alertEventsTriggeredAt(String targetPrice, String triggerPrice) {
    return 'Activado en \$$triggerPrice (objetivo \$$targetPrice)';
  }

  @override
  String get alertSheetRealtimeMonitoringSubtitle =>
      'Verifica precios continuamente para activaciones m?s r?pidas.';

  @override
  String get resultsNeuralSearch => 'Neural Search';

  @override
  String get alertsKvontActive => 'Monitoreo en tiempo real KVONT activo';

  @override
  String get alertSheetRealtimePriceLabel => 'Precio en tiempo real';

  @override
  String get alertsTitle => 'Alertas';

  @override
  String get alertSheetDropAmount => 'Bajada \$';

  @override
  String get alertEventsViewDeal => 'Ver oferta';

  @override
  String get alertSheetSaved => 'Alerta creada correctamente.';

  @override
  String get resultsStage1ReadyTitle => 'Etapa 1 lista';

  @override
  String get alertsDeleteMessage =>
      'Esta acci?n elimina la alerta y su monitoreo en tiempo real.';

  @override
  String get alertSheetDropPercent => 'Bajada %';

  @override
  String get favoritesSubtitle =>
      'Tus productos guardados y lista r?pida de revisi?n.';

  @override
  String get resultsTryAgain => 'Intentar de nuevo';

  @override
  String get favoritesEmptySubtitle =>
      'Guarda productos para seguir mejores precios y alternativas m?s seguras.';

  @override
  String get alertsNever => 'Nunca';

  @override
  String get alertsHistoryTooltip => 'Historial de alertas';

  @override
  String get onboardingSlide1Desc =>
      'Compara ofertas globales al instante y encuentra el mejor precio.';

  @override
  String get authEmailLabel => 'Email';

  @override
  String get onboardingSlide2Desc =>
      'La IA verifica autenticidad del producto y fiabilidad del vendedor antes de comprar.';

  @override
  String get authEmailHint => 'you@example.com';

  @override
  String get loginCreateAccount => 'Crear cuenta nueva';

  @override
  String authFullNameMinChars(int min) {
    return 'M?nimo $min caracteres';
  }

  @override
  String get profilePaymentMethodsSubtitle => 'Tarjetas y billeteras';

  @override
  String get loginBackOnboarding => 'Volver al onboarding';

  @override
  String get onboardingNext => 'Siguiente';

  @override
  String get profileNotifications => 'Notificaciones';

  @override
  String get profileSecurity => 'Seguridad';

  @override
  String get loginButton => 'Entrar';

  @override
  String get authPasswordLabel => 'Contrase?a';

  @override
  String get splashTagline => 'Ofertas en las que puedes confiar';

  @override
  String get onboardingSlide3Desc =>
      'Comprende opiniones reales con res?menes inteligentes de sentimiento.';

  @override
  String get onboardingGetStarted => 'Comenzar';

  @override
  String get authFullNameLabel => 'Nombre completo';

  @override
  String get registerCreateAccount => 'Crear cuenta';

  @override
  String get authPasswordHint => 'Introduce tu contrase?a';

  @override
  String get profileSettingsPreferences => 'Ajustes y preferencias';

  @override
  String get onboardingSlide4Title => 'Alertas inteligentes';

  @override
  String get registerSubtitle =>
      '?nete a Dealio y desbloquea flujos de compra inteligentes';

  @override
  String get onboardingBack => 'Atr?s';

  @override
  String get loginWelcomeBack => 'Bienvenido de nuevo';

  @override
  String get onboardingSkip => 'Saltar';

  @override
  String get loginForgotPassword => '?Olvidaste tu contrase?a?';

  @override
  String get onboardingSlide1Title => 'Comparaci?n global de precios';

  @override
  String get registerButton => 'Registrarse';

  @override
  String authPasswordMinChars(int min) {
    return 'M?nimo $min caracteres';
  }

  @override
  String get loginSignInContinue => 'Inicia sesi?n para continuar';

  @override
  String get profileName => 'Alex Robinson';

  @override
  String profilePointsProgress(String total, String current) {
    return '$current / $total puntos';
  }

  @override
  String get onboardingSlide4Desc =>
      'Recibe aviso cuando el precio objetivo se alcance y act?a r?pido.';

  @override
  String get profileLogout => 'Cerrar sesi?n';

  @override
  String get profileGoldStatus => 'ESTADO GOLD';

  @override
  String get registerSuccessTitle => 'Registro exitoso';

  @override
  String get profilePaymentMethods => 'M?todos de pago';

  @override
  String get profileNotificationsSubtitle =>
      'Alertas de ofertas y novedades de la app';

  @override
  String get profileCashbackBalance => 'Saldo de cashback';

  @override
  String get onboardingSlide2Title => 'Verificaci?n de autenticidad';

  @override
  String profileNextReward(String amount) {
    return 'Pr?xima recompensa: $amount';
  }

  @override
  String get authEmailInvalid => 'Introduce un email v?lido';

  @override
  String get authEmailRequired => 'El email es obligatorio';

  @override
  String get authPasswordRequired => 'La contrase?a es obligatoria';

  @override
  String get authFullNameRequired => 'El nombre completo es obligatorio';

  @override
  String get registerAlreadyHaveAccount => '?Ya tienes cuenta? Iniciar sesi?n';

  @override
  String get onboardingSlide3Title => 'Rese?as e insights';

  @override
  String get profileSecuritySubtitle => 'Biometr?a y contrase?as';

  @override
  String get navFavorites => 'Favoritos';

  @override
  String get favoritesLoadFailed => 'La lista guardada no está sincronizada';

  @override
  String get favoritesLoadSubtitle =>
      'Dealio no pudo actualizar tus productos guardados ahora. Revisa la conexión y sincroniza otra vez.';

  @override
  String get favoritesLoadAction => 'Actualizar lista';

  @override
  String get favoritesProductFallback => 'Producto';

  @override
  String get favoritesNoNotes => 'Producto guardado';

  @override
  String get favoritesSaveTooltip => 'Guardar en favoritos';

  @override
  String get favoritesRemoveTooltip => 'Quitar de favoritos';

  @override
  String get favoritesSaved => 'Guardado en favoritos.';

  @override
  String get favoritesRemoved => 'Eliminado de favoritos.';

  @override
  String get favoritesActionFailed =>
      'No se pudo actualizar la lista guardada. Inténtalo de nuevo.';

  @override
  String get notificationsTitle => 'Notificaciones';

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
  String get notificationsTabAll => 'Todo';

  @override
  String get notificationsTabPriceAlerts => 'Alertas de precio';

  @override
  String get notificationsTabAiInsights => 'AI Insights';

  @override
  String get notificationsTabSustainability => 'Sustainability';

  @override
  String get notificationsTabStoreUpdates => 'Store Updates';

  @override
  String get notificationsViewProduct => 'Ver producto';

  @override
  String get notificationsReanalyze => 'Reanalizar';

  @override
  String get notificationsEmptyTitle => 'No notifications yet';

  @override
  String get notificationsEmptySubtitle =>
      'Create price alerts to receive real-time deal updates here.';

  @override
  String get alertPickerTitle => 'Crear alerta de precio';

  @override
  String get alertPickerSubtitle =>
      'Choose how you want to start. Search is best for comparison; manual link tracks one exact store page.';

  @override
  String get alertPickerSearchTitle => 'Buscar producto';

  @override
  String get alertPickerSearchSubtitle =>
      'Find a product first, compare stores, then create an alert.';

  @override
  String get alertPickerManualTitle => 'Enlace manual de tienda';

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
  String get resultsReady => 'Listo';

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
  String get resultsProductFallback => 'Producto';

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
  String get aiChatNewChat => 'Nuevo chat';

  @override
  String get aiChatHistory => 'Chats';

  @override
  String get aiChatRenameChat => 'Renombrar chat';

  @override
  String get aiChatDeleteChat => 'Eliminar chat';

  @override
  String get aiChatRenameTitle => 'Renombrar chat';

  @override
  String get aiChatRenameHint => 'Nombre del chat';

  @override
  String get aiChatRenameSave => 'Guardar nombre';

  @override
  String get aiChatDeleteTitle => '¿Eliminar chat?';

  @override
  String get aiChatDeleteBody =>
      'Esto quita el chat de tu historial. Puedes iniciar uno nuevo cuando quieras.';

  @override
  String get aiChatDeleteConfirm => 'Eliminar chat';

  @override
  String get aiChatActionFailed =>
      'No se pudo actualizar este chat. Inténtalo de nuevo.';

  @override
  String get aiChatManualActions => 'Herramientas manuales';

  @override
  String get aiChatAddToChat => 'Añadir al chat';

  @override
  String get aiChatAttachBarcode => 'Escanear código';

  @override
  String get aiChatAttachImage => 'Buscar por imagen';

  @override
  String get aiChatEmptyNameFallback => 'Amigo';

  @override
  String aiChatEmptyTitle(String name) {
    return '$name, ¿qué compramos hoy?';
  }

  @override
  String get aiChatEmptySubtitle => 'Estoy listo.';

  @override
  String get aiChatErrorReply =>
      'Temporary AI issue. Please retry, or share your budget, country, and top priorities so I can guide you safely.';

  @override
  String get aiChatInputHint => 'Escribe a Dealio...';

  @override
  String get aiChatThinkingAnalyzing => 'Analizando tu solicitud';

  @override
  String get aiChatThinkingSearching => 'Buscando tiendas fiables';

  @override
  String get aiChatThinkingPricing => 'Revisando señales de precio';

  @override
  String get aiChatThinkingRanking => 'Ordenando mejores opciones';

  @override
  String get aiChatEmptyHintPrefix => 'Prueba';

  @override
  String get aiChatEmptyHintCamera =>
      'Encuentra un teléfono con buena cámara por menos de \$900';

  @override
  String get aiChatEmptyHintBudget =>
      'Compara tiendas confiables para mi presupuesto';

  @override
  String get aiChatEmptyHintAlert =>
      'Avísame cuando este producto baje de precio';

  @override
  String get aiAgentActionNeeds => 'Preguntar necesidades';

  @override
  String get aiAgentActionResults => 'Mejores resultados';

  @override
  String get aiAgentActionAlert => 'Alerta de precio';

  @override
  String get aiAgentActionAdvice => 'Consejo';

  @override
  String get aiAgentActionCompare => 'Comparar tiendas';

  @override
  String get aiAgentFeedbackHelpful => 'Útil';

  @override
  String get aiAgentFeedbackImprove => 'Mejorar';

  @override
  String get aiAgentFeedbackSaved => 'Feedback recibido';

  @override
  String get aiAgentFeedbackHelpfulThanks => 'Gracias — señal recibida.';

  @override
  String get aiAgentFeedbackImproveThanks =>
      'Entendido — ajustaré la próxima respuesta.';

  @override
  String get aiAgentPromptNeeds =>
      'Hazme 3 preguntas cortas para entender mis necesidades, presupuesto, país y prioridades antes de recomendar productos.';

  @override
  String get aiAgentPromptResults =>
      'Muestra las mejores opciones de producto como una lista breve ordenada por precio, confianza, pros, contras y el siguiente paso más seguro.';

  @override
  String get aiAgentPromptAdvice =>
      'Dame una recomendación breve de compra: qué elegir, qué evitar y por qué.';

  @override
  String get aiAgentPromptCompareStores =>
      'Compara tiendas confiables para este producto por precio, entrega, política de devolución, autenticidad y riesgo.';

  @override
  String get aiStructuredDecision => 'DECISIÓN DEALIO';

  @override
  String get aiStructuredBestMatches => 'MEJORES OPCIONES';

  @override
  String get aiStructuredQuestions => 'PREGUNTAS';

  @override
  String get aiStructuredPriceWatch => 'SEGUIMIENTO DE PRECIO';

  @override
  String get aiStructuredPriceWatchSubtitle =>
      'Puedo vigilar este precio y avisarte cuando sea más seguro comprar.';

  @override
  String get aiStructuredStartAlert => 'Seguir';

  @override
  String get aiAgentAlertTitle => '¿Vigilar este precio?';

  @override
  String get aiAgentAlertSubtitle =>
      'Dealio revisará precios recientes y te avisará cuando se alcance el objetivo.';

  @override
  String get aiAgentAlertLoading => 'Comprobando el precio más reciente...';

  @override
  String get aiAgentAlertQuoteUnavailable =>
      'Aún no pude leer un precio fiable. Pega un enlace de producto o usa la configuración avanzada.';

  @override
  String get aiAgentAlertPasteLink =>
      'Pega un enlace de producto para que Dealio pueda rastrearlo.';

  @override
  String get aiAgentAlertLinkHint => 'https://store.com/product...';

  @override
  String get aiAgentAlertCheckLink => 'Comprobar enlace';

  @override
  String get aiAgentAlertCreate => 'Crear alerta';

  @override
  String get aiAgentAlertAdvanced => 'Configuración avanzada';

  @override
  String get aiAgentAlertSelectedProduct => 'Producto seleccionado';

  @override
  String get aiAgentAlertCurrent => 'Ahora';

  @override
  String get aiAgentAlertTarget => 'Objetivo';

  @override
  String get aiAgentAlertAnyStore => 'Cualquier tienda confiable';

  @override
  String aiAgentAlertStoreScope(String store) {
    return 'Alcance de seguimiento: $store';
  }

  @override
  String get aiAgentAlertPriceUnknown => 'Desconocido';

  @override
  String get aiAgentAlertNeedProduct =>
      'Necesito un producto o enlace de tienda para crear esta alerta.';

  @override
  String get aiAgentAlertCreatedMessage =>
      'El seguimiento de precio está activo. Te avisaré cuando se alcance el objetivo.';

  @override
  String aiAgentSearchResults(String query, int count) {
    return 'Encontré $count resultado(s) fuerte(s) para “$query”.';
  }

  @override
  String aiAgentSearchNoResults(String query) {
    return 'Aún no encontré coincidencias fuertes para “$query”. Prueba añadir presupuesto, país o tienda preferida.';
  }

  @override
  String get aiAgentSearchFailed =>
      'La búsqueda del agente no está disponible temporalmente. Aun así puedo ayudarte a precisar la consulta.';

  @override
  String aiStructuredMatchScore(int score) {
    return '$score% afinidad';
  }

  @override
  String get aiChatUserLabel => 'You';

  @override
  String get aiChatAssistantLabel => 'Dealio AI';

  @override
  String get searchHistoryEmpty => 'Las busquedas recientes apareceran aqui';

  @override
  String get searchHeaderTitle => 'Dealio Search';

  @override
  String searchQuotaCompact(String plan, int remaining) {
    return '$plan • $remaining restantes';
  }

  @override
  String searchQuotaUnlimitedCompact(String plan) {
    return '$plan • ilimitado';
  }

  @override
  String get searchInputLabel => 'Buscar';

  @override
  String get searchButtonLabel => 'Buscar';

  @override
  String get searchAiNeedsTitle => 'Dealio AI';

  @override
  String get searchAiNeedsSubtitle => 'Escribe tus necesidades a Dealio.';

  @override
  String get searchAiNeedsHint =>
      'Ejemplo: buena bateria, buena camara, ligero, hasta \$900...';

  @override
  String get searchNeedChipCamera => 'camara';

  @override
  String get searchNeedChipBattery => 'bateria';

  @override
  String get searchNeedChipBudget => 'hasta \$900';

  @override
  String get searchNeedChipDurable => 'duradero';

  @override
  String get searchRecentTitle => 'Busquedas recientes';

  @override
  String get searchFiltersTitle => 'Filtros';

  @override
  String get searchFiltersSubtitle => 'Pais, tiendas y presupuesto';

  @override
  String get searchFiltersButton => 'Filtros';

  @override
  String get searchFiltersApply => 'Aplicar filtros';

  @override
  String get searchFiltersClearStores => 'Limpiar tiendas';

  @override
  String get searchBudgetLabel => 'Presupuesto';

  @override
  String get searchBudgetActive => 'Presupuesto listo';

  @override
  String get searchBudgetHint => 'Precio maximo opcional';

  @override
  String get searchBudgetInvalid => 'Introduce un presupuesto valido';

  @override
  String get searchCountryLabel => 'Pais';

  @override
  String get searchStoresLabel => 'Elige tiendas solo si hace falta.';

  @override
  String get searchAdvancedTitle => 'Avanzado';

  @override
  String get searchGlobalScope => 'Tiendas globales';

  @override
  String searchSelectedScope(int count) {
    return '$count tiendas seleccionadas';
  }

  @override
  String searchHistoryStores(int count) {
    return '$count tiendas';
  }

  @override
  String get searchHistoryContext => 'contexto';

  @override
  String get searchCountryFallback => 'Pais';
}
