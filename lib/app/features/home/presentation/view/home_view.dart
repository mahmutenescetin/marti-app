import 'package:flutter/material.dart';
import 'package:marti_app/app/core/base/scaffold_view.dart';
import 'package:marti_app/app/core/localization/context_localization_extension.dart';
import 'package:marti_app/app/core/localization/localization_manager.dart';
import 'package:marti_app/app/common/theme/context_extension.dart';
import 'package:marti_app/app/features/maps/presentation/view/maps_view.dart';
import 'package:provider/provider.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  Future<void> _handleMapNavigation(BuildContext context) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const MapsView()),
    );
  }

  void _handleLanguageChange(BuildContext context) {
    final currentLocale = context.read<LocalizationManager>().currentLocale;
    final newLocale =
        currentLocale.languageCode == 'tr'
            ? const Locale('en')
            : const Locale('tr');
    context.changeLocale(newLocale);
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldView(
      appBarTitle: context.l10n.appTitle,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [context.primaryColor, context.secondaryColor],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      context.l10n.welcome,
                      style: context.textStyles.h1.copyWith(
                        color: context.textPrimaryColor,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      context.l10n.appDescription,
                      style: context.textStyles.bodyLarge.copyWith(
                        color: context.textPrimaryColor,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Text(context.l10n.quickActions, style: context.textStyles.h2),
              const SizedBox(height: 16),
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                children: [
                  FeatureCard(
                    icon: Icons.map,
                    title: context.l10n.maps,
                    subtitle: context.l10n.mapsDescription,
                    onTap: () => _handleMapNavigation(context),
                  ),
                  FeatureCard(
                    icon: Icons.schedule,
                    title: context.l10n.markerList,
                    subtitle: context.l10n.markerListDescription,
                    onTap: () {},
                  ),
                  FeatureCard(
                    icon: Icons.payment,
                    title: context.l10n.paymentHistory,
                    subtitle: context.l10n.paymentHistoryDescription,
                    onTap: () {},
                  ),
                  Consumer<LocalizationManager>(
                    builder: (context, manager, child) {
                      return FeatureCard(
                        icon: Icons.language,
                        title: context.l10n.switchLanguageButton,
                        subtitle: context.l10n.switchLanguageDescription,
                        onTap: () => _handleLanguageChange(context),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FeatureCard extends StatelessWidget {
  const FeatureCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
    super.key,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 32, color: context.primaryColor),
              const SizedBox(height: 8),
              Text(
                title,
                style: context.textStyles.bodyLarge.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: context.textStyles.bodySmall,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
