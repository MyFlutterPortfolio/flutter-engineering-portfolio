import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';
import 'package:untitled5/core/common_widgets/error_banner.dart';
import 'package:untitled5/core/responsive/responsive_layout.dart';
import 'package:untitled5/core/theme/app_colors.dart';
import 'package:untitled5/features/image_analysis/domain/entities/image_analysis_result.dart';
import 'package:untitled5/features/image_analysis/presentation/providers/image_analysis_provider.dart';
import 'package:untitled5/features/image_analysis/presentation/widgets/image_result_card.dart';

class ImageAnalysisScreen extends ConsumerStatefulWidget {
  const ImageAnalysisScreen({super.key});

  @override
  ConsumerState<ImageAnalysisScreen> createState() =>
      _ImageAnalysisScreenState();
}

class _ImageAnalysisScreenState extends ConsumerState<ImageAnalysisScreen> {
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage(ImageSource source) async {
    final XFile? image = await _picker.pickImage(
      source: source,
      imageQuality: 80,
      maxWidth: 1024,
    );

    if (image != null) {
      ref.read(imageAnalysisProvider.notifier).analyzeImage(File(image.path));
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(imageAnalysisProvider);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('AI Image Analysis'),
        actions: [
          if (state.status == ImageAnalysisStatus.success)
            IconButton(
              icon: const Icon(Iconsax.refresh),
              onPressed: () => ref.read(imageAnalysisProvider.notifier).reset(),
            ),
        ],
      ),
      body: ResponsivePageFrame(
        child: SingleChildScrollView(
          padding: context.responsivePagePadding(top: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (state.status == ImageAnalysisStatus.idle) ...[
                _buildUploadPlaceholder(theme),
              ] else if (state.status == ImageAnalysisStatus.loading) ...[
                _buildLoadingState(theme, state),
              ] else if (state.status == ImageAnalysisStatus.error) ...[
                if (state.selectedImage != null)
                  _buildImagePreview(state.selectedImage!),
                const SizedBox(height: 16),
                ErrorBanner(
                  message: state.errorMessage ?? 'An error occurred',
                  onRetry: state.selectedImage != null
                      ? () => ref
                            .read(imageAnalysisProvider.notifier)
                            .analyzeImage(state.selectedImage!)
                      : null,
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () =>
                      ref.read(imageAnalysisProvider.notifier).reset(),
                  child: const Text('Try Another Image'),
                ),
              ] else if (state.status == ImageAnalysisStatus.success &&
                  state.result != null) ...[
                if (state.selectedImage != null)
                  _buildImagePreview(state.selectedImage!),
                const SizedBox(height: 24),
                ImageResultCard(result: state.result!),
                const SizedBox(height: 16),
                _buildUseInSearchButton(state.result!),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUploadPlaceholder(ThemeData theme) {
    return Column(
      children: [
        const SizedBox(height: 40),
        Icon(
          Iconsax.image,
          size: 80,
          color: theme.hintColor.withValues(alpha: 0.3),
        ),
        const SizedBox(height: 24),
        Text(
          'Analyze product with AI',
          style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 12),
        Text(
          'Take a photo or upload from gallery to identify\nproducts and get detailed insights.',
          style: theme.textTheme.bodyMedium?.copyWith(color: theme.hintColor),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 48),
        _buildSourceButton(
          icon: Iconsax.camera,
          label: 'Take a Photo',
          onTap: () => _pickImage(ImageSource.camera),
          isPrimary: true,
        ),
        const SizedBox(height: 16),
        _buildSourceButton(
          icon: Iconsax.gallery,
          label: 'Upload from Gallery',
          onTap: () => _pickImage(ImageSource.gallery),
          isPrimary: false,
        ),
      ],
    );
  }

  Widget _buildSourceButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    required bool isPrimary,
  }) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: isPrimary ? AppColors.cobalt : Colors.transparent,
        foregroundColor: isPrimary ? Colors.white : AppColors.cobalt,
        side: isPrimary
            ? BorderSide.none
            : const BorderSide(color: AppColors.cobalt),
        minimumSize: const Size(double.infinity, 56),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 20),
          const SizedBox(width: 12),
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingState(ThemeData theme, ImageAnalysisState state) {
    return Column(
      children: [
        if (state.selectedImage != null)
          _buildImagePreview(state.selectedImage!),
        const SizedBox(height: 40),
        const CircularProgressIndicator(color: AppColors.cobalt),
        const SizedBox(height: 24),
        Text(
          'Analyzing Image...',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Our AI is identifying the product and extracting features.',
          style: theme.textTheme.bodySmall?.copyWith(color: theme.hintColor),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildImagePreview(File file) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Image.file(
        file,
        height: 250,
        width: double.infinity,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _buildUseInSearchButton(ImageAnalysisResult result) {
    final query = _extractSearchQuery(result);
    if (query.isEmpty) return const SizedBox.shrink();

    return OutlinedButton.icon(
      onPressed: () => Navigator.of(context).pop(query),
      icon: const Icon(Iconsax.search_normal_1, size: 18),
      label: Text('Use "$query" in Search'),
      style: OutlinedButton.styleFrom(
        minimumSize: const Size(double.infinity, 52),
        foregroundColor: AppColors.cobalt,
        side: const BorderSide(color: AppColors.cobalt),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      ),
    );
  }

  String _extractSearchQuery(ImageAnalysisResult result) {
    final title = result.productTitle.trim();
    if (title.isNotEmpty) return title;

    final detected = result.detectedProduct.trim();
    if (detected.isNotEmpty) return detected;

    return '';
  }
}
