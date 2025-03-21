import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:marti_app/services/location_service.dart';

class MapsViewModel extends ChangeNotifier {
  final LocationService _locationService;
  GoogleMapController? _mapController;
  bool _isMapInitialized = false;
  bool _isDisposed = false;

  MapsViewModel(this._locationService) {
    _locationService.addListener(_onLocationServiceChanged);
  }

  bool get isMapInitialized => _isMapInitialized;

  Set<Marker> get markers => _locationService.markers;

  Set<Polyline> get polylines => _locationService.polylines;

  LatLng? get initialPosition => null;

  void _onLocationServiceChanged() {
    if (!_isDisposed) {
      notifyListeners();
    }
  }

  void onMapCreated(GoogleMapController controller) {
    _mapController = controller;
    _isMapInitialized = true;
    if (!_isDisposed) {
      notifyListeners();
    }
  }

  Future<void> startTracking() async {
    await _locationService.startTracking();
  }

  @override
  void dispose() {
    _isDisposed = true;
    _locationService.removeListener(_onLocationServiceChanged);
    _locationService.stopTracking(isStopButtonPressed: false);
    _mapController?.dispose();
    super.dispose();
  }
}
