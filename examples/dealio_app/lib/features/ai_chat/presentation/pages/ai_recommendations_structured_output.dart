part of 'ai_recommendations_screen.dart';

class _AgentStructuredOutput {
  final String? decision;
  final List<_AgentProductCandidate> products;
  final List<String> questions;
  final bool wantsPriceAlert;

  const _AgentStructuredOutput({
    required this.decision,
    required this.products,
    required this.questions,
    required this.wantsPriceAlert,
  });

  bool get hasContent =>
      decision != null ||
      products.isNotEmpty ||
      questions.isNotEmpty ||
      wantsPriceAlert;

  static _AgentStructuredOutput fromMessage({
    required ChatMessage message,
    required String userPrompt,
  }) {
    final metadata = message.metadata;
    final products = _extractProducts(metadata);
    final questions = _extractQuestions(message.text);
    final wantsPriceAlert = _wantsPriceAlert(
      metadata: metadata,
      userPrompt: userPrompt,
      assistantText: message.text,
      hasSources: message.sources.isNotEmpty,
    );
    final decision = _extractDecision(
      metadata: metadata,
      assistantText: message.text,
      userPrompt: userPrompt,
      hasStructuredContent:
          products.isNotEmpty || questions.isNotEmpty || wantsPriceAlert,
    );

    return _AgentStructuredOutput(
      decision: decision,
      products: products,
      questions: questions,
      wantsPriceAlert: wantsPriceAlert,
    );
  }

  static List<_AgentProductCandidate> _extractProducts(
    Map<String, dynamic> metadata,
  ) {
    final raw =
        metadata['products'] ??
        metadata['results'] ??
        metadata['items'] ??
        metadata['recommendations'];
    if (raw is! List) return const <_AgentProductCandidate>[];

    return raw
        .whereType<Map>()
        .map((item) {
          final map = Map<String, dynamic>.from(item);
          final title = _readString(map, const [
            'title',
            'name',
            'productTitle',
            'product_name',
          ]);
          if (title == null) return null;

          final priceText =
              _readString(map, const [
                'priceText',
                'price_text',
                'displayPrice',
              ]) ??
              _formatPrice(
                map['price'] ?? map['currentPrice'],
                map['currency'],
              );
          final price = _readDouble(map['price'] ?? map['currentPrice']);
          final currency = _readString(map, const ['currency']) ?? 'USD';
          final rawProductId = _readString(map, const [
            'productId',
            'id',
            'sku',
          ]);
          final isSyntheticId = _readBool(map['isSyntheticId']);

          return _AgentProductCandidate(
            productId: isSyntheticId ? null : rawProductId,
            title: title,
            store: _readString(map, const ['store', 'storeName', 'merchant']),
            priceText: priceText,
            price: price,
            currency: currency,
            link: _readString(map, const ['link', 'url', 'productUrl']),
            imageUrl: _readString(map, const [
              'imageUrl',
              'image',
              'thumbnail',
            ]),
            score: _readScore(
              map['score'] ?? map['fitScore'] ?? map['confidence'],
            ),
            reason: _readString(map, const ['reason', 'why', 'summary']),
          );
        })
        .whereType<_AgentProductCandidate>()
        .take(2)
        .toList(growable: false);
  }

  static String? _extractDecision({
    required Map<String, dynamic> metadata,
    required String assistantText,
    required String userPrompt,
    required bool hasStructuredContent,
  }) {
    final fromMetadata = _readString(metadata, const [
      'recommendation',
      'decision',
      'summary',
      'advice',
    ]);
    if (fromMetadata != null) return _limit(fromMetadata, 150);
    if (!hasStructuredContent || !_hasShoppingIntent(userPrompt)) return null;

    final firstSentence = assistantText
        .split(RegExp(r'(?<=[.!?])\s+'))
        .map((part) => part.trim())
        .firstWhere((part) => part.length >= 24, orElse: () => '');
    if (firstSentence.isEmpty) return null;
    return _limit(firstSentence, 150);
  }

  static List<String> _extractQuestions(String text) {
    final candidates = text
        .split(RegExp(r'[\n\r]+'))
        .map((line) => line.trim())
        .where((line) => line.contains('?'))
        .map((line) => line.replaceFirst(RegExp(r'^[-вЂў\d.)\s]+'), '').trim())
        .where((line) => line.length >= 8 && line.length <= 140)
        .toSet()
        .take(3)
        .toList(growable: false);
    return candidates;
  }

