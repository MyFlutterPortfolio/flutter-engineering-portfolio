import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:iconsax/iconsax.dart';
import 'package:untitled5/core/theme/app_colors.dart';

import '../providers/search_state.dart';

class SearchProgressHeader extends StatelessWidget {
  final SearchStatus status;
  final bool stage2Error;
  final bool stage3Error;

  const SearchProgressHeader({
    super.key,
    required this.status,
    this.stage2Error = false,
    this.stage3Error = false,
  });

  @override
  Widget build(BuildContext context) {
    if (status == SearchStatus.idle ||
        status == SearchStatus.error ||
        status == SearchStatus.quotaExceeded) {
      return const SizedBox.shrink();
    }

    final isDone = status == SearchStatus.stage3Ready;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      decoration: BoxDecoration(
        color: AppColors.adaptiveSurfaceColor(context, darkAlpha: 0.88),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.1)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              _StageIndicator(
                label: 'Sourcing',
                icon: Iconsax.search_status,
                isActive: _isAtLeast(SearchStatus.loadingStage1),
                isCurrent: status == SearchStatus.loadingStage1,
              ),
              _StageDivider(isActive: _isAtLeast(SearchStatus.stage1Ready)),
              _StageIndicator(
                label: 'Enriching',
                icon: Iconsax.cloud_add,
                isActive: _isAtLeast(SearchStatus.stage1Ready),
                isCurrent: status == SearchStatus.stage1Ready,
                hasError: stage2Error,
              ),
              _StageDivider(isActive: _isAtLeast(SearchStatus.stage2Ready)),
              _StageIndicator(
                label: 'AI Analysis',
                icon: Iconsax.cpu,
                isActive: _isAtLeast(SearchStatus.stage2Ready),
                isCurrent: status == SearchStatus.stage2Ready,
                hasError: stage3Error,
              ),
            ],
          ),
          if (!isDone && !stage2Error && !stage3Error)
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(2),
                child: LinearProgressIndicator(
                  backgroundColor: AppColors.adaptiveCardColor(
                    context,
                    darkAlpha: 0.85,
                  ),
                  valueColor: const AlwaysStoppedAnimation(AppColors.primary),
                  minHeight: 2,
                ),
              ),
            ),
          if (stage2Error || stage3Error)
            Padding(
              padding: const EdgeInsets.only(top: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Iconsax.warning_2,
                    size: 14,
                    color: AppColors.warning,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    stage3Error
                        ? 'AI analysis partially unavailable'
                        : 'Price enrichment incomplete',
                    style: const TextStyle(
                      fontSize: 11,
                      color: AppColors.warning,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ).animate().fadeIn().shake(),
        ],
      ),
    );
  }

  bool _isAtLeast(SearchStatus requiredStatus) {
    return status.index >= requiredStatus.index;
  }
}

class _StageIndicator extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isActive;
  final bool isCurrent;
  final bool hasError;

  const _StageIndicator({
    required this.label,
    required this.icon,
    required this.isActive,
    required this.isCurrent,
    this.hasError = false,
  });

  @override
  Widget build(BuildContext context) {
    final mutedColor = AppColors.onMuted(context);
    final activeColor = hasError ? AppColors.warning : AppColors.primary;
    final color = isActive ? activeColor : mutedColor.withValues(alpha: 0.3);

    return Expanded(
      child: Column(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isCurrent
                  ? AppColors.primary.withValues(alpha: 0.1)
                  : Colors.transparent,
              border: Border.all(
                color: isCurrent ? AppColors.primary : color,
                width: isCurrent ? 2 : 1.5,
              ),
            ),
            child: Center(
              child: isCurrent
                  ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: AppColors.primary,
                      ),
                    )
                  : Icon(
                      hasError
                          ? Iconsax.danger
                          : (isActive ? Iconsax.tick_circle : icon),
                      size: 18,
                      color: color,
                    ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w900,
              color: isCurrent ? AppColors.primary : color,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }
}

class _StageDivider extends StatelessWidget {
  final bool isActive;
  const _StageDivider({required this.isActive});

  @override
  Widget build(BuildContext context) {
    final mutedColor = AppColors.onMuted(context);
    return Container(
      width: 30,
      height: 1,
      margin: const EdgeInsets.only(bottom: 24),
      color: isActive
          ? AppColors.primary.withValues(alpha: 0.5)
          : mutedColor.withValues(alpha: 0.1),
    );
  }
}
