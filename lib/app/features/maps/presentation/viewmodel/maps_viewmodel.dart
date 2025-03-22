import 'package:flutter/material.dart';
import 'package:marti_app/app/features/maps/manager/location_tracking_manager.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapsViewModel extends ChangeNotifier {
  final LocationTrackingManager _locationManager;
  bool _isLoading = false;

  MapsViewModel(this._locationManager) {
    _locationManager.addListener(_onLocationManagerChanged);
  }

  bool get isLoading => _isLoading;

  Set<Marker> get markers => _locationManager.markers;

  Set<Polyline> get polylines => _locationManager.polylines;

  bool get isTracking => _locationManager.isTracking;

  void _onLocationManagerChanged() {
    notifyListeners();
  }

  Future<void> startTracking() async {
    if (_isLoading) return;

    _isLoading = true;
    notifyListeners();

    try {
      await _locationManager.startTracking();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    _locationManager.removeListener(_onLocationManagerChanged);
    _locationManager.stopTracking(isStopButtonPressed: false);
    super.dispose();
  }
}
