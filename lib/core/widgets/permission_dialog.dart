import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionDialog extends StatelessWidget {
  const PermissionDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Konum İzni Gerekli'),
      content: const Text(
        'Haritayı kullanabilmek için konum iznine ihtiyacımız var. '
        'Lütfen uygulama ayarlarından konum iznini etkinleştirin.',
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('İptal'),
        ),
        TextButton(
          onPressed: () async {
            await openAppSettings();
            if (context.mounted) {
              Navigator.pop(context);
            }
          },
          child: const Text('Ayarlara Git'),
        ),
      ],
    );
  }
}