  static bool _wantsPriceAlert({
    required Map<String, dynamic> metadata,
    required String userPrompt,
    required String assistantText,
    required bool hasSources,
  }) {
    final explicit = metadata['priceAlert'] ?? metadata['alertSuggestion'];
    if (explicit is bool) return explicit;

    final text = '${userPrompt.toLowerCase()} ${assistantText.toLowerCase()}';
    return hasSources &&
        (text.contains('price') ||
            text.contains('narx') ||
            text.contains('alert') ||
            text.contains('drop') ||
            text.contains('deal') ||
            text.contains('discount') ||
            text.contains('cheaper') ||
            text.contains('arzon'));
  }

  static bool _hasShoppingIntent(String text) {
    final normalized = text.toLowerCase();
    return normalized.contains('buy') ||
        normalized.contains('shop') ||
        normalized.contains('product') ||
        normalized.contains('price') ||
        normalized.contains('sotib') ||
        normalized.contains('mahsulot') ||
        normalized.contains('narx') ||
        normalized.contains('tavsiya') ||
        normalized.contains('recommend');
  }

  static String? _readString(Map<String, dynamic> map, List<String> keys) {
    for (final key in keys) {
      final value = map[key]?.toString().trim();
      if (value != null && value.isNotEmpty && value.toLowerCase() != 'null') {
        return value;
      }
    }
    return null;
  }

  static int? _readScore(dynamic value) {
    if (value is num) return value.clamp(0, 100).round();
    final parsed = num.tryParse(value?.toString() ?? '');
    return parsed?.clamp(0, 100).round();
  }

  static double? _readDouble(dynamic value) {
    if (value is num) return value.toDouble();
    return double.tryParse(value?.toString() ?? '');
  }

  static bool _readBool(dynamic value) {
    if (value is bool) return value;
    final normalized = value?.toString().trim().toLowerCase();
    return normalized == 'true' || normalized == '1' || normalized == 'yes';
  }

  static String? _formatPrice(dynamic value, dynamic currency) {
    final number = value is num ? value : num.tryParse(value?.toString() ?? '');
    if (number == null || number <= 0) return null;
    final symbol = (currency?.toString().trim().isNotEmpty ?? false)
        ? currency.toString().trim()
        : r'$';
    return '$symbol${number.toStringAsFixed(number % 1 == 0 ? 0 : 2)}';
  }

  static String _limit(String value, int maxLength) {
    final trimmed = value.trim();
    if (trimmed.length <= maxLength) return trimmed;
    return '${trimmed.substring(0, maxLength - 1).trimRight()}вЂ¦';
  }
}

class _AgentProductCandidate {
  final String? productId;
  final String title;
  final String? store;
  final String? priceText;
  final double? price;
  final String currency;
  final String? link;
  final String? imageUrl;
  final int? score;
  final String? reason;

  const _AgentProductCandidate({
    required this.productId,
    required this.title,
    required this.store,
    required this.priceText,
    required this.price,
    required this.currency,
    required this.link,
    required this.imageUrl,
    required this.score,
    required this.reason,
  });

  bool get canOpen => productId != null || link != null;
  bool get canSave => productId != null;
  bool get canTrack => productId != null || link != null;
  bool get canCompare => productId != null;

  List<DynamicPrice> get dynamicPrices {
    final value = price;
    if (value == null || value <= 0) return const <DynamicPrice>[];
    return <DynamicPrice>[
      DynamicPrice(
        store: store ?? 'Dealio',
        price: value,
        currency: currency,
        link: link ?? '',
      ),
    ];
  }

  Product toProduct() {
    return Product(
      id: productId ?? title,
      title: title,
      imageUrl: imageUrl,
      dynamicPrices: dynamicPrices,
    );
  }
}

class _AgentStructuredOutputView extends StatelessWidget {
  final _AgentStructuredOutput output;
  final ValueChanged<String> onQuickReply;
  final ValueChanged<_AgentProductCandidate> onOpenProduct;
  final ValueChanged<_AgentProductCandidate> onSaveProduct;
  final ValueChanged<_AgentProductCandidate> onTrackProduct;
  final ValueChanged<_AgentProductCandidate> onCompareProduct;
  final VoidCallback onOpenPriceAlert;

  const _AgentStructuredOutputView({
    required this.output,
    required this.onQuickReply,
    required this.onOpenProduct,
    required this.onSaveProduct,
    required this.onTrackProduct,
    required this.onCompareProduct,
    required this.onOpenPriceAlert,
  });

