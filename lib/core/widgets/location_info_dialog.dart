import 'package:flutter/material.dart';

class LocationInfoDialog extends StatelessWidget {
  final Map<String, String> locationInfo;

  const LocationInfoDialog({required this.locationInfo, super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Location ${locationInfo['id']?.split('-')[0] ?? ''}',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            _InfoRow(title: 'DateTime:', value: locationInfo['date'] ?? ''),
            _InfoRow(
              title: 'Speed:',
              value: '${locationInfo['speed'] ?? ''} km/h',
            ),
            _InfoRow(title: 'Latitude:', value: locationInfo['latitude'] ?? ''),
            _InfoRow(
              title: 'Longitude:',
              value: locationInfo['longitude'] ?? '',
            ),
            _InfoRow(
              title: 'Altitude:',
              value: '${locationInfo['altitude'] ?? ''}m',
            ),
            const SizedBox(height: 16),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Close'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String title;
  final String value;

  const _InfoRow({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Text(
            title,
            style: Theme.of(
              context,
            ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(value, style: Theme.of(context).textTheme.bodyLarge),
          ),
        ],
      ),
    );
  }
}
