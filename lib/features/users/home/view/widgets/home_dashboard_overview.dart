import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/classes/adaptive_layout.dart';
import '../../../../../core/network/request_status.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../controller/home_controller.dart';
import 'dashboard_widgets/dashboard_alerts_list.dart';
import 'dashboard_widgets/dashboard_error_card.dart';
import 'dashboard_widgets/dashboard_next_appointment_card.dart';
import 'dashboard_widgets/dashboard_stats_row.dart';

/// Summary cards for `GET /user/dashboard` (Laravel user role).
class HomeDashboardOverview extends StatelessWidget {
  const HomeDashboardOverview({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (controller) {
        final padding = AdaptiveLayout.getResponsiveFontSize(
          context,
          fontSize: 20,
        );

        if (controller.dashboardStatus == RequestStatus.loading) {
          return Padding(
            padding: EdgeInsets.symmetric(
              horizontal: padding,
              vertical: AdaptiveLayout.getResponsiveFontSize(
                context,
                fontSize: 8,
              ),
            ),
            child: Center(
              child: SizedBox(
                height: AdaptiveLayout.getResponsiveFontSize(
                  context,
                  fontSize: 32,
                ),
                width: AdaptiveLayout.getResponsiveFontSize(
                  context,
                  fontSize: 32,
                ),
                child: CircularProgressIndicator(
                  strokeWidth: AdaptiveLayout.getResponsiveFontSize(
                    context,
                    fontSize: 2,
                  ),
                ),
              ),
            ),
          );
        }

        if (controller.dashboardStatus != RequestStatus.success ||
            controller.userDashboard == null) {
          return Padding(
            padding: EdgeInsets.symmetric(
              horizontal: padding,
              vertical: AdaptiveLayout.getResponsiveFontSize(
                context,
                fontSize: 8,
              ),
            ),
            child: DashboardErrorCard(
              message: controller.dashboardErrorMessage,
              onRetry: controller.fetchUserDashboard,
            ),
          );
        }

        final d = controller.userDashboard!;
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: padding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Your overview',
                style: TextStyle(
                  fontSize: AdaptiveLayout.getResponsiveFontSize(
                    context,
                    fontSize: 16,
                  ),
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              SizedBox(
                height: AdaptiveLayout.getResponsiveFontSize(
                  context,
                  fontSize: 12,
                ),
              ),
              DashboardStatsRow(dashboard: d),
              if (d.medicalAlerts.isNotEmpty) ...[
                SizedBox(
                  height: AdaptiveLayout.getResponsiveFontSize(
                    context,
                    fontSize: 12,
                  ),
                ),
                DashboardAlertsList(alerts: d.medicalAlerts),
              ],
              if (d.nextAppointment != null) ...[
                SizedBox(
                  height: AdaptiveLayout.getResponsiveFontSize(
                    context,
                    fontSize: 12,
                  ),
                ),
                DashboardNextAppointmentCard(appointment: d.nextAppointment!),
              ],
              SizedBox(
                height: AdaptiveLayout.getResponsiveFontSize(
                  context,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
