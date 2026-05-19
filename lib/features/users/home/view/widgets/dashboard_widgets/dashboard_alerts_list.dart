import 'package:flutter/material.dart';

import '../../../../../../core/classes/adaptive_layout.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../data/models/user_dashboard_model.dart';

class DashboardAlertsList extends StatelessWidget {
  const DashboardAlertsList({super.key, required this.alerts});

  final List<DashboardMedicalAlert> alerts;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: alerts.map((a) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: AdaptiveLayout.getResponsiveFontSize(context, fontSize: 8),
          ),
          child: Material(
            color: AppColors.warning.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(
              AdaptiveLayout.getResponsiveFontSize(context, fontSize: 10),
            ),
            child: Padding(
              padding: EdgeInsets.all(
                AdaptiveLayout.getResponsiveFontSize(context, fontSize: 12),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.info_outline,
                    color: AppColors.warning,
                    size: AdaptiveLayout.getResponsiveFontSize(
                      context,
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(
                    width: AdaptiveLayout.getResponsiveFontSize(
                      context,
                      fontSize: 8,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      a.message,
                      style: TextStyle(
                        fontSize: AdaptiveLayout.getResponsiveFontSize(
                          context,
                          fontSize: 13,
                        ),
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}

