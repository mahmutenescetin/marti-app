import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:permission_handler/permission_handler.dart' as permission;

typedef LocationInfoCallback = void Function(Map<String, String> locationInfo);

/// Manages location tracking, route recording, and marker management for the maps feature.
/// 
/// Responsibilities:
/// - Handles location permissions and service status
/// - Tracks user location in real-time
/// - Manages route points and creates polylines
/// - Handles markers for location points
/// - Provides callbacks for location information display
class LocationTrackingManager extends ChangeNotifier {
  final Location _location = Location();
  StreamSubscription<LocationData>? _locationSubscription;
  final List<LatLng> _routePoints = [];
  Set<Marker> _markers = {};
  Set<Polyline> _polylines = {};
  LocationInfoCallback? _dialogCallback;
  bool _isDisposed = false;
  bool _isTracking = false;

  Set<Marker> get markers => _markers;

  Set<Polyline> get polylines => _polylines;

  List<LatLng> get routePoints => _routePoints;

  bool get isTracking => _isTracking;

  void setDialogCallback(LocationInfoCallback callback) {
    _dialogCallback = callback;
  }

  void _safeNotifyListeners() {
    if (_isDisposed) {
      return;
    }

    if (SchedulerBinding.instance.schedulerPhase == SchedulerPhase.idle) {
      notifyListeners();
    } else {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        if (!_isDisposed) {
          notifyListeners();
        }
      });
    }
  }

  Future<bool> requestPermission() async {
    try {
      final serviceEnabled = await _location.serviceEnabled();
      if (!serviceEnabled) {
        final serviceRequest = await _location.requestService();
        if (!serviceRequest) {
          debugPrint('Location service is not enabled');
          return false;
        }
      }

      var permissionStatus = await _location.hasPermission();
      if (permissionStatus == PermissionStatus.denied) {
        permissionStatus = await _location.requestPermission();
        if (permissionStatus != PermissionStatus.granted) {
          debugPrint('Location permission denied');
          return false;
        }
      }

      final backgroundPermission =
          await permission.Permission.locationAlways.request();
      if (!backgroundPermission.isGranted) {
        debugPrint('Background location permission denied');
      }

      debugPrint('All permissions granted');
      return true;
    } catch (e) {
      debugPrint('permission error: $e');
      return false;
    }
  }

  Future<void> startTracking() async {
    if (_locationSubscription != null || _isTracking) {
      debugPrint('Location tracking is already started');
      return;
    }

    final hasPermission = await requestPermission();
    if (!hasPermission) {
      debugPrint(
        'Location tracking could not be started due to lack of permissions',
      );
      return;
    }

    try {
      await _location.changeSettings(
        accuracy: LocationAccuracy.high,
        interval: 5000,
        distanceFilter: 10,
      );

      _isTracking = true;
      _safeNotifyListeners();

      debugPrint('location tracking started');
      _locationSubscription = _location.onLocationChanged.listen(
        (locationData) {
          if (_isDisposed) {
            return;
          }

          debugPrint(
            'New location added: ${locationData.latitude}, ${locationData.longitude}',
          );

          final position = LatLng(
            locationData.latitude ?? 0,
            locationData.longitude ?? 0,
          );

          _routePoints.add(position);

          final newMarker = Marker(
            markerId: MarkerId(DateTime.now().toString()),
            position: position,
            onTap: () {
              if (_dialogCallback != null) {
                _dialogCallback!({
                  'Enlem': position.latitude.toStringAsFixed(6),
                  'Boylam': position.longitude.toStringAsFixed(6),
                  'Tarih': DateTime.now().toString(),
                });
              }
            },
          );

          _markers = Set<Marker>.from(_markers)..add(newMarker);
          debugPrint('New marker added. Marker count is: ${_markers.length}');

          if (_routePoints.length > 1) {
            final newPolyline = Polyline(
              polylineId: const PolylineId('route'),
              points: _routePoints,
              color: Colors.blue,
              width: 5,
            );

            _polylines = {newPolyline};
          }

          _safeNotifyListeners();
        },
        onError: (e) {
          debugPrint('Location tracking error $e');
        },
      );
    } catch (e) {
      debugPrint('Location tracking start error: $e');
    }
  }

  void stopTracking({required bool isStopButtonPressed}) {
    if (!_isTracking) {
      return;
    }

    debugPrint('Location tracking stopped');
    if (!isStopButtonPressed) {
      _routePoints.clear();
      _markers = {};
      _polylines = {};
    }
    _locationSubscription?.cancel();
    _locationSubscription = null;
    _isTracking = false;

    SchedulerBinding.instance.addPostFrameCallback((_) {
      if (!_isDisposed) {
        notifyListeners();
      }
    });

    debugPrint('Location tracking stopped');
  }

  void clearRoute() {
    if (_isDisposed) {
      return;
    }

    _routePoints.clear();
    _markers = {};
    _polylines = {};
    _safeNotifyListeners();
  }

  @override
  void dispose() {
    _isDisposed = true;
    stopTracking(isStopButtonPressed: false);
    super.dispose();
  }
}
