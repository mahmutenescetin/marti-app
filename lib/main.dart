import 'package:flutter/material.dart';
import 'package:marti_app/core/theme/app_theme.dart';
import 'package:marti_app/services/location_service.dart' show LocationService;
import 'package:marti_app/views/home/home_view.dart';
import 'package:provider/provider.dart';

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
      ],
      child: MaterialApp(
        title: 'Marti Example App',
        home: const HomeView(),
        theme: AppTheme().light,
      ),
    );
  }
}
