import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_background_geolocation/flutter_background_geolocation.dart'
    as bg;
import 'package:permission_handler/permission_handler.dart';

class LocationService extends ChangeNotifier {
  Set<Marker> _markers = {};
  Set<Polyline> _polylines = {};
  List<LatLng> _routePoints = [];
  bool _isTracking = false;
  bool _hasShownPermissionDialog = false;
  LatLng? _initialPosition;
  Function(Map<String, String>)? _dialogCallback;

  Set<Marker> get markers => _markers;
  Set<Polyline> get polylines => _polylines;
  bool get isTracking => _isTracking;
  bool get hasShownPermissionDialog => _hasShownPermissionDialog;
  LatLng? get initialPosition => _initialPosition;

  LocationService() {
    _initializeLocation();

    debugPrint('LocationService constructor');
  }

  Future<void> _initializeLocation() async {
    try {
      await bg.BackgroundGeolocation.ready(bg.Config(
        desiredAccuracy: bg.Config.DESIRED_ACCURACY_HIGH,
        distanceFilter: 10.0,
        stopOnTerminate: false,
        startOnBoot: true,
        debug: false,
        logLevel: bg.Config.LOG_LEVEL_VERBOSE,
        notification: bg.Notification(
          title: 'Location Track',
          text: 'Location Tracking',
          channelName: 'Location Service',
        ),
      ));

      // İlk konumu al
      final location = await bg.BackgroundGeolocation.getCurrentPosition(
        timeout: 30,
        maximumAge: 5000,
        desiredAccuracy: 10,
        persist: false,
      );

      _initialPosition = LatLng(
        location.coords.latitude,
        location.coords.longitude,
      );
      debugPrint(
          'Initial position set: ${_initialPosition?.latitude}, ${_initialPosition?.longitude}');
      notifyListeners();

      // Konum değişikliği dinleyicisi
      bg.BackgroundGeolocation.onLocation((bg.Location location) {
        _handleNewLocation(location);
      });
    } catch (e) {
      debugPrint('Initialize location error: $e');
    }
  }

  void _handleNewLocation(bg.Location location) {
    try {
      final newPosition =
          LatLng(location.coords.latitude, location.coords.longitude);

      final markerId = MarkerId(DateTime.now().toString());
      final DateTime now = DateTime.now();
      final String formattedDate =
          '${now.day}/${now.month}/${now.year} ${now.hour}:${now.minute}:${now.second}';

      final double speed = location.coords.speed * 3.6;
      final String formattedSpeed = speed.toStringAsFixed(1);

      // Konum bilgilerini bir map'te saklayalım
      final locationInfo = {
        'id': markerId.value,
        'date': formattedDate,
        'speed': formattedSpeed,
        'latitude': location.coords.latitude.toStringAsFixed(6),
        'longitude': location.coords.longitude.toStringAsFixed(6),
        'altitude': location.coords.altitude.toStringAsFixed(1),
      };

      final newMarker = Marker(
        markerId: markerId,
        position: newPosition,
        onTap: () {
          if (_dialogCallback != null) {
            _dialogCallback!(locationInfo);
          }
        },
      );

      _routePoints.add(newPosition);

      final polyline = Polyline(
        polylineId: const PolylineId('route'),
        points: _routePoints,
        color: Colors.blue,
        width: 5,
        patterns: [
          PatternItem.dash(20),
          PatternItem.gap(10),
        ],
      );

      _markers = Set<Marker>.from(_markers)..add(newMarker);
      _polylines = {polyline};

      notifyListeners();
    } catch (e) {
      debugPrint('Handle new location error: $e');
    }
  }

  Future<PermissionStatus> checkLocationPermission() async {
    try {
      final state = await bg.BackgroundGeolocation.requestPermission();

      if (state == bg.ProviderChangeEvent.AUTHORIZATION_STATUS_ALWAYS) {
        return PermissionStatus.granted;
      } else if (state == bg.ProviderChangeEvent.AUTHORIZATION_STATUS_DENIED) {
        return PermissionStatus.denied;
      } else if (state ==
          bg.ProviderChangeEvent.AUTHORIZATION_STATUS_RESTRICTED) {
        return PermissionStatus.permanentlyDenied;
      }

      return PermissionStatus.denied;
    } catch (e) {
      debugPrint('Check location permission error: $e');
      return PermissionStatus.denied;
    }
  }

  Future<bool> requestPermission() async {
    try {
      final status = await bg.BackgroundGeolocation.requestPermission();
      return status == bg.ProviderChangeEvent.AUTHORIZATION_STATUS_ALWAYS;
    } catch (e) {
      debugPrint('Request location permission error: $e');
      return false;
    }
  }

  void startTracking() async {
    if (!_isTracking) {
      // Eğer initial position henüz alınmamışsa tekrar dene
      if (_initialPosition == null) {
        await _initializeLocation();
      }

      _isTracking = true;
      await bg.BackgroundGeolocation.start();
      notifyListeners();
    }
  }

  void stopTracking() {
    if (_isTracking) {
      bg.BackgroundGeolocation.stop();
      _isTracking = false;
      notifyListeners();
    }
  }

  void setPermissionDialogShown(bool value) {
    _hasShownPermissionDialog = value;
  }

  void setDialogCallback(Function(Map<String, String>) callback) {
    _dialogCallback = callback;
  }

  void clearRoute() {
    _markers = {};
    _polylines = {};
    _routePoints = [];
    notifyListeners();
  }

  @override
  void dispose() {
    stopTracking();
    super.dispose();
  }
}
