import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:untitled5/core/common_widgets/glass_container.dart';
import 'package:untitled5/core/localization/app_language.dart';
import 'package:untitled5/core/models/clario_models.dart';
import 'package:untitled5/core/providers/language_provider.dart';
import 'package:untitled5/core/theme/app_colors.dart';
import 'package:untitled5/core/utils/plan_guard.dart';
import 'package:untitled5/core/utils/safe_url_launcher.dart';
import 'package:untitled5/features/product/presentation/providers/product_provider.dart';

class ClarioAIAnalysisScreen extends ConsumerStatefulWidget {
  const ClarioAIAnalysisScreen({super.key});

  @override
  ConsumerState<ClarioAIAnalysisScreen> createState() =>
      _ClarioAIAnalysisScreenState();
}

class _ClarioAIAnalysisScreenState
    extends ConsumerState<ClarioAIAnalysisScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _linkController = TextEditingController();

  final List<String> _links = [];
  String _budget = 'medium';
  final List<String> _selectedNeeds = [];
  String _language = 'en';

  final List<String> _needsOptions = [
    'camera',
    'battery',
    'performance',
    'gaming',
    'display',
    'design',
  ];

  @override
  void initState() {
    super.initState();
    _language = ref.read(appLanguageProvider).code;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _linkController.dispose();
    super.dispose();
  }

  void _showInfo(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  void _addLink() {
    final raw = _linkController.text.trim();
    if (raw.isEmpty) return;

    final normalized =
        raw.startsWith(RegExp(r'https?://', caseSensitive: false))
        ? raw
        : 'https://$raw';
    final uri = parseExternalWebUri(normalized);

    if (uri == null) {
      _showInfo('Invalid link format.');
      return;
    }

    final link = uri.toString();
    if (_links.contains(link)) {
      _showInfo('This link is already added.');
      return;
    }

    if (_links.length >= 5) {
      _showInfo('You can add up to 5 product links.');
      return;
    }

    setState(() {
      _links.add(link);
      _linkController.clear();
    });
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    final request = ClarioAnalyzeRequest(
      productName: _nameController.text.trim(),
      productLinks: _links,
      userPreferences: UserPreferences(budget: _budget, needs: _selectedNeeds),
      selectedLanguage: _language,
    );

    try {
      await ref.read(clarioAnalysisProvider.notifier).analyze(request);
      if (!mounted) return;
      _showInfo('Analysis completed.');
    } catch (e) {
      if (e == 'SUBSCRIPTION_REQUIRED') {
        if (!mounted) return;
        context.push('/subscription');
        return;
      }
      _showInfo(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    final planGuard = ref.watch(planGuardProvider);
    final hasAccess = planGuard.canUseAiAnalysis;

    return Scaffold(
      appBar: AppBar(title: const Text('Direct Product Link AI Mode')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (!hasAccess) _buildPaywallCTA(),
              const SizedBox(height: 20),
              _buildNameField(),
              const SizedBox(height: 20),
              _buildLinksSection(hasAccess),
              const SizedBox(height: 20),
              _buildPreferencesSection(),
              const SizedBox(height: 40),
              _buildSubmitButton(hasAccess),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPaywallCTA() {
    return GlassContainer(
      color: Colors.orange.withValues(alpha: 0.1),
      child: Column(
        children: [
          const Icon(Iconsax.lock, color: Colors.orange, size: 40),
          const SizedBox(height: 12),
          const Text(
            'PRO/PLUS Feature',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          const SizedBox(height: 6),
          const Text(
            'Upgrade your plan to run direct product-link AI analysis.',
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () => context.push('/subscription'),
            child: const Text('Upgrade Now'),
          ),
        ],
      ),
    );
  }

  Widget _buildNameField() {
    return TextFormField(
      controller: _nameController,
      decoration: const InputDecoration(
        labelText: 'Product Name *',
        hintText: 'Example: iPhone 13 128GB',
        prefixIcon: Icon(Iconsax.box),
      ),
      validator: (v) =>
          (v == null || v.trim().isEmpty) ? 'Product name is required' : null,
    );
  }

  Widget _buildLinksSection(bool hasAccess) {
    return Opacity(
      opacity: hasAccess ? 1 : 0.5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Product Links (max 5)',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _linkController,
                  enabled: hasAccess && _links.length < 5,
                  decoration: const InputDecoration(
                    hintText: 'amazon.com/product/...',
                  ),
                ),
              ),
              const SizedBox(width: 8),
              IconButton(
                onPressed: hasAccess ? _addLink : null,
                icon: const Icon(Icons.add_circle, color: AppColors.cobalt),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: _links
                .map(
                  (link) => Chip(
                    label: Text(
                      Uri.parse(link).host,
                      style: const TextStyle(fontSize: 12),
                    ),
                    onDeleted: () => setState(() => _links.remove(link)),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildPreferencesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Preferences',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        DropdownButtonFormField<String>(
          initialValue: _budget,
          items: ['low', 'medium', 'high']
              .map(
                (b) => DropdownMenuItem(value: b, child: Text(b.toUpperCase())),
              )
              .toList(),
          onChanged: (v) => setState(() => _budget = v ?? 'medium'),
          decoration: const InputDecoration(labelText: 'Budget'),
        ),
        const SizedBox(height: 16),
        const Text('Needs'),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: _needsOptions.map((need) {
            final isSelected = _selectedNeeds.contains(need);
            return FilterChip(
              label: Text(need),
              selected: isSelected,
              onSelected: (val) {
                setState(() {
                  if (val) {
                    _selectedNeeds.add(need);
                  } else {
                    _selectedNeeds.remove(need);
                  }
                });
              },
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildSubmitButton(bool hasAccess) {
    final analysisState = ref.watch(clarioAnalysisProvider);
    final isLoading = analysisState is AsyncLoading;

    return ElevatedButton(
      onPressed: (hasAccess && !isLoading) ? _submit : null,
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(double.infinity, 56),
        backgroundColor: AppColors.cobalt,
      ),
      child: isLoading
          ? const CircularProgressIndicator(color: Colors.white)
          : const Text(
              'Run AI Analysis',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
    );
  }
}
