import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled5/core/common_widgets/blue_glass_background.dart';
import 'package:untitled5/core/common_widgets/glass_container.dart';
import 'package:untitled5/core/common_widgets/gradient_glow_button.dart';
import 'package:untitled5/core/common_widgets/language_picker_sheet.dart';
import 'package:untitled5/core/localization/app_language.dart';
import 'package:untitled5/core/providers/language_provider.dart';
import 'package:untitled5/core/theme/app_colors.dart';
import 'package:untitled5/l10n/generated/app_localizations.dart';

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  final PageController _controller = PageController();
  int _index = 0;

  List<_SlideData> _slides(AppLocalizations l10n) => <_SlideData>[
    _SlideData(
      title: l10n.onboardingSlide1Title,
      description: l10n.onboardingSlide1Desc,
      icon: Iconsax.global,
      color: AppColors.primary,
    ),
    _SlideData(
      title: l10n.onboardingSlide2Title,
      description: l10n.onboardingSlide2Desc,
      icon: Iconsax.verify,
      color: AppColors.primary,
    ),
    _SlideData(
      title: l10n.onboardingSlide3Title,
      description: l10n.onboardingSlide3Desc,
      icon: Iconsax.document_text,
      color: AppColors.primary,
    ),
    _SlideData(
      title: l10n.onboardingSlide4Title,
      description: l10n.onboardingSlide4Desc,
      icon: Iconsax.notification_bing,
      color: AppColors.primary,
    ),
  ];

  Future<void> _finish(String route) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('onboarding_seen', true);
    if (!mounted) return;
    context.go(route);
  }

  void _next() {
    final total = _slides(AppLocalizations.of(context)).length;
    if (_index >= total - 1) {
      _finish('/login');
      return;
    }

    _controller.nextPage(
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeOutQuart,
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final slides = _slides(l10n);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark
        ? AppColors.darkTextPrimary
        : AppColors.lightTextPrimary;
    final mutedColor = isDark
        ? AppColors.darkTextSecondary
        : AppColors.lightTextSecondary;
    final currentLanguage = ref.watch(appLanguageProvider);

    return Scaffold(
      body: BlueGlassBackground(
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 16,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'DEALIO',
                      style: GoogleFonts.poppins(
                        color: textColor,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 2,
                        fontSize: 18,
                      ),
                    ),
                    const Spacer(),
                    _OnboardingLanguagePill(
                      label: currentLanguage.nativeName,
                      onTap: () => showLanguagePickerSheet(context),
                    ),
                    const SizedBox(width: 8),
                    Flexible(
                      child: TextButton(
                        onPressed: () => _finish('/login'),
                        child: Text(
                          l10n.onboardingSkip,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.inter(
                            color: mutedColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: PageView.builder(
                  controller: _controller,
                  itemCount: slides.length,
                  onPageChanged: (value) => setState(() => _index = value),
                  itemBuilder: (context, i) {
                    final slide = slides[i];
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GlassContainer(
                                width: 280,
                                height: 280,
                                borderRadius: 140,
                                blur: 30,
                                child: Center(
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Container(
                                            width: 120,
                                            height: 120,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              boxShadow: [
                                                BoxShadow(
                                                  color: slide.color.withValues(
                                                    alpha: 0.4,
                                                  ),
                                                  blurRadius: 50,
                                                  spreadRadius: 10,
                                                ),
                                              ],
                                            ),
                                          )
                                          .animate(
                                            onPlay: (c) =>
                                                c.repeat(reverse: true),
                                          )
                                          .scale(
                                            begin: const Offset(0.8, 0.8),
                                            end: const Offset(1.2, 1.2),
                                            duration: 2.seconds,
                                          ),
                                      Icon(
                                        slide.icon,
                                        size: 100,
                                        color: slide.color,
                                      ),
                                    ],
                                  ),
                                ),
                              )
                              .animate(key: ValueKey(i))
                              .fadeIn()
                              .scale(begin: const Offset(0.8, 0.8)),
                          const SizedBox(height: 60),
                          Text(
                                slide.title,
                                textAlign: TextAlign.center,
                                style: GoogleFonts.poppins(
                                  color: textColor,
                                  fontSize: 28,
                                  fontWeight: FontWeight.w800,
                                  height: 1.2,
                                ),
                              )
                              .animate(key: ValueKey('t$i'))
                              .fadeIn()
                              .slideY(begin: 0.2, end: 0),
                          const SizedBox(height: 16),
                          Text(
                                slide.description,
                                textAlign: TextAlign.center,
                                style: GoogleFonts.inter(
                                  color: mutedColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  height: 1.5,
                                ),
                              )
                              .animate(key: ValueKey('d$i'))
                              .fadeIn(delay: 100.ms)
                              .slideY(begin: 0.2, end: 0),
                        ],
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(slides.length, (i) {
                        final active = i == _index;
                        return AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          width: active ? 32 : 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: active
                                ? AppColors.primary
                                : AppColors.primary.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(4),
                            boxShadow: active
                                ? [
                                    BoxShadow(
                                      color: AppColors.primary.withValues(
                                        alpha: 0.5,
                                      ),
                                      blurRadius: 10,
                                      offset: const Offset(0, 4),
                                    ),
                                  ]
                                : [],
                          ),
                        );
                      }),
                    ),
                    const SizedBox(height: 40),
                    Row(
                      children: [
                        if (_index > 0) ...[
                          Expanded(
                            child: OutlinedButton(
                              onPressed: () {
                                _controller.previousPage(
                                  duration: const Duration(milliseconds: 600),
                                  curve: Curves.easeOutQuart,
                                );
                              },
                              style: OutlinedButton.styleFrom(
                                side: BorderSide(
                                  color: AppColors.primary.withValues(
                                    alpha: 0.3,
                                  ),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  vertical: 16,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                              ),
                              child: Text(
                                l10n.onboardingBack,
                                style: GoogleFonts.inter(
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                        ],
                        Expanded(
                          flex: 2,
                          child: GradientGlowButton(
                            label: _index == slides.length - 1
                                ? l10n.onboardingGetStarted
                                : l10n.onboardingNext,
                            onTap: _next,
                            icon: _index == slides.length - 1
                                ? Iconsax.flash_1
                                : Iconsax.arrow_right_3,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _OnboardingLanguagePill extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const _OnboardingLanguagePill({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: AppLocalizations.of(context).languageTitle,
      child: InkWell(
        borderRadius: BorderRadius.circular(999),
        onTap: onTap,
        child: Container(
          height: 36,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(999),
            border: Border.all(
              color: AppColors.primary.withValues(alpha: 0.16),
              width: 0.8,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const Icon(Iconsax.global, color: AppColors.primary, size: 16),
              const SizedBox(width: 6),
              Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: AppColors.onSurface(context),
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SlideData {
  final String title;
  final String description;
  final IconData icon;
  final Color color;

  const _SlideData({
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
  });
}
