import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:untitled5/core/common_widgets/blue_glass_background.dart';
import 'package:untitled5/core/common_widgets/glass_container.dart';
import 'package:untitled5/core/common_widgets/gradient_glow_button.dart';
import 'package:untitled5/core/providers/theme_provider.dart';
import 'package:untitled5/core/responsive/responsive_layout.dart';
import 'package:untitled5/core/theme/app_colors.dart';
import 'package:untitled5/features/auth/presentation/providers/auth_provider.dart';
import 'package:untitled5/l10n/generated/app_localizations.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) return;

    await ref
        .read(authProvider.notifier)
        .login(_emailController.text.trim(), _passwordController.text);

    final state = ref.read(authProvider);
    if (!mounted) return;

    if (state.status == AuthStatus.authenticated) {
      context.go('/home');
      return;
    }

    if (state.errorMessage != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(state.errorMessage!),
          backgroundColor: AppColors.danger,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);
    final isLoading = authState.status == AuthStatus.loading;
    final themeMode = ref.watch(themeProvider);
    final isDark = themeMode == ThemeMode.dark;
    final textColor = AppColors.onSurface(context);
    final mutedColor = AppColors.onMuted(context);
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      body: BlueGlassBackground(
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
                child: ResponsivePageFrame(
                  maxWidth: 460,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight - 8,
                    ),
                    child: IntrinsicHeight(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              const Spacer(),
                              IconButton(
                                onPressed: () => ref
                                    .read(themeProvider.notifier)
                                    .toggleTheme(),
                                icon: Icon(
                                  isDark ? Iconsax.sun_1 : Iconsax.moon,
                                  color: AppColors.primary,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: constraints.maxHeight * 0.1),
                          GlassContainer(
                                width: 88,
                                height: 88,
                                borderRadius: 26,
                                padding: EdgeInsets.zero,
                                child: const Icon(
                                  Iconsax.security_user,
                                  color: AppColors.primary,
                                  size: 38,
                                ),
                              )
                              .animate()
                              .fadeIn(duration: 340.ms)
                              .scale(begin: const Offset(0.92, 0.92)),
                          const SizedBox(height: 16),
                          Text(
                            l10n.loginWelcomeBack,
                            style: TextStyle(
                              color: textColor,
                              fontSize: 30,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            l10n.loginSignInContinue,
                            style: TextStyle(
                              color: mutedColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 18),
                          GlassContainer(
                            borderRadius: 22,
                            padding: const EdgeInsets.all(16),
                            child: Form(
                              key: _formKey,
                              child: Column(
                                children: [
                                  _AuthField(
                                    controller: _emailController,
                                    label: l10n.authEmailLabel,
                                    hint: l10n.authEmailHint,
                                    icon: Iconsax.sms,
                                    keyboardType: TextInputType.emailAddress,
                                    validator: (value) {
                                      final text = (value ?? '').trim();
                                      if (text.isEmpty) {
                                        return l10n.authEmailRequired;
                                      }
                                      if (!text.contains('@')) {
                                        return l10n.authEmailInvalid;
                                      }
                                      return null;
                                    },
                                  ),
                                  const SizedBox(height: 12),
                                  _AuthField(
                                    controller: _passwordController,
                                    label: l10n.authPasswordLabel,
                                    hint: l10n.authPasswordHint,
                                    icon: Iconsax.lock,
                                    obscureText: _obscurePassword,
                                    suffix: IconButton(
                                      onPressed: () => setState(
                                        () => _obscurePassword =
                                            !_obscurePassword,
                                      ),
                                      icon: Icon(
                                        _obscurePassword
                                            ? Iconsax.eye
                                            : Iconsax.eye_slash,
                                        color: AppColors.onMuted(context),
                                        size: 18,
                                      ),
                                    ),
                                    validator: (value) {
                                      final text = value ?? '';
                                      if (text.isEmpty) {
                                        return l10n.authPasswordRequired;
                                      }
                                      if (text.length < 6) {
                                        return l10n.authPasswordMinChars(6);
                                      }
                                      return null;
                                    },
                                  ),
                                  const SizedBox(height: 18),
                                  SizedBox(
                                    width: double.infinity,
                                    child: isLoading
                                        ? const Center(
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                vertical: 14,
                                              ),
                                              child: CircularProgressIndicator(
                                                strokeWidth: 2,
                                              ),
                                            ),
                                          )
                                        : GradientGlowButton(
                                            label: l10n.loginButton,
                                            icon: Iconsax.arrow_right_3,
                                            onTap: _login,
                                          ),
                                  ),
                                  const SizedBox(height: 10),
                                  _AnimatedLink(
                                    label: l10n.loginForgotPassword,
                                  ),
                                  const SizedBox(height: 4),
                                  TextButton(
                                    onPressed: isLoading
                                        ? null
                                        : () => context.push('/register'),
                                    child: Text(
                                      l10n.loginCreateAccount,
                                      style: TextStyle(
                                        color: AppColors.primary,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const Spacer(),
                          TextButton(
                            onPressed: () => context.go('/onboarding'),
                            child: Text(
                              l10n.loginBackOnboarding,
                              style: TextStyle(
                                color: mutedColor,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class _AnimatedLink extends StatefulWidget {
  final String label;

  const _AnimatedLink({required this.label});

  @override
  State<_AnimatedLink> createState() => _AnimatedLinkState();
}

class _AnimatedLinkState extends State<_AnimatedLink> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: GestureDetector(
        onTap: () {},
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              widget.label,
              style: TextStyle(
                color: AppColors.onMuted(context),
                fontWeight: FontWeight.w700,
                fontSize: 13,
              ),
            ),
            const SizedBox(height: 2),
            AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              width: _hover ? 116 : 72,
              height: 1.4,
              color: AppColors.primary.withValues(alpha: _hover ? 0.8 : 0.35),
            ),
          ],
        ),
      ),
    );
  }
}

class _AuthField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hint;
  final IconData icon;
  final bool obscureText;
  final TextInputType keyboardType;
  final Widget? suffix;
  final String? Function(String?)? validator;

  const _AuthField({
    required this.controller,
    required this.label,
    required this.hint,
    required this.icon,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.suffix,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      style: TextStyle(
        color: AppColors.onSurface(context),
        fontWeight: FontWeight.w600,
      ),
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: Icon(icon, color: AppColors.primary, size: 18),
        suffixIcon: suffix,
      ),
    );
  }
}
