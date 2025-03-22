import 'package:flutter/material.dart';
import 'package:marti_app/app/core/l10n/generated/app_localizations.dart'
    show AppLocalizations;
import 'package:marti_app/app/core/localization/localization_manager.dart'
    show LocalizationManager;
import 'package:provider/provider.dart';

extension ContextLocalizationExtension on BuildContext {
  AppLocalizations get l10n {
    final manager = read<LocalizationManager>();
    final localizations = manager.appLocalizations;
    if (localizations == null) {
      return AppLocalizations.of(this) ?? _getFallbackLocalizations();
    }
    return localizations;
  }

  void changeLocale(Locale locale) {
    read<LocalizationManager>().changeLocale(locale);
  }

  AppLocalizations _getFallbackLocalizations() {
    final localizations = AppLocalizations.of(this);
    if (localizations != null) {
      return localizations;
    }
    throw Exception('Localization could not be initialized');
  }
}
