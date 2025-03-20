import 'package:flutter/material.dart';
import 'package:marti_app/core/base_view/scaffold_view.dart';
import 'package:marti_app/core/theme/context_extension.dart';
import 'package:marti_app/views/maps/maps_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  Future<void> _handleMapNavigation(BuildContext context) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const MapsView(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldView(
      appBarTitle: 'Marti App',
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
                    colors: [
                      context.primaryColor,
                      context.secondaryColor,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Welcome!',
                      style: context.textStyles.h1.copyWith(
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Marti Example App is a sample application that follows your location and shows it on the map.',
                      style: context.textStyles.bodyLarge.copyWith(
                        color: Colors.white.withOpacity(0.9),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'Quick Actions',
                style: context.textStyles.h2,
              ),
              const SizedBox(height: 16),
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                children: [
                  _buildFeatureCard(
                    context,
                    icon: Icons.map,
                    title: 'Maps  ',
                    subtitle: 'Location tracking and map view',
                    onTap: () => _handleMapNavigation(context),
                  ),
                  _buildFeatureCard(
                    context,
                    icon: Icons.schedule,
                    title: 'Marker List',
                    subtitle: 'Before you go, check the list',
                    onTap: () {},
                  ),
                  _buildFeatureCard(
                    context,
                    icon: Icons.payment,
                    title: 'Payment History',
                    subtitle: 'See your payment history',
                    onTap: () {},
                  ),
                  _buildFeatureCard(
                    context,
                    icon: Icons.settings,
                    title: 'Application Settings',
                    subtitle: 'See Application settings',
                    onTap: () {},
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: context.surfaceColor,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 32,
              color: context.primaryColor,
            ),
            const SizedBox(height: 12),
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
              style: context.textStyles.bodySmall.copyWith(
                color: context.textSecondaryColor,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
