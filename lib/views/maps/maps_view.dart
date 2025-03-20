import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:marti_app/core/base_view/scaffold_view.dart';
import 'package:marti_app/core/theme/context_extension.dart';
import 'package:marti_app/viewmodels/maps_viewmodel.dart';
import 'package:provider/provider.dart';

class MapsView extends StatelessWidget {
  const MapsView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MapsViewModel(),
      child: Consumer<MapsViewModel>(
        builder: (context, viewModel, child) {
          return ScaffoldView(
            appBarTitle: 'Location Tracking',
            body: Stack(
              children: [
                GoogleMap(
                  initialCameraPosition: const CameraPosition(
                    target: LatLng(41.0082, 28.9784),
                    zoom: 16,
                  ),
                  onMapCreated: (controller) {
                    viewModel.onMapCreated(controller);
                  },
                  myLocationEnabled: true,
                  myLocationButtonEnabled: true,
                  zoomControlsEnabled: true,
                  zoomGesturesEnabled: true,
                  mapToolbarEnabled: false,
                ),
                if (!viewModel.isMapInitialized)
                  Container(
                    color: context.surfaceColor,
                    child: const Center(
                      child: CircularProgressIndicator(),
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
