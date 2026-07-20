import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:untitled5/core/localization/app_language.dart';
import 'package:untitled5/core/notifications/push_notification_service.dart';
import 'package:untitled5/core/providers/language_provider.dart';
import 'package:untitled5/core/providers/theme_provider.dart';
import 'package:untitled5/core/router/app_router.dart';
import 'package:untitled5/core/theme/app_theme.dart';
import 'package:untitled5/core/theme/app_colors.dart';
import 'package:untitled5/features/auth/presentation/providers/auth_provider.dart';
import 'package:untitled5/l10n/generated/app_localizations.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  FlutterError.onError = (FlutterErrorDetails details) {
    if (kDebugMode) {
      FlutterError.presentError(details);
      debugPrint('Flutter framework error: ${details.exceptionAsString()}');
    }
  };

  PlatformDispatcher.instance.onError = (Object error, StackTrace stack) {
    if (kDebugMode) {
      debugPrint('Platform error: $error');
      debugPrintStack(stackTrace: stack);
    }
    return true;
  };

  ErrorWidget.builder = (FlutterErrorDetails details) {
    return Material(
      color: AppColors.background,
      child: Center(
        child: Container(
          margin: const EdgeInsets.all(24),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.card.withValues(alpha: 0.9),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: AppColors.danger.withValues(alpha: 0.35)),
          ),
          child: const Text(
            'Something went wrong. Please restart this screen.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.text,
              fontWeight: FontWeight.w700,
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  };

  runZonedGuarded(
    () {
      runApp(const ProviderScope(child: DealioApp()));
      // Firebase is optional and must never delay the first frame.
      unawaited(ensureFirebaseReadyForPush());
    },
    (Object error, StackTrace stack) {
      if (kDebugMode) {
        debugPrint('Uncaught async error: $error');
        debugPrintStack(stackTrace: stack);
      }
    },
  );
}

class DealioApp extends ConsumerWidget {
  const DealioApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<AuthState>(authProvider, (previous, next) {
      if (next.status == AuthStatus.authenticated) {
        unawaited(
          ref.read(pushNotificationServiceProvider).initializeAndRegister(),
        );
      }
    });

    final themeMode = ref.watch(themeProvider);
    final appLanguage = ref.watch(appLanguageProvider);

    return MaterialApp.router(
      title: 'Dealio',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeMode,
      locale: appLanguage.locale,
      supportedLocales: AppLocalizations.supportedLocales,
      localeResolutionCallback: (locale, supportedLocales) {
        if (locale == null) return const Locale('en');
        for (final supported in supportedLocales) {
          if (supported.languageCode == locale.languageCode) {
            return supported;
          }
        }
        return const Locale('en');
      },
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      themeAnimationDuration: const Duration(milliseconds: 180),
      themeAnimationCurve: Curves.easeInOutCubic,
      routerConfig: appRouter,
    );
  }
}
