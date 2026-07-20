import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:untitled5/core/theme/app_colors.dart';

class PriceTrendChart extends StatelessWidget {
  final List<double> points;
  final double height;
  final Color lineColor;
  final Color fillColor;

  const PriceTrendChart({
    super.key,
    required this.points,
    this.height = 110,
    this.lineColor = AppColors.primary,
    this.fillColor = const Color(0x3323C9A9),
  });

  @override
  Widget build(BuildContext context) {
    if (points.length < 2) {
      return Container(
        height: height,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: AppColors.card.withValues(alpha: 0.55),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.primary.withValues(alpha: 0.15)),
        ),
        child: const Text(
          'Trend data collecting...',
          style: TextStyle(
            color: AppColors.muted,
            fontWeight: FontWeight.w600,
            fontSize: 12,
          ),
        ),
      );
    }

    return SizedBox(
      height: height,
      width: double.infinity,
      child: CustomPaint(
        painter: _PriceTrendPainter(
          points: points,
          lineColor: lineColor,
          fillColor: fillColor,
        ),
      ),
    );
  }
}

class _PriceTrendPainter extends CustomPainter {
  final List<double> points;
  final Color lineColor;
  final Color fillColor;

  _PriceTrendPainter({
    required this.points,
    required this.lineColor,
    required this.fillColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (points.length < 2) return;

    final minPrice = points.reduce(math.min);
    final maxPrice = points.reduce(math.max);
    final range = (maxPrice - minPrice).abs() < 0.0001
        ? 1.0
        : (maxPrice - minPrice);

    final horizontalStep = size.width / (points.length - 1);
    const topPadding = 8.0;
    const bottomPadding = 8.0;
    final drawableHeight = size.height - topPadding - bottomPadding;

    double yFor(double price) {
      final normalized = (price - minPrice) / range;
      return size.height - bottomPadding - (normalized * drawableHeight);
    }

    final linePath = Path();
    final fillPath = Path();

    for (var i = 0; i < points.length; i++) {
      final x = i * horizontalStep;
      final y = yFor(points[i]);

      if (i == 0) {
        linePath.moveTo(x, y);
        fillPath.moveTo(x, size.height - bottomPadding);
        fillPath.lineTo(x, y);
      } else {
        linePath.lineTo(x, y);
        fillPath.lineTo(x, y);
      }
    }

    fillPath.lineTo(size.width, size.height - bottomPadding);
    fillPath.close();

    final gridPaint = Paint()
      ..color = AppColors.muted.withValues(alpha: 0.12)
      ..strokeWidth = 1;

    canvas.drawLine(
      Offset(0, size.height - bottomPadding),
      Offset(size.width, size.height - bottomPadding),
      gridPaint,
    );
    canvas.drawLine(
      Offset(0, topPadding),
      Offset(size.width, topPadding),
      gridPaint,
    );

    final fillPaint = Paint()
      ..style = PaintingStyle.fill
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          fillColor.withValues(alpha: 0.45),
          fillColor.withValues(alpha: 0.02),
        ],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    canvas.drawPath(fillPath, fillPaint);

    final linePaint = Paint()
      ..color = lineColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    canvas.drawPath(linePath, linePaint);

    final dotPaint = Paint()..color = lineColor;
    final lastX = (points.length - 1) * horizontalStep;
    final lastY = yFor(points.last);
    canvas.drawCircle(Offset(lastX, lastY), 3.8, dotPaint);
  }

  @override
  bool shouldRepaint(covariant _PriceTrendPainter oldDelegate) {
    if (oldDelegate.points.length != points.length) return true;
    for (var i = 0; i < points.length; i++) {
      if (oldDelegate.points[i] != points[i]) return true;
    }
    return oldDelegate.lineColor != lineColor ||
        oldDelegate.fillColor != fillColor;
  }
}
