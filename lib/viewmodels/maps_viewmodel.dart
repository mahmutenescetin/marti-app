import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapsViewModel extends ChangeNotifier {
  GoogleMapController? mapController;
  bool isMapInitialized = false;

  void onMapCreated(GoogleMapController controller) {
    mapController = controller;
    isMapInitialized = true;
    notifyListeners();
  }

  @override
  void dispose() {
    mapController!.dispose();
    super.dispose();
  }
}
