import 'package:flutter/material.dart';

/// Central responsive rules for Dealio.
///
/// Keep screen-size decisions here instead of scattering magic numbers across
/// pages. It makes desktop/web/mobile behavior predictable and easier to test.
class AppBreakpoints {
  const AppBreakpoints._();

  static const double compact = 600;
  static const double medium = 840;
  static const double expanded = 1240;
  static const double large = 1440;
}

enum AppWindowClass { compact, medium, expanded, large }

extension ResponsiveContextX on BuildContext {
  Size get viewportSize => MediaQuery.sizeOf(this);

  double get viewportWidth => viewportSize.width;

  AppWindowClass get windowClass {
    final width = viewportWidth;
    if (width >= AppBreakpoints.large) return AppWindowClass.large;
    if (width >= AppBreakpoints.expanded) return AppWindowClass.expanded;
    if (width >= AppBreakpoints.medium) return AppWindowClass.medium;
    return AppWindowClass.compact;
  }

  bool get isCompact => windowClass == AppWindowClass.compact;

  bool get isMediumOrLarger => viewportWidth >= AppBreakpoints.medium;

  bool get usesNavigationRail => isMediumOrLarger;

  double get responsiveMaxWidth {
    return switch (windowClass) {
      AppWindowClass.compact => double.infinity,
      AppWindowClass.medium => 760,
      AppWindowClass.expanded => 980,
      AppWindowClass.large => 1120,
    };
  }

  double get responsiveHorizontalPadding {
    return switch (windowClass) {
      AppWindowClass.compact => 18,
      AppWindowClass.medium => 24,
      AppWindowClass.expanded => 32,
      AppWindowClass.large => 40,
    };
  }

  double get responsiveBottomPadding => usesNavigationRail ? 36 : 34;

  EdgeInsets responsivePagePadding({double top = 12, double? bottom}) {
    final horizontal = responsiveHorizontalPadding;
    return EdgeInsets.fromLTRB(
      horizontal,
      top,
      horizontal,
      bottom ?? responsiveBottomPadding,
    );
  }
}

class AppResponsive {
  const AppResponsive._();

  static int gridColumnsForWidth(
    double width, {
    int compact = 1,
    int medium = 2,
    int expanded = 3,
    int large = 4,
  }) {
    if (width >= AppBreakpoints.large) return large;
    if (width >= AppBreakpoints.expanded) return expanded;
    if (width >= AppBreakpoints.medium) return medium;
    return compact;
  }
}

class ResponsivePageFrame extends StatelessWidget {
  final Widget child;
  final double? maxWidth;
  final Alignment alignment;

  const ResponsivePageFrame({
    super.key,
    required this.child,
    this.maxWidth,
    this.alignment = Alignment.topCenter,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: maxWidth ?? context.responsiveMaxWidth,
        ),
        child: child,
      ),
    );
  }
}

class ResponsiveContent extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final double? maxWidth;
  final Alignment alignment;

  const ResponsiveContent({
    super.key,
    required this.child,
    this.padding,
    this.maxWidth,
    this.alignment = Alignment.topCenter,
  });

  @override
  Widget build(BuildContext context) {
    return ResponsivePageFrame(
      maxWidth: maxWidth,
      alignment: alignment,
      child: Padding(
        padding: padding ?? context.responsivePagePadding(),
        child: child,
      ),
    );
  }
}
