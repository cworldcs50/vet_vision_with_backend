import 'package:flutter/material.dart';

import '../../../../../../core/classes/adaptive_layout.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../data/models/user_dashboard_model.dart';
import 'dashboard_stat_chip.dart';

class DashboardStatsRow extends StatelessWidget {
  const DashboardStatsRow({super.key, required this.dashboard});

  final UserDashboardModel dashboard;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: AdaptiveLayout.getResponsiveFontSize(context, fontSize: 10),
      runSpacing: AdaptiveLayout.getResponsiveFontSize(context, fontSize: 10),
      children: [
        DashboardStatChip(
          label: 'Upcoming',
          value: dashboard.upcomingAppointments.toString(),
          color: AppColors.primary,
        ),
        DashboardStatChip(
          label: 'Pets',
          value: dashboard.totalAnimals.toString(),
          color: AppColors.accent,
        ),
        DashboardStatChip(
          label: 'Completed',
          value: dashboard.completedAppointments.toString(),
          color: AppColors.success,
        ),
        DashboardStatChip(
          label: 'Pending',
          value: dashboard.pendingAppointments.toString(),
          color: AppColors.warning,
        ),
      ],
    );
  }
}

