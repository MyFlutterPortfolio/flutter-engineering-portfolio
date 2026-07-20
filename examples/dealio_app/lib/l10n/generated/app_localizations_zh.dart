// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get navHome => '智能体';

  @override
  String get navSearch => '搜索';

  @override
  String get navProfile => '轮廓';

  @override
  String get aboutTitle => '关于 Dealio';

  @override
  String get aboutSubtitle => '为更聪明的购物而打造';

  @override
  String get languageTitle => '应用程序语言';

  @override
  String get languageSubtitle => '搜索和 AI 结果遵循此语言';

  @override
  String get langEnglish => '英语';

  @override
  String get langRussian => '俄语';

  @override
  String get langSpanish => '西班牙语';

  @override
  String get langUzbek => '乌兹别克语';

  @override
  String get langChinese => '中国人';

  @override
  String searchPlanUnlimited(String plan) {
    return '$plan 计划 - 无限制搜索';
  }

  @override
  String searchPlanRemaining(String plan, int remaining) {
    return '$plan 计划 - $remaining 向左搜索';
  }

  @override
  String get searchValidationQueryRequired => '请输入产品';

  @override
  String get searchQueryHint => '例如iPhone 13 128GB';

  @override
  String get commonRetry => '重试';

  @override
  String get searchUseUS => '使用美国';

  @override
  String get searchFreeModeHint => '免费模式：全球商店按国家/地区自动加载。';

  @override
  String get searchManualStoreHint => '全球商店链接/域名 (amazon.com)';

  @override
  String get commonAdd => '添加';

  @override
  String get searchStoreSearchHint => '搜索商店...';

  @override
  String get searchStoresEmpty => '所选国家/地区的商店将显示在此处。';

  @override
  String get searchStoresLoadFailed => '无法加载商店。请再试一次。';

  @override
  String get searchErrorCountryRequired => '国家/地区为必填项。请先选择一个国家。';

  @override
  String get searchPlanLimitTitle => '已达到计划限制';

  @override
  String get searchPlanLimitMessage => '您的计划限制已达到。升级才能继续。';

  @override
  String get searchErrorEnterStoreDomain => '输入商店域名或 URL。示例：amazon.com';

  @override
  String get searchErrorStoreAlreadySelected => '该店已被选定。';

  @override
  String searchErrorStoreLimit(int max) {
    return '您最多可以选择 $max 个商店。';
  }

  @override
  String get commonEdit => '编辑';

  @override
  String get resultsLoadingTitle => '扫描全球商店...';

  @override
  String get alertsCheckNow => '立即查看';

  @override
  String get alertSheetAllStores => '所有商店';

  @override
  String get alertSheetUserConsent => 'I approve one-tap checkout';

  @override
  String get alertsTargetNA => '目标：不适用';

  @override
  String get alertSheetStatHigh => '高的';

  @override
  String get settingsLogoutSubtitle => '从此设备安全退出';

  @override
  String get alertSheetTitle => '创建价格提醒';

  @override
  String get favoritesTitle => '收藏夹';

  @override
  String get resultsEmptyDescription => '尝试优化关键字、国家/地区或商店设置。';

  @override
  String get planPlus => 'Plus';

  @override
  String get resultsLoadingSubtitle => '实时聚合报价和人工智能匹配。';

  @override
  String get resultsStage2ReadySubtitle => '生成 AI 配置文件，验证商店信心。';

  @override
  String alertsTriggers(int count) {
    return '触发器：$count';
  }

  @override
  String get alertsDealButton => '开放交易';

  @override
  String alertSheetCurrentTarget(String target, String observed) {
    return '当前：$observed 目标：$target';
  }

  @override
  String settingsSearchesLeft(int remaining, int limit) {
    return '$remaining/$limit 向左搜索';
  }

  @override
  String get planFree => 'Free';

  @override
  String get commonLogout => '退出';

  @override
  String get alertEventsEmpty => '还没有警报事件。';

  @override
  String get commonSettings => '设置';

  @override
  String alertEventsError(String error) {
    return '无法加载事件：$error';
  }

  @override
  String get resultsStage1ReadySubtitle => '市场扫描完成，正在准备 AI 简介。';

  @override
  String get alertSheetRefreshQuote => '刷新报价';

  @override
  String get alertsEmptySubtitle => '根据搜索结果创建第一个警报以跟踪价格下跌。';

  @override
  String get alertSheetArmAutoBuy => '手臂自动购买';

  @override
  String get resultsUpgradePlanTitle => '升级您的计划';

  @override
  String get alertSheetKvontTitle => 'KVONT 自动购买控件';

  @override
  String get commonCancel => '取消';

  @override
  String get commonDelete => '删除';

  @override
  String get resultsUnexpectedError => '搜寻过程中发生了意想不到的事情。';

  @override
  String get resultsEmptyTitle => '没有找到匹配的产品';

  @override
  String get alertSheetWaitingPrice => '等待实时价格...';

  @override
  String get settingsThemeTitle => '主题';

  @override
  String get favoritesEmptyTitle => '还没有收藏夹';

  @override
  String get commonUpgrade => '升级';

  @override
  String get favoritesAnalyze => '分析';

  @override
  String get resultsStageFindingTitle => '寻找最佳优惠';

  @override
  String get alertSheetTriggerSetup => '触发设置';

  @override
  String get resultsStageFindingSubtitle => '收集初始市场信号。';

  @override
  String get alertSheetSaveButton => '保存提醒';

  @override
  String get alertSheetRealtimeMonitoring => '实时监控';

  @override
  String get resultsStage2ReadyTitle => '第二阶段准备就绪';

  @override
  String get settingsSubscriptionUnavailable => '无法订阅';

  @override
  String get resultsUpgradeNow => '立即升级';

  @override
  String get alertSheetKvontSubtitle =>
      'These options only prepare notification actions; payment still needs your confirmation.';

  @override
  String get resultsAdjustParameters => '调整搜索参数';

  @override
  String get commonClear => '清除';

  @override
  String settingsPlanLabel(String plan) {
    return '$plan 计划';
  }

  @override
  String alertsTargetValue(String price) {
    return '目标：\$$price';
  }

  @override
  String get alertSheetStoreTargeting => '商店定位';

  @override
  String get resultsUpgradePlanMessage => '转向更高的计划以进行更多搜索和更深入的人工智能分析。';

  @override
  String get alertSheetCooldownLabel => '冷却时间（分钟）';

  @override
  String get settingsDarkEnabled => '启用深色模式';

  @override
  String get alertsKvontPaywallMessage => '解锁实时警报、价格趋势分析和结帐就绪链接。';

  @override
  String get alertsKvontUpgradeMessage => '升级到 KVONT 以进行实时监控、趋势图和自动购买准备。';

  @override
  String resultsProductsOptimized(int count) {
    return '$count 产品已优化';
  }

  @override
  String get settingsNotificationsSubtitle => '价格提醒和应用程序更新';

  @override
  String get planKvont => 'Kvont';

  @override
  String get planPro => 'Pro';

  @override
  String get resultsNeuralGlitch => '搜索问题';

  @override
  String get alertSheetTargetInvalid => '目标必须低于当前价格。';

  @override
  String get alertsKvontPaywallTitle => 'KVONT 超级警报';

  @override
  String get alertSheetStatTarget => '目标';

  @override
  String get alertSheetCheckoutPrepared => '结帐链接已准备好';

  @override
  String get alertSheetStatLow => '低的';

  @override
  String get settingsPrivacySubtitle => '管理隐私偏好';

  @override
  String get resultsStage3ReadyTitle => '第三阶段准备就绪';

  @override
  String alertsLastTrigger(String time) {
    return '最后一次触发：$time';
  }

  @override
  String get resultsSearchQuotaTitle => '搜索配额';

  @override
  String get resultsSearchLimitReached => '已达到搜索限制';

  @override
  String get alertSheetRealtimeUnavailable => '无法获取实时价格。刷新报价并重试。';

  @override
  String get alertsDeleteTitle => '删除警报？';

  @override
  String get alertsEmptyTitle => '没有活动警报';

  @override
  String alertsCheckNowResult(String checked, String errors, String triggered) {
    return '检查：$checked 触发：$triggered 错误：$errors';
  }

  @override
  String get alertEventsTitle => '警报事件';

  @override
  String get resultsStage3ReadySubtitle => '最终排名已准备好并提供最佳替代方案。';

  @override
  String get alertSheetTrendTitle => '价格趋势（近期）';

  @override
  String get commonManage => '管理';

  @override
  String get favoritesStartShopping => '开始购物';

  @override
  String get settingsNotificationsTitle => '通知';

  @override
  String get settingsLightEnabled => '灯光模式已启用';

  @override
  String get alertSheetCooldownHelper => '最短 5 分钟，最长 1440 分钟。';

  @override
  String get alertsKvontSubtitle => '实时工作人员使您的提醒与商店价格同步。';

  @override
  String get alertsCreateTooltip => '创建提醒';

  @override
  String get settingsPrivacyTitle => '隐私与安全';

  @override
  String alertEventsTriggeredAt(String targetPrice, String triggerPrice) {
    return '在 \$$triggerPrice 触发（目标 \$$targetPrice）';
  }

  @override
  String get alertSheetRealtimeMonitoringSubtitle => '不断检查价格以加快触发速度。';

  @override
  String get resultsNeuralSearch => 'Neural Search';

  @override
  String get alertsKvontActive => 'KVONT实时监控活跃';

  @override
  String get alertSheetRealtimePriceLabel => '实时价格';

  @override
  String get alertsTitle => '警报';

  @override
  String get alertSheetDropAmount => '下降 \$';

  @override
  String get alertEventsViewDeal => '查看优惠';

  @override
  String get alertSheetSaved => '警报创建成功。';

  @override
  String get resultsStage1ReadyTitle => '第一阶段准备就绪';

  @override
  String get alertsDeleteMessage => '此操作会删除警报及其实时监控。';

  @override
  String get alertSheetDropPercent => '降低 ％';

  @override
  String get favoritesSubtitle => '您保存的产品和快速重新检查列表。';

  @override
  String get resultsTryAgain => '再试一次';

  @override
  String get favoritesEmptySubtitle => '保存产品以跟踪更好的价格和更安全的替代品。';

  @override
  String get alertsNever => '绝不';

  @override
  String get alertsHistoryTooltip => '警报历史记录';

  @override
  String get onboardingSlide1Desc => '立即比较全球零售商的交易，找到最优惠的价格。';

  @override
  String get authEmailLabel => '电子邮件';

  @override
  String get onboardingSlide2Desc => '人工智能会在您购买前验证产品的原创性和卖家的可靠性。';

  @override
  String get authEmailHint => 'you@example.com';

  @override
  String get loginCreateAccount => '创建新帐户';

  @override
  String authFullNameMinChars(int min) {
    return '最少 $min 个字符';
  }

  @override
  String get profilePaymentMethodsSubtitle => '信用卡和钱包';

  @override
  String get loginBackOnboarding => '返回入职';

  @override
  String get onboardingNext => '下一个';

  @override
  String get profileNotifications => '通知';

  @override
  String get profileSecurity => '安全';

  @override
  String get loginButton => '登录';

  @override
  String get authPasswordLabel => '密码';

  @override
  String get splashTagline => '值得信赖的优惠';

  @override
  String get onboardingSlide3Desc => '通过智能情绪摘要了解真实的买家反馈。';

  @override
  String get onboardingGetStarted => '开始使用';

  @override
  String get authFullNameLabel => '姓名';

  @override
  String get registerCreateAccount => '创建账户';

  @override
  String get authPasswordHint => '输入您的密码';

  @override
  String get profileSettingsPreferences => '设置和首选项';

  @override
  String get onboardingSlide4Title => '智能提醒';

  @override
  String get registerSubtitle => '加入 Dealio 并解锁智能购物工作流程';

  @override
  String get onboardingBack => '后退';

  @override
  String get loginWelcomeBack => '欢迎回来';

  @override
  String get onboardingSkip => '跳过';

  @override
  String get loginForgotPassword => '忘记密码？';

  @override
  String get onboardingSlide1Title => '全球价格比较';

  @override
  String get registerButton => '报名';

  @override
  String authPasswordMinChars(int min) {
    return '最少 $min 个字符';
  }

  @override
  String get loginSignInContinue => '登录以继续';

  @override
  String get profileName => 'Alex Robinson';

  @override
  String profilePointsProgress(String total, String current) {
    return '$current / $total 分';
  }

  @override
  String get onboardingSlide4Desc => '当达到您的目标价格时收到通知并迅速采取行动。';

  @override
  String get profileLogout => '退出';

  @override
  String get profileGoldStatus => '黄金级别';

  @override
  String get registerSuccessTitle => '注册成功';

  @override
  String get profilePaymentMethods => '付款方式';

  @override
  String get profileNotificationsSubtitle => '交易提醒和应用程序更新';

  @override
  String get profileCashbackBalance => '现金返还余额';

  @override
  String get onboardingSlide2Title => '真伪检查';

  @override
  String profileNextReward(String amount) {
    return '下一个奖励：$amount';
  }

  @override
  String get authEmailInvalid => '输入有效的电子邮件';

  @override
  String get authEmailRequired => '电子邮件为必填项';

  @override
  String get authPasswordRequired => '需要密码';

  @override
  String get authFullNameRequired => '需要全名';

  @override
  String get registerAlreadyHaveAccount => '已有账户？登录';

  @override
  String get onboardingSlide3Title => '评论与见解';

  @override
  String get profileSecuritySubtitle => '生物识别和密码';

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
  String get aiChatNewChat => '新聊天';

  @override
  String get aiChatHistory => '聊天';

  @override
  String get aiChatRenameChat => '重命名聊天';

  @override
  String get aiChatDeleteChat => '删除聊天';

  @override
  String get aiChatRenameTitle => '重命名聊天';

  @override
  String get aiChatRenameHint => '聊天名称';

  @override
  String get aiChatRenameSave => '保存名称';

  @override
  String get aiChatDeleteTitle => '删除聊天？';

  @override
  String get aiChatDeleteBody => '这会从历史记录中移除该聊天。你随时可以开始新的聊天。';

  @override
  String get aiChatDeleteConfirm => '删除聊天';

  @override
  String get aiChatActionFailed => '无法更新此聊天。请重试。';

  @override
  String get aiChatManualActions => '手动工具';

  @override
  String get aiChatAddToChat => '添加到聊天';

  @override
  String get aiChatAttachBarcode => '扫码';

  @override
  String get aiChatAttachImage => '图片搜索';

  @override
  String get aiChatEmptyNameFallback => '朋友';

  @override
  String aiChatEmptyTitle(String name) {
    return '$name，今天想买什么？';
  }

  @override
  String get aiChatEmptySubtitle => '我准备好了。';

  @override
  String get aiChatErrorReply =>
      'Temporary AI issue. Please retry, or share your budget, country, and top priorities so I can guide you safely.';

  @override
  String get aiChatInputHint => '写给 Dealio...';

  @override
  String get aiChatThinkingAnalyzing => '正在分析你的需求';

  @override
  String get aiChatThinkingSearching => '正在搜索可信店铺';

  @override
  String get aiChatThinkingPricing => '正在检查价格信号';

  @override
  String get aiChatThinkingRanking => '正在排序最佳选项';

  @override
  String get aiChatEmptyHintPrefix => '试试';

  @override
  String get aiChatEmptyHintCamera => '帮我找一款 900 美元以内、相机强的手机';

  @override
  String get aiChatEmptyHintBudget => '按我的预算比较可信店铺';

  @override
  String get aiChatEmptyHintAlert => '这个商品降价时提醒我';

  @override
  String get aiAgentActionNeeds => '询问需求';

  @override
  String get aiAgentActionResults => '最佳结果';

  @override
  String get aiAgentActionAlert => '价格提醒';

  @override
  String get aiAgentActionAdvice => '建议';

  @override
  String get aiAgentActionCompare => '比较店铺';

  @override
  String get aiAgentFeedbackHelpful => '有帮助';

  @override
  String get aiAgentFeedbackImprove => '改进';

  @override
  String get aiAgentFeedbackSaved => '反馈已收到';

  @override
  String get aiAgentFeedbackHelpfulThanks => '谢谢，信号已收到。';

  @override
  String get aiAgentFeedbackImproveThanks => '收到，我会调整下一次回答。';

  @override
  String get aiAgentPromptNeeds => '在推荐商品前，请问我 3 个简短问题，了解我的需求、预算、国家/地区和优先级。';

  @override
  String get aiAgentPromptResults => '用简洁排名展示最佳商品选项，包括价格、可信度、优点、缺点和最安全的下一步。';

  @override
  String get aiAgentPromptAdvice => '给我一个简短购买建议：该选什么、避开什么，以及原因。';

  @override
  String get aiAgentPromptCompareStores => '按价格、配送、退货政策、真伪和风险比较这个商品的可信店铺。';

  @override
  String get aiStructuredDecision => 'DEALIO 决策';

  @override
  String get aiStructuredBestMatches => '最佳匹配';

  @override
  String get aiStructuredQuestions => '问题';

  @override
  String get aiStructuredPriceWatch => '价格跟踪';

  @override
  String get aiStructuredPriceWatchSubtitle => '我可以跟踪这个价格，并在更适合买入时提醒你。';

  @override
  String get aiStructuredStartAlert => '跟踪';

  @override
  String get aiAgentAlertTitle => '要跟踪这个价格吗？';

  @override
  String get aiAgentAlertSubtitle => 'Dealio 会检查最新价格，并在达到目标价时提醒你。';

  @override
  String get aiAgentAlertLoading => '正在检查最新价格...';

  @override
  String get aiAgentAlertQuoteUnavailable => '暂时无法可靠读取价格。请粘贴商品链接，或使用高级设置。';

  @override
  String get aiAgentAlertPasteLink => '粘贴商品链接，Dealio 就能跟踪它。';

  @override
  String get aiAgentAlertLinkHint => 'https://store.com/product...';

  @override
  String get aiAgentAlertCheckLink => '检查链接';

  @override
  String get aiAgentAlertCreate => '创建提醒';

  @override
  String get aiAgentAlertAdvanced => '高级设置';

  @override
  String get aiAgentAlertSelectedProduct => '已选商品';

  @override
  String get aiAgentAlertCurrent => '当前';

  @override
  String get aiAgentAlertTarget => '目标';

  @override
  String get aiAgentAlertAnyStore => '任意可信店铺';

  @override
  String aiAgentAlertStoreScope(String store) {
    return '跟踪范围：$store';
  }

  @override
  String get aiAgentAlertPriceUnknown => '未知';

  @override
  String get aiAgentAlertNeedProduct => '需要商品或店铺链接才能创建此提醒。';

  @override
  String get aiAgentAlertCreatedMessage => '价格跟踪已开启。达到目标价时我会提醒你。';

  @override
  String aiAgentSearchResults(String query, int count) {
    return '我为“$query”找到了 $count 个强匹配结果。';
  }

  @override
  String aiAgentSearchNoResults(String query) {
    return '暂时没有为“$query”找到强匹配商品。可以补充预算、国家或偏好的店铺。';
  }

  @override
  String get aiAgentSearchFailed => 'Agent 搜索暂时不可用。我仍然可以帮你优化搜索需求。';

  @override
  String aiStructuredMatchScore(int score) {
    return '$score% 匹配';
  }

  @override
  String get aiChatUserLabel => 'You';

  @override
  String get aiChatAssistantLabel => 'Dealio AI';

  @override
  String get searchHistoryEmpty => '??????????';

  @override
  String get searchHeaderTitle => 'Dealio Search';

  @override
  String searchQuotaCompact(String plan, int remaining) {
    return '$plan • ?? $remaining';
  }

  @override
  String searchQuotaUnlimitedCompact(String plan) {
    return '$plan • ???';
  }

  @override
  String get searchInputLabel => '??';

  @override
  String get searchButtonLabel => '??';

  @override
  String get searchAiNeedsTitle => 'Dealio AI';

  @override
  String get searchAiNeedsSubtitle => '??????? Dealio?';

  @override
  String get searchAiNeedsHint => '??????????????900 ????...';

  @override
  String get searchNeedChipCamera => '??';

  @override
  String get searchNeedChipBattery => '??';

  @override
  String get searchNeedChipBudget => '900 ????';

  @override
  String get searchNeedChipDurable => '??';

  @override
  String get searchRecentTitle => '????';

  @override
  String get searchFiltersTitle => '??';

  @override
  String get searchFiltersSubtitle => '????????';

  @override
  String get searchFiltersButton => '??';

  @override
  String get searchFiltersApply => '????';

  @override
  String get searchFiltersClearStores => '????';

  @override
  String get searchBudgetLabel => '??';

  @override
  String get searchBudgetActive => '????';

  @override
  String get searchBudgetHint => '??????';

  @override
  String get searchBudgetInvalid => '???????';

  @override
  String get searchCountryLabel => '??';

  @override
  String get searchStoresLabel => '??????????';

  @override
  String get searchAdvancedTitle => '??';

  @override
  String get searchGlobalScope => '????';

  @override
  String searchSelectedScope(int count) {
    return '?? $count ???';
  }

  @override
  String searchHistoryStores(int count) {
    return '$count ???';
  }

  @override
  String get searchHistoryContext => '???';

  @override
  String get searchCountryFallback => '??';
}
