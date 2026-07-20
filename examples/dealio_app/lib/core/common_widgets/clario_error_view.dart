import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:untitled5/core/theme/app_colors.dart';

enum ClarioErrorType { offline, server }

class ClarioErrorView extends StatelessWidget {
  final ClarioErrorType type;
  final VoidCallback onRetry;

  const ClarioErrorView({super.key, required this.type, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final String message = type == ClarioErrorType.offline
        ? "No internet connection.\nPlease check again."
        : "Something went wrong.\nPlease try again later.";

    final IconData icon = type == ClarioErrorType.offline
        ? Iconsax.wifi_square
        : Iconsax.danger;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color:
                    (type == ClarioErrorType.offline
                            ? AppColors.cobalt
                            : Colors.redAccent)
                        .withValues(alpha: 0.1),
              ),
              child: Icon(
                icon,
                size: 64,
                color: type == ClarioErrorType.offline
                    ? AppColors.cobalt
                    : Colors.redAccent,
              ),
            ),
            const SizedBox(height: 32),
            Text(
              message,
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w500,
                height: 1.5,
                color: isDark
                    ? AppColors.darkTextPrimary
                    : AppColors.lightTextPrimary,
              ),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: onRetry,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.cobalt,
                foregroundColor: Colors.white,
                minimumSize: const Size(160, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 0,
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Iconsax.refresh, size: 18),
                  SizedBox(width: 12),
                  Text("Retry", style: TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