  @override
  Widget build(BuildContext context) {
    return _FrostedSurface(
      borderRadius: 22,
      padding: const EdgeInsets.all(12),
      color: AppColors.adaptiveSurfaceColor(
        context,
        darkAlpha: 0.24,
        lightAlpha: 0.68,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          if (output.decision != null)
            _StructuredDecisionRow(text: output.decision!),
          if (output.products.isNotEmpty) ...[
            if (output.decision != null) const SizedBox(height: 10),
            _StructuredProductBlock(
              products: output.products,
              onOpenProduct: onOpenProduct,
              onSaveProduct: onSaveProduct,
              onTrackProduct: onTrackProduct,
              onCompareProduct: onCompareProduct,
            ),
          ],
          if (output.questions.isNotEmpty) ...[
            if (output.decision != null || output.products.isNotEmpty)
              const SizedBox(height: 10),
            _StructuredQuestionBlock(
              questions: output.questions,
              onQuickReply: onQuickReply,
            ),
          ],
          if (output.wantsPriceAlert) ...[
            if (output.decision != null ||
                output.products.isNotEmpty ||
                output.questions.isNotEmpty)
              const SizedBox(height: 10),
            _StructuredPriceAlertPrompt(onOpenPriceAlert: onOpenPriceAlert),
          ],
        ],
      ),
    );
  }
}

class _StructuredDecisionRow extends StatelessWidget {
  final String text;

  const _StructuredDecisionRow({required this.text});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return _StructuredSection(
      icon: Iconsax.magic_star,
      title: l10n.aiStructuredDecision,
      child: Text(
        text,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
          color: AppColors.onSurface(context),
          fontWeight: FontWeight.w800,
          height: 1.38,
          letterSpacing: -0.05,
        ),
      ),
    );
  }
}

class _StructuredProductBlock extends StatelessWidget {
  final List<_AgentProductCandidate> products;
  final ValueChanged<_AgentProductCandidate> onOpenProduct;
  final ValueChanged<_AgentProductCandidate> onSaveProduct;
  final ValueChanged<_AgentProductCandidate> onTrackProduct;
  final ValueChanged<_AgentProductCandidate> onCompareProduct;

  const _StructuredProductBlock({
    required this.products,
    required this.onOpenProduct,
    required this.onSaveProduct,
    required this.onTrackProduct,
    required this.onCompareProduct,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return _StructuredSection(
      icon: Iconsax.medal_star,
      title: l10n.aiStructuredBestMatches,
      child: Column(
        children: products
            .map(
              (product) => Padding(
                padding: EdgeInsets.only(
                  bottom: product == products.last ? 0 : 8,
                ),
                child: _StructuredProductTile(
                  product: product,
                  onOpenProduct: onOpenProduct,
                  onSaveProduct: onSaveProduct,
                  onTrackProduct: onTrackProduct,
                  onCompareProduct: onCompareProduct,
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}

class _StructuredProductTile extends StatelessWidget {
  final _AgentProductCandidate product;
  final ValueChanged<_AgentProductCandidate> onOpenProduct;
  final ValueChanged<_AgentProductCandidate> onSaveProduct;
  final ValueChanged<_AgentProductCandidate> onTrackProduct;
  final ValueChanged<_AgentProductCandidate> onCompareProduct;

  const _StructuredProductTile({
    required this.product,
    required this.onOpenProduct,
    required this.onSaveProduct,
    required this.onTrackProduct,
    required this.onCompareProduct,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final details = <String>[
      if (product.store != null) product.store!,
      if (product.priceText != null) product.priceText!,
      if (product.score != null) l10n.aiStructuredMatchScore(product.score!),
    ];

    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.055),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.primary.withValues(alpha: 0.08),
          width: 0.6,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            product.title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
              color: AppColors.onSurface(context),
              fontWeight: FontWeight.w900,
              height: 1.18,
            ),
          ),
          if (details.isNotEmpty) ...[
            const SizedBox(height: 5),
            Text(
              details.join(' | '),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.w900,
              ),
            ),
          ],
          if (product.reason != null) ...[
            const SizedBox(height: 6),
            Text(
              product.reason!,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: AppColors.onMuted(context),
                fontWeight: FontWeight.w700,
                height: 1.28,
              ),
            ),
          ],
          const SizedBox(height: 9),
          _StructuredProductActions(
            product: product,
            onOpenProduct: onOpenProduct,
            onSaveProduct: onSaveProduct,
            onTrackProduct: onTrackProduct,
            onCompareProduct: onCompareProduct,
          ),
        ],
      ),
    );
  }
}

class _StructuredProductActions extends StatelessWidget {
  final _AgentProductCandidate product;
  final ValueChanged<_AgentProductCandidate> onOpenProduct;
  final ValueChanged<_AgentProductCandidate> onSaveProduct;
  final ValueChanged<_AgentProductCandidate> onTrackProduct;
  final ValueChanged<_AgentProductCandidate> onCompareProduct;

