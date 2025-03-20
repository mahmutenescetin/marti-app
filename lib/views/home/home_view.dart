import 'package:flutter/material.dart';
import 'package:marti_app/views/maps/maps_view.dart';

class CounterView extends StatelessWidget {
  const CounterView({super.key});

  Future<void> _handleMapNavigation(BuildContext context) async {
    MaterialPageRoute(
      builder: (context) => const MapsView(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('home view'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => _handleMapNavigation(context),
              child: const Text(
                'Open Maps',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
