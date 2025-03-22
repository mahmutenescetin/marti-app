import 'package:flutter/material.dart';
import 'package:marti_app/app/features/maps/manager/location_tracking_manager.dart';
import 'package:provider/provider.dart';

class AppLifecycleManager extends StatefulWidget {
  const AppLifecycleManager({
    required this.child, super.key,
  });

  final Widget child;

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
    final locationManager = context.read<LocationTrackingManager>();

    switch (state) {
      case AppLifecycleState.resumed:
        if (!locationManager.isTracking) {
          locationManager.startTracking();
        }
        break;
      case AppLifecycleState.inactive:
        break;
      case AppLifecycleState.paused:
        if (!locationManager.isTracking) {
          locationManager.startTracking();
        }
        break;
      case AppLifecycleState.detached:
        locationManager.stopTracking(isStopButtonPressed: false);
        break;
      case AppLifecycleState.hidden:
        break;
    }
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
