import 'package:flutter/material.dart';
import 'package:marti_app/app/common/utils/dialog_util.dart' show DialogUtil;
import 'package:marti_app/app/core/base/scaffold_view.dart';
import 'package:marti_app/app/core/localization/context_localization_extension.dart';
import 'package:marti_app/app/common/widgets/location_info_dialog.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:marti_app/app/features/maps/manager/location_tracking_manager.dart';
import 'package:marti_app/app/features/maps/presentation/viewmodel/maps_viewmodel.dart';
import 'package:provider/provider.dart';

class MapsView extends StatelessWidget {
  const MapsView({super.key});

  Future<void> _handleClearRoute(BuildContext context) async {
    final shouldClear = await DialogUtil.instance.showConfirmationDialog(
      context: context,
      title: context.l10n.clearRoute,
      content: context.l10n.clearRouteConfirmation,
      confirmText: context.l10n.clear,
      cancelText: context.l10n.cancel,
    );

    if (shouldClear == true) {
      if (context.mounted) {
        context.read<LocationTrackingManager>().clearRoute();
      }
    }
  }

  void _showLocationInfo(BuildContext context, Map<String, String> locationInfo) {
    showDialog(
      context: context,
      builder: (context) => LocationInfoDialog(locationInfo: locationInfo),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldView(
      appBarTitle: context.l10n.maps,
      appBarActions: [
        IconButton(
          icon: const Icon(Icons.delete),
          onPressed: () => _handleClearRoute(context),
        ),
      ],
      body: ChangeNotifierProvider(
        create: (context) {
          final viewModel = MapsViewModel(context.read<LocationTrackingManager>());
          context.read<LocationTrackingManager>().setDialogCallback(
                (locationInfo) => _showLocationInfo(context, locationInfo),
              );
          return viewModel;
        },
        child: Consumer<MapsViewModel>(
          builder: (context, viewModel, child) {
            return Stack(
              children: [
                GoogleMap(
                  initialCameraPosition: const CameraPosition(
                    target: LatLng(41.0082, 28.9784),
                    zoom: 15,
                  ),
                  myLocationEnabled: true,
                  myLocationButtonEnabled: true,
                  markers: viewModel.markers,
                  polylines: viewModel.polylines,
                ),
                if (viewModel.isLoading)
                  const Center(
                    child: CircularProgressIndicator(),
                  ),
                Positioned(
                  bottom: 16,
                  left: 16,
                  child: Consumer<LocationTrackingManager>(
                    builder: (context, locationManager, child) {
                      final isTracking = locationManager.isTracking;
                      return FloatingActionButton(
                        onPressed: () {
                          if (isTracking) {
                            locationManager.stopTracking(
                              isStopButtonPressed: true,
                            );
                          } else {
                            locationManager.startTracking();
                          }
                        },
                        child: Icon(
                          isTracking ? Icons.stop : Icons.play_arrow,
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
