import 'dart:async';

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

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _obscurePassword = true;

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _showSuccessAnimation() async {
    unawaited(
      showDialog<void>(
        context: context,
        barrierDismissible: false,
        barrierColor: Colors.black.withValues(alpha: 0.45),
        builder: (dialogContext) {
          return Center(
            child: GlassContainer(
              borderRadius: 28,
              padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 72,
                    height: 72,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: [
                          AppColors.neon.withValues(alpha: 0.9),
                          AppColors.accent.withValues(alpha: 0.9),
                        ],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.neon.withValues(alpha: 0.45),
                          blurRadius: 26,
                          spreadRadius: 4,
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 38,
                    ),
                  ).animate().scale(
                    begin: const Offset(0.6, 0.6),
                    curve: Curves.easeOutBack,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    AppLocalizations.of(dialogContext).registerSuccessTitle,
                    style: TextStyle(
                      color: AppColors.onSurface(dialogContext),
                      fontWeight: FontWeight.w800,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );

    await Future<void>.delayed(const Duration(milliseconds: 900));
    if (!mounted) return;
    if (Navigator.of(context, rootNavigator: true).canPop()) {
      Navigator.of(context, rootNavigator: true).pop();
    }
  }

  String _fullNameToUsername(String fullName) {
    final compact = fullName.trim().toLowerCase();
    if (compact.isEmpty) return 'clario_user';

    final username = compact
        .replaceAll(RegExp(r'[^a-z0-9]+'), '_')
        .replaceAll(RegExp(r'^_+|_+$'), '');

    return username.isEmpty ? 'clario_user' : username;
  }

  Future<void> _register() async {
    if (!_formKey.currentState!.validate()) return;

    await ref
        .read(authProvider.notifier)
        .register(
          email: _emailController.text.trim(),
          password: _passwordController.text,
          username: _fullNameToUsername(_fullNameController.text),
        );

    final state = ref.read(authProvider);
    if (!mounted) return;

    if (state.status == AuthStatus.authenticated) {
      await _showSuccessAnimation();
      if (!mounted) return;
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
    final isDark = ref.watch(themeProvider) == ThemeMode.dark;
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
                          SizedBox(height: constraints.maxHeight * 0.08),
                          GlassContainer(
                                width: 88,
                                height: 88,
                                borderRadius: 26,
                                padding: EdgeInsets.zero,
                                child: const Icon(
                                  Iconsax.user_add,
                                  color: AppColors.primary,
                                  size: 38,
                                ),
                              )
                              .animate()
                              .fadeIn(duration: 320.ms)
                              .scale(begin: const Offset(0.92, 0.92)),
                          const SizedBox(height: 14),
                          Text(
                            l10n.registerCreateAccount,
                            style: TextStyle(
                              color: textColor,
                              fontSize: 30,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            l10n.registerSubtitle,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: mutedColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 16),
                          GlassContainer(
                            borderRadius: 22,
                            padding: const EdgeInsets.all(16),
                            child: Form(
                              key: _formKey,
                              child: Column(
                                children: [
                                  _AnimatedPlaceholderField(
                                    controller: _fullNameController,
                                    icon: Iconsax.user,
                                    placeholder: l10n.authFullNameLabel,
                                    validator: (value) {
                                      final text = (value ?? '').trim();
                                      if (text.isEmpty) {
                                        return l10n.authFullNameRequired;
                                      }
                                      if (text.length < 3) {
                                        return l10n.authFullNameMinChars(3);
                                      }
                                      return null;
                                    },
                                  ),
                                  const SizedBox(height: 12),
                                  _AnimatedPlaceholderField(
                                    controller: _emailController,
                                    icon: Iconsax.sms,
                                    placeholder: l10n.authEmailLabel,
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
                                  _AnimatedPlaceholderField(
                                    controller: _passwordController,
                                    icon: Iconsax.lock,
                                    placeholder: l10n.authPasswordLabel,
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
                                            label: l10n.registerButton,
                                            icon: Iconsax.user_add,
                                            onTap: _register,
                                          ),
                                  ),
                                  const SizedBox(height: 10),
                                  TextButton(
                                    onPressed: isLoading
                                        ? null
                                        : () => context.pop(),
                                    child: Text(
                                      l10n.registerAlreadyHaveAccount,
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

class _AnimatedPlaceholderField extends StatefulWidget {
  final TextEditingController controller;
  final IconData icon;
  final String placeholder;
  final bool obscureText;
  final Widget? suffix;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;

  const _AnimatedPlaceholderField({
    required this.controller,
    required this.icon,
    required this.placeholder,
    this.obscureText = false,
    this.suffix,
    this.keyboardType = TextInputType.text,
    this.validator,
  });

  @override
  State<_AnimatedPlaceholderField> createState() =>
      _AnimatedPlaceholderFieldState();
}

class _AnimatedPlaceholderFieldState extends State<_AnimatedPlaceholderField> {
  late final FocusNode _focusNode;

  bool get _active => _focusNode.hasFocus || widget.controller.text.isNotEmpty;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode()
      ..addListener(() {
        if (mounted) setState(() {});
      });

    widget.controller.addListener(() {
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        TextFormField(
          controller: widget.controller,
          focusNode: _focusNode,
          keyboardType: widget.keyboardType,
          obscureText: widget.obscureText,
          validator: widget.validator,
          style: TextStyle(
            color: AppColors.onSurface(context),
            fontWeight: FontWeight.w600,
          ),
          decoration: InputDecoration(
            hintText: '',
            prefixIcon: Icon(widget.icon, color: AppColors.primary, size: 18),
            suffixIcon: widget.suffix,
            contentPadding: const EdgeInsets.fromLTRB(12, 18, 12, 10),
          ),
        ),
        Positioned(
          left: 44,
          child: IgnorePointer(
            child: AnimatedSlide(
              duration: const Duration(milliseconds: 180),
              offset: _active ? const Offset(0, -0.9) : Offset.zero,
              child: AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 180),
                style: TextStyle(
                  color: _active
                      ? AppColors.primary
                      : AppColors.onMuted(context),
                  fontSize: _active ? 11 : 14,
                  fontWeight: FontWeight.w600,
                ),
                child: Padding(
                  padding: EdgeInsets.only(top: _active ? 4 : 14),
                  child: Text(widget.placeholder),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