  const _StructuredProductActions({
    required this.product,
    required this.onOpenProduct,
    required this.onSaveProduct,
    required this.onTrackProduct,
    required this.onCompareProduct,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final actions = <Widget>[
      if (product.canOpen)
        _StructuredProductActionButton(
          icon: Iconsax.eye,
          label: l10n.resultsOpenProductTooltip,
          onTap: () => onOpenProduct(product),
        ),
      if (product.canSave)
        _StructuredProductActionButton(
          icon: Iconsax.heart,
          label: l10n.favoritesSaveTooltip,
          onTap: () => onSaveProduct(product),
        ),
      if (product.canTrack)
        _StructuredProductActionButton(
          icon: Iconsax.notification_bing,
          label: l10n.aiStructuredStartAlert,
          onTap: () => onTrackProduct(product),
        ),
      if (product.canCompare)
        _StructuredProductActionButton(
          icon: Iconsax.shop,
          label: l10n.aiAgentActionCompare,
          onTap: () => onCompareProduct(product),
        ),
    ];

    if (actions.isEmpty) return const SizedBox.shrink();
    return Wrap(spacing: 6, runSpacing: 6, children: actions);
  }
}

class _StructuredProductActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _StructuredProductActionButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(999),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 7),
        decoration: BoxDecoration(
          color: AppColors.adaptiveSurfaceColor(
            context,
            darkAlpha: 0.30,
            lightAlpha: 0.70,
          ),
          borderRadius: BorderRadius.circular(999),
          border: Border.all(
            color: AppColors.primary.withValues(alpha: 0.09),
            width: 0.6,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(icon, color: AppColors.primary, size: 14),
            const SizedBox(width: 5),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 106),
              child: Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: AppColors.onSurface(context),
                  fontWeight: FontWeight.w900,
                  letterSpacing: -0.04,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StructuredQuestionBlock extends StatelessWidget {
  final List<String> questions;
  final ValueChanged<String> onQuickReply;

  const _StructuredQuestionBlock({
    required this.questions,
    required this.onQuickReply,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return _StructuredSection(
      icon: Iconsax.message_question,
      title: l10n.aiStructuredQuestions,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: questions
            .map(
              (question) => Padding(
                padding: EdgeInsets.only(
                  bottom: question == questions.last ? 0 : 6,
                ),
                child: _StructuredQuestionChip(
                  question: question,
                  onTap: () => onQuickReply(question),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}

class _StructuredQuestionChip extends StatelessWidget {
  final String question;
  final VoidCallback onTap;

  const _StructuredQuestionChip({required this.question, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(15),
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 9),
        decoration: BoxDecoration(
          color: AppColors.adaptiveSurfaceColor(
            context,
            darkAlpha: 0.30,
            lightAlpha: 0.72,
          ),
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: AppColors.primary.withValues(alpha: 0.08),
            width: 0.6,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Icon(
              Iconsax.message_text_1,
              color: AppColors.primary,
              size: 15,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                question,
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: AppColors.onSurface(context),
                  fontWeight: FontWeight.w800,
                  height: 1.28,
                ),
              ),
            ),
            const SizedBox(width: 8),
            Icon(
              Iconsax.arrow_right_3,
              color: AppColors.onMuted(context),
              size: 14,
            ),
          ],
        ),
      ),
    );
  }
}

class _StructuredPriceAlertPrompt extends StatelessWidget {
  final VoidCallback onOpenPriceAlert;

  const _StructuredPriceAlertPrompt({required this.onOpenPriceAlert});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return _StructuredSection(
      icon: Iconsax.notification_bing,
      title: l10n.aiStructuredPriceWatch,
      child: Row(
        children: <Widget>[
          Expanded(
            child: Text(
              l10n.aiStructuredPriceWatchSubtitle,
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                color: AppColors.onMuted(context),
                fontWeight: FontWeight.w700,
                height: 1.32,
              ),
            ),
          ),
          const SizedBox(width: 10),
          _MiniPrimaryButton(
            label: l10n.aiStructuredStartAlert,
            onTap: onOpenPriceAlert,
          ),
        ],
      ),
    );
  }
}

class _StructuredSection extends StatelessWidget {
  final IconData icon;
  final String title;
  final Widget child;

  const _StructuredSection({
    required this.icon,
    required this.title,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(icon, color: AppColors.primary, size: 15),
            const SizedBox(width: 6),
            Text(
              title,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: AppColors.onMuted(context),
                fontWeight: FontWeight.w900,
                letterSpacing: 0.55,
              ),
            ),
          ],
        ),
        const SizedBox(height: 7),
        child,
      ],
    );
  }
}

class _MiniPrimaryButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const _MiniPrimaryButton({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(999),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(999),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withValues(alpha: 0.18),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Text(
          label,
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
    );
  }
}
