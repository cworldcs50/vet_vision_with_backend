import 'package:flutter/material.dart';

import '../../../../../../core/classes/adaptive_layout.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../data/models/user_dashboard_model.dart';

class DashboardNextAppointmentCard extends StatelessWidget {
  const DashboardNextAppointmentCard({super.key, required this.appointment});

  final DashboardNextAppointment appointment;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.surface,
      elevation: 0,
      borderRadius: BorderRadius.circular(
        AdaptiveLayout.getResponsiveFontSize(context, fontSize: 12),
      ),
      child: Container(
        padding: EdgeInsets.all(
          AdaptiveLayout.getResponsiveFontSize(context, fontSize: 14),
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            AdaptiveLayout.getResponsiveFontSize(context, fontSize: 12),
          ),
          border: Border.all(color: AppColors.border),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Next appointment',
              style: TextStyle(
                fontSize: AdaptiveLayout.getResponsiveFontSize(
                  context,
                  fontSize: 13,
                ),
                fontWeight: FontWeight.w600,
                color: AppColors.textSecondary,
              ),
            ),
            SizedBox(
              height: AdaptiveLayout.getResponsiveFontSize(
                context,
                fontSize: 8,
              ),
            ),
            Text(
              appointment.dateTime,
              style: TextStyle(
                fontSize: AdaptiveLayout.getResponsiveFontSize(
                  context,
                  fontSize: 15,
                ),
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            SizedBox(
              height: AdaptiveLayout.getResponsiveFontSize(
                context,
                fontSize: 6,
              ),
            ),
            Text(
              '${appointment.doctor.name} · ${appointment.doctor.specialization}',
              style: TextStyle(
                fontSize: AdaptiveLayout.getResponsiveFontSize(
                  context,
                  fontSize: 13,
                ),
                color: AppColors.textPrimary,
              ),
            ),
            Text(
              '${appointment.animal.name} (${appointment.animal.species})',
              style: TextStyle(
                fontSize: AdaptiveLayout.getResponsiveFontSize(
                  context,
                  fontSize: 12,
                ),
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

