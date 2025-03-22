// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Marti App';

  @override
  String get welcome => 'Welcome!';

  @override
  String get appDescription => 'Marti Example App is a sample application that follows your location and shows it on the map.';

  @override
  String get quickActions => 'Quick Actions';

  @override
  String get maps => 'Maps';

  @override
  String get mapsDescription => 'Location tracking and map view';

  @override
  String get markerList => 'Marker List';

  @override
  String get markerListDescription => 'Before you go, check the list';

  @override
  String get paymentHistory => 'Payment History';

  @override
  String get paymentHistoryDescription => 'See your payment history';

  @override
  String get settings => 'Application Settings';

  @override
  String get settingsDescription => 'See Application settings';

  @override
  String get clearRoute => 'Clear Route';

  @override
  String get clearRouteConfirmation => 'All route and location markers will be deleted. Are you sure?';

  @override
  String get cancel => 'Cancel';

  @override
  String get clear => 'Clear';

  @override
  String get close => 'Close';

  @override
  String get latitude => 'Latitude';

  @override
  String get longitude => 'Longitude';

  @override
  String get time => 'Time';

  @override
  String get locationPermissionRequired => 'Location Permission Required';

  @override
  String get locationPermissionMessage => 'We need location permission to track your location. Please enable location permission in app settings.';

  @override
  String get goToSettings => 'Go to Settings';

  @override
  String get switchLanguageButton => 'Türkçe\'ye Geç';

  @override
  String get switchLanguageDescription => 'Dili Türkçe olarak ayarla';
}
