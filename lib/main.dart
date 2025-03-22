import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:marti_app/core/lifecycle/app_lifecycle_manager.dart';
import 'package:marti_app/core/localization/localization_manager.dart';
import 'package:marti_app/core/theme/app_theme.dart';
import 'package:marti_app/services/location_service.dart' show LocationService;
import 'package:marti_app/views/home/home_view.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:marti_app/viewmodels/home_viewmodel.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.presentError(details);
    debugPrint('Flutter Error: ${details.toString()}');
  };

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CounterViewModel()),
        ChangeNotifierProvider(create: (_) => LocationService()),
        ChangeNotifierProvider(create: (_) => LocalizationManager()),
      ],
      child: Consumer<LocalizationManager>(
        builder: (context, localizationManager, child) {
          return AppLifecycleManager(
            child: MaterialApp(
              title: 'Marti Example App',
              home: const HomeView(),
              theme: AppTheme().light,
              localizationsDelegates: const [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: const [
                Locale('en'), // English
                Locale('tr'), // Turkish
              ],
              locale: localizationManager.currentLocale,
              onGenerateTitle: (context) {
                final localizations = AppLocalizations.of(context);
                if (localizations != null) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    localizationManager.setLocalization(localizations);
                  });
                }
                return 'Marti Example App';
              },
            ),
          );
        },
      ),
    );
  }
}
