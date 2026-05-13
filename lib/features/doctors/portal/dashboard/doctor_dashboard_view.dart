import 'package:get/get.dart';
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
    return SingleChildScrollView(
      padding: EdgeInsets.all(
        AdaptiveLayout.getResponsiveFontSize(context, fontSize: 20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const WelcomeBox(),
          SizedBox(
            height: AdaptiveLayout.getResponsiveFontSize(context, fontSize: 24),
          ),
          const StatsGrid(),
          SizedBox(
            height: AdaptiveLayout.getResponsiveFontSize(context, fontSize: 24),
          ),
          const TodayScheduleHeader(),
          SizedBox(
            height: AdaptiveLayout.getResponsiveFontSize(context, fontSize: 12),
          ),
          const TodayScheduleList(),
        ],
      ),
    );
  }
}
