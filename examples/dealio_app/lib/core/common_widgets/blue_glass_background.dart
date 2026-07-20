import 'package:flutter/material.dart';
import 'package:untitled5/core/config/app_flags.dart';
import 'package:untitled5/core/theme/app_colors.dart';

class BlueGlassBackground extends StatelessWidget {
  final Widget child;

  const BlueGlassBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final isDark = AppColors.isDark(context);
    final background = BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: isDark
            ? const [Color(0xFF050B14), Color(0xFF08172B), Color(0xFF05070C)]
            : const [Color(0xFFF7FAFF), Color(0xFFEAF1FF), Color(0xFFF7F9FC)],
      ),
    );

    if (AppFlags.reduceExpensiveVisualEffects) {
      return DecoratedBox(decoration: background, child: child);
    }

    return RepaintBoundary(
      child: Stack(
        children: [
          Positioned.fill(child: DecoratedBox(decoration: background)),
          Positioned.fill(child: _PremiumBluePulse(isDark: isDark)),
          Positioned(
            top: -130,
            right: -90,
            child: _GlowOrb(
              size: 290,
              color: AppColors.primary.withValues(alpha: isDark ? 0.22 : 0.12),
            ),
          ),
          Positioned(
            left: -150,
            bottom: 120,
            child: _GlowOrb(
              size: 330,
              color: AppColors.success.withValues(alpha: isDark ? 0.08 : 0.05),
            ),
          ),
          Positioned.fill(
            child: IgnorePointer(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.white.withValues(alpha: isDark ? 0.02 : 0.12),
                      Colors.transparent,
                      Colors.black.withValues(alpha: isDark ? 0.14 : 0.04),
                    ],
                    stops: const [0.0, 0.42, 1.0],
                  ),
                ),
              ),
            ),
          ),
          Positioned.fill(
            child: IgnorePointer(
              child: CustomPaint(
                painter: _BackgroundLinesPainter(isDark: isDark),
              ),
            ),
          ),
          child,
        ],
      ),
    );
  }
}

class _PremiumBluePulse extends StatefulWidget {
  final bool isDark;

  const _PremiumBluePulse({required this.isDark});

  @override
  State<_PremiumBluePulse> createState() => _PremiumBluePulseState();
}

class _PremiumBluePulseState extends State<_PremiumBluePulse>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3600),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          final pulse = Curves.easeInOutCubic.transform(_controller.value);
          final opacity = widget.isDark ? 0.10 + pulse * 0.055 : 0.06;

          return Stack(
            children: <Widget>[
              Positioned(
                top: 86 + pulse * 18,
                left: 54,
                right: 54,
                child: Opacity(
                  opacity: opacity,
                  child: Transform.scale(
                    scale: 0.94 + pulse * 0.10,
                    child: Container(
                      height: 230,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(999),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.primary.withValues(alpha: 0.95),
                            blurRadius: 96,
                            spreadRadius: 18,
                          ),
                          BoxShadow(
                            color: AppColors.accent.withValues(alpha: 0.55),
                            blurRadius: 58,
                            spreadRadius: 6,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _GlowOrb extends StatelessWidget {
  final double size;
  final Color color;

  const _GlowOrb({required this.size, required this.color});

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: color,
              blurRadius: size * 0.36,
              spreadRadius: size * 0.08,
            ),
          ],
        ),
      ),
    );
  }
}

class _BackgroundLinesPainter extends CustomPainter {
  final bool isDark;

  const _BackgroundLinesPainter({required this.isDark});

  @override
  void paint(Canvas canvas, Size size) {
    final blue = Paint()
      ..color = AppColors.primary.withValues(alpha: isDark ? 0.10 : 0.08)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2;
    final teal = Paint()
      ..color = AppColors.success.withValues(alpha: isDark ? 0.07 : 0.04)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    final topPath = Path()
      ..moveTo(-24, size.height * 0.18)
      ..cubicTo(
        size.width * 0.20,
        size.height * 0.06,
        size.width * 0.45,
        size.height * 0.08,
        size.width * 0.65,
        size.height * 0.15,
      )
      ..cubicTo(
        size.width * 0.84,
        size.height * 0.22,
        size.width * 0.93,
        size.height * 0.16,
        size.width + 26,
        size.height * 0.10,
      );
    canvas.drawPath(topPath, blue);

    final bottomPath = Path()
      ..moveTo(-18, size.height * 0.84)
      ..cubicTo(
        size.width * 0.22,
        size.height * 0.76,
        size.width * 0.44,
        size.height * 0.77,
        size.width * 0.66,
        size.height * 0.84,
      )
      ..cubicTo(
        size.width * 0.84,
        size.height * 0.90,
        size.width * 0.95,
        size.height * 0.82,
        size.width + 22,
        size.height * 0.76,
      );
    canvas.drawPath(bottomPath, teal);
  }

  @override
  bool shouldRepaint(covariant _BackgroundLinesPainter oldDelegate) {
    return oldDelegate.isDark != isDark;
  }
}
