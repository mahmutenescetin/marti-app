// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Turkish (`tr`).
class AppLocalizationsTr extends AppLocalizations {
  AppLocalizationsTr([String locale = 'tr']) : super(locale);

  @override
  String get appTitle => 'Martı Uygulaması';

  @override
  String get welcome => 'Hoş Geldiniz!';

  @override
  String get appDescription => 'Martı Örnek Uygulaması, konumunuzu takip eden ve harita üzerinde gösteren örnek bir uygulamadır.';

  @override
  String get quickActions => 'Hızlı İşlemler';

  @override
  String get maps => 'Haritalar';

  @override
  String get mapsDescription => 'Konum takibi ve harita görünümü';

  @override
  String get markerList => 'İşaretçi Listesi';

  @override
  String get markerListDescription => 'Gitmeden önce listeyi kontrol edin';

  @override
  String get paymentHistory => 'Ödeme Geçmişi';

  @override
  String get paymentHistoryDescription => 'Ödeme geçmişinizi görüntüleyin';

  @override
  String get settings => 'Uygulama Ayarları';

  @override
  String get settingsDescription => 'Uygulama ayarlarını görüntüleyin';

  @override
  String get clearRoute => 'Rotayı Temizle';

  @override
  String get clearRouteConfirmation => 'Tüm rota ve konum işaretleri silinecek. Emin misiniz?';

  @override
  String get cancel => 'İptal';

  @override
  String get clear => 'Temizle';

  @override
  String get close => 'Kapat';

  @override
  String get latitude => 'Enlem';

  @override
  String get longitude => 'Boylam';

  @override
  String get time => 'Zaman';

  @override
  String get locationPermissionRequired => 'Konum İzni Gerekli';

  @override
  String get locationPermissionMessage => 'Konumunuzu takip edebilmek için konum iznine ihtiyacımız var. Lütfen uygulama ayarlarından konum iznini etkinleştirin.';

  @override
  String get goToSettings => 'Ayarlara Git';

  @override
  String get switchLanguageButton => 'Switch to English';

  @override
  String get switchLanguageDescription => 'Change language to English';
}
