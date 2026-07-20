import 'package:flutter/material.dart';
import 'package:untitled5/core/theme/app_colors.dart';

class GradientGlowButton extends StatefulWidget {
  final String label;
  final VoidCallback? onTap;
  final IconData? icon;
  final double height;

  const GradientGlowButton({
    super.key,
    required this.label,
    required this.onTap,
    this.icon,
    this.height = 52,
  });

  @override
  State<GradientGlowButton> createState() => _GradientGlowButtonState();
}

class _GradientGlowButtonState extends State<GradientGlowButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final disabled = widget.onTap == null;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          height: widget.height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            gradient: disabled
                ? LinearGradient(
                    colors: [
                      AppColors.muted.withValues(alpha: 0.55),
                      AppColors.muted.withValues(alpha: 0.45),
                    ],
                  )
                : LinearGradient(
                    colors: isDark
                        ? const [
                            Color(0xFFEAEAEA),
                            Color(0xFFBCBCBC),
                            Color(0xFF9A9A9A),
                          ]
                        : const [
                            Color(0xFF1A1A1A),
                            Color(0xFF333333),
                            Color(0xFF4D4D4D),
                          ],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
            boxShadow: disabled
                ? const []
                : [
                    BoxShadow(
                      color: isDark
                          ? Colors.white.withValues(alpha: _hovered ? 0.18 : 0.12)
                          : Colors.black.withValues(alpha: _hovered ? 0.24 : 0.16),
                      blurRadius: _hovered ? 24 : 16,
                      offset: const Offset(0, 8),
                    ),
                  ],
          ),
          child: Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (widget.icon != null) ...[
                  Icon(
                    widget.icon,
                    color: isDark ? const Color(0xFF121212) : Colors.white,
                    size: 18,
                  ),
                  const SizedBox(width: 8),
                ],
                Text(
                  widget.label,
                  style: TextStyle(
                    color: isDark ? const Color(0xFF121212) : Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 15,
                    letterSpacing: -0.1,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
