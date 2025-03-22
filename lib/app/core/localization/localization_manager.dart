import 'package:flutter/material.dart';
import 'package:marti_app/app/core/l10n/generated/app_localizations.dart' show AppLocalizations;

class LocalizationManager extends ChangeNotifier {
  static final LocalizationManager _instance = LocalizationManager._internal();

  factory LocalizationManager() => _instance;

  LocalizationManager._internal();

  AppLocalizations? _appLocalizations;
  Locale _currentLocale = const Locale('tr');
  bool _isInitialized = false;

  void setLocalization(AppLocalizations localizations) {
    if (!_isInitialized || _appLocalizations != localizations) {
      _appLocalizations = localizations;
      _isInitialized = true;
      notifyListeners();
    }
  }

  AppLocalizations? get appLocalizations => _appLocalizations;

  bool get isInitialized => _isInitialized;

  Locale get currentLocale => _currentLocale;

  void changeLocale(Locale locale) {
    if (_currentLocale != locale) {
      _currentLocale = locale;
      _isInitialized = false;
      notifyListeners();
    }
  }
}
