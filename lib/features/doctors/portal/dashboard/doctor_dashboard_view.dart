import 'package:get/get.dart';
import '../../../../core/network/request_status.dart';
import '../../../../core/theme/app_colors.dart';
import '../../doctor_portal_controller.dart';
import '../../widgets/stats_grid.dart';
import '../../widgets/welcome_box.dart';
import 'package:flutter/material.dart';
import '../../widgets/today_schedule_list.dart';
import '../../widgets/today_schedule_header.dart';
import '../../../../core/classes/adaptive_layout.dart';

class DoctorDashboardView extends GetView<DoctorPortalController> {
  const DoctorDashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => controller.loadDashboardData(),
      color: AppColors.accent,
      child: Obx(() {
        if (controller.status.value == RequestStatus.loading) {
          return const Center(
            child: CircularProgressIndicator(color: AppColors.accent),
          );
        }

        if (controller.status.value == RequestStatus.failure) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.error_outline,
                  size: AdaptiveLayout.getResponsiveFontSize(
                    context,
                    fontSize: 48,
                  ),
                  color: Colors.red,
                ),
                SizedBox(
                  height: AdaptiveLayout.getResponsiveFontSize(
                    context,
                    fontSize: 16,
                  ),
                ),
                const Text("Failed to load dashboard"),
                TextButton(
                  onPressed: () async => await controller.loadDashboardData(),
                  child: const Text(
                    "Retry",
                    style: TextStyle(color: Color(0xFF009689)),
                  ),
                ),
              ],
            ),
          );
        }

        return SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: EdgeInsets.all(
            AdaptiveLayout.getResponsiveFontSize(context, fontSize: 20),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const WelcomeBox(),
              SizedBox(
                height: AdaptiveLayout.getResponsiveFontSize(
                  context,
                  fontSize: 24,
                ),
              ),
              const StatsGrid(),
              SizedBox(
                height: AdaptiveLayout.getResponsiveFontSize(
                  context,
                  fontSize: 24,
                ),
              ),
              const TodayScheduleHeader(),
              SizedBox(
                height: AdaptiveLayout.getResponsiveFontSize(
                  context,
                  fontSize: 12,
                ),
              ),
              const TodayScheduleList(),
            ],
          ),
        );
      }),
    );
  }
}
