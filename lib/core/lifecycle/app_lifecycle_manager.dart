import 'package:flutter/material.dart';
import 'package:marti_app/services/location_service.dart' show LocationService;
import 'package:provider/provider.dart';

class AppLifecycleManager extends StatefulWidget {
  final Widget child;

  const AppLifecycleManager({required this.child, super.key});

  @override
  State<AppLifecycleManager> createState() => _AppLifecycleManagerState();
}

class _AppLifecycleManagerState extends State<AppLifecycleManager>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final locationService = context.read<LocationService>();

    switch (state) {
      case AppLifecycleState.resumed:
        if (!locationService.isTracking) {
          locationService.startTracking();
        }
        break;
      case AppLifecycleState.inactive:
        break;
      case AppLifecycleState.paused:
        if (!locationService.isTracking) {
          locationService.startTracking();
        }
        break;
      case AppLifecycleState.detached:
        locationService.stopTracking(isStopButtonPressed: false);
        break;
      case AppLifecycleState.hidden:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
