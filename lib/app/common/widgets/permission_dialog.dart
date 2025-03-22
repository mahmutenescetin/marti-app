import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionDialog extends StatelessWidget {
  const PermissionDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Location Permission Required'),
      content: const Text(
        'We need location permission to use the map. '
            'Please enable location permission in the app settings.',
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () async {
            await openAppSettings();
            if (context.mounted) {
              Navigator.pop(context);
            }
          },
          child: const Text('Go to Settings'),
        ),
      ],
    );
  }
}
