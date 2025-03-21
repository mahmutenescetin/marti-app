import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:marti_app/core/base_view/scaffold_view.dart';

import 'package:marti_app/core/utils/dialog_util.dart' show DialogUtil;
import 'package:marti_app/core/widgets/location_info_dialog.dart'
    show LocationInfoDialog;
import 'package:marti_app/services/location_service.dart' show LocationService;
import 'package:marti_app/viewmodels/maps_viewmodel.dart';
import 'package:provider/provider.dart';

class MapsView extends StatelessWidget {
  const MapsView({super.key});

  void _showLocationInfoDialog(
    BuildContext context,
    Map<String, String> locationInfo,
  ) {
    DialogUtil.instance.show(
      context,
      child: LocationInfoDialog(locationInfo: locationInfo),
    );
  }

  void _showClearConfirmationDialog(BuildContext context) {
    DialogUtil.instance.show(
      context,
      child: AlertDialog(
        title: const Text('Rotayı Temizle'),
        content: const Text(
          'Tüm rota ve konum işaretleri silinecek. Emin misiniz?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('İptal'),
          ),
          TextButton(
            onPressed: () {
              context.read<LocationService>().clearRoute();
              Navigator.of(context).pop();
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Temizle'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) {
        final viewModel = MapsViewModel(context.read<LocationService>())
          ..startTracking();
        context.read<LocationService>().setDialogCallback(
          (locationInfo) => _showLocationInfoDialog(context, locationInfo),
        );
        return viewModel;
      },
      child: Consumer<MapsViewModel>(
        builder: (context, viewModel, child) {
          final initialPosition = viewModel.initialPosition;

          return ScaffoldView(
            appBarTitle: 'Location Tracking',
            body: Stack(
              children: [
                GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: initialPosition ?? const LatLng(41.0082, 28.9784),
                    zoom: initialPosition != null ? 16 : 14,
                  ),
                  markers: viewModel.markers,
                  polylines: viewModel.polylines,
                  onMapCreated: (controller) {
                    viewModel.onMapCreated(controller);

                    if (initialPosition != null) {
                      controller.animateCamera(
                        CameraUpdate.newLatLngZoom(initialPosition, 16),
                      );
                    }
                  },
                  myLocationEnabled: true,
                  myLocationButtonEnabled: true,
                  zoomControlsEnabled: true,
                  zoomGesturesEnabled: true,
                  mapToolbarEnabled: false,
                ),
                if (!viewModel.isMapInitialized)
                  Container(
                    color: Colors.white,
                    child: const Center(child: CircularProgressIndicator()),
                  ),

                Positioned(
                  top: 16,
                  right: 16,
                  child: FloatingActionButton(
                    heroTag: 'clear_route_button',
                    onPressed: () => _showClearConfirmationDialog(context),
                    backgroundColor: Colors.white,
                    child: const Icon(Icons.clear_all, color: Colors.red),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
