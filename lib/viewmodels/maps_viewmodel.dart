import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:marti_app/services/location_service.dart' show LocationService;

class MapsViewModel extends ChangeNotifier {
  final LocationService _locationService;
  GoogleMapController? mapController;
  bool isMapInitialized = false;
  Set<Marker> _markers = {};
  Set<Polyline> _polylines = {};

  LatLng? get initialPosition => _locationService.initialPosition;

  MapsViewModel(this._locationService) {
    _locationService.addListener(_onLocationServiceChanged);
    _markers = _locationService.markers;
    _polylines = _locationService.polylines;
  }

  Set<Marker> get markers => _markers;

  Set<Polyline> get polylines => _polylines;

  bool get isTracking => _locationService.isTracking;

  void showMarkerInfo(MarkerId markerId) {
    mapController?.showMarkerInfoWindow(markerId);
  }

  void onMapCreated(GoogleMapController controller) {
    mapController = controller;
    isMapInitialized = true;
    notifyListeners();
  }

  void startTracking() {
    _locationService.startTracking();
  }

  void stopTracking() {
    _locationService.stopTracking();
  }

  void _onLocationServiceChanged() {
    final newMarkers = _locationService.markers;
    final newPolylines = _locationService.polylines;

    if (_markers != newMarkers || _polylines != newPolylines) {
      _markers = newMarkers;
      _polylines = newPolylines;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    _locationService.removeListener(_onLocationServiceChanged);
    mapController?.dispose();
    stopTracking();
    super.dispose();
  }
}
