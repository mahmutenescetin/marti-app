import 'package:flutter/material.dart';
import 'package:marti_app/app/core/localization/context_localization_extension.dart';

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
            _InfoRow(title: '${context.l10n.time}:', value: locationInfo['date'] ?? ''),
            _InfoRow(
              title: '${context.l10n.latitude}:',
              value: locationInfo['latitude'] ?? '',
            ),
            _InfoRow(
              title: '${context.l10n.longitude}:',
              value: locationInfo['longitude'] ?? '',
            ),
            const SizedBox(height: 16),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text(context.l10n.close),
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
