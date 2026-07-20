import 'package:flutter/material.dart';
import 'package:untitled5/l10n/generated/app_localizations.dart';

enum AppLanguage { en, ru, es, uz, zh }

extension AppLanguageX on AppLanguage {
  String get code {
    switch (this) {
      case AppLanguage.en:
        return 'en';
      case AppLanguage.ru:
        return 'ru';
      case AppLanguage.es:
        return 'es';
      case AppLanguage.uz:
        return 'uz';
      case AppLanguage.zh:
        return 'zh';
    }
  }

  Locale get locale {
    switch (this) {
      case AppLanguage.en:
        return const Locale('en');
      case AppLanguage.ru:
        return const Locale('ru');
      case AppLanguage.es:
        return const Locale('es');
      case AppLanguage.uz:
        return const Locale('uz');
      case AppLanguage.zh:
        return const Locale('zh');
    }
  }

  String localizedLabel(AppLocalizations l10n) {
    switch (this) {
      case AppLanguage.en:
        return l10n.langEnglish;
      case AppLanguage.ru:
        return l10n.langRussian;
      case AppLanguage.es:
        return l10n.langSpanish;
      case AppLanguage.uz:
        return l10n.langUzbek;
      case AppLanguage.zh:
        return l10n.langChinese;
    }
  }

  String get nativeName {
    switch (this) {
      case AppLanguage.en:
        return 'English';
      case AppLanguage.ru:
        return 'Русский';
      case AppLanguage.es:
        return 'Español';
      case AppLanguage.uz:
        return 'O‘zbek';
      case AppLanguage.zh:
        return '中文';
    }
  }
}

class AppLanguageConfig {
  static const List<AppLanguage> all = <AppLanguage>[
    AppLanguage.en,
    AppLanguage.ru,
    AppLanguage.es,
    AppLanguage.uz,
    AppLanguage.zh,
  ];

  static AppLanguage fromCode(String? code) {
    final normalized = (code ?? '').trim().toLowerCase();
    for (final lang in all) {
      if (lang.code == normalized) {
        return lang;
      }
    }
    return AppLanguage.en;
  }
}
