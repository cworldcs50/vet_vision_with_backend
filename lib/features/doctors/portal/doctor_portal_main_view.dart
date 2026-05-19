import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/classes/adaptive_layout.dart';
import '../../../../core/theme/app_colors.dart';
import '../doctor_portal_controller.dart';
import '../widgets/nav_button.dart';
import 'appointments/view/doctor_appointments_view.dart';
import 'dashboard/doctor_dashboard_view.dart';
import 'profile/doctor_profile_view.dart';

class DoctorPortalMainView extends StatelessWidget {
  const DoctorPortalMainView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(DoctorPortalController());

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppColors.accent,
        elevation: 0,
        centerTitle: true,
        title: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Doctor Portal",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: AdaptiveLayout.getResponsiveFontSize(
                  context,
                  fontSize: 16,
                ),
              ),
            ),
            Text(
              controller.doctorName,
              style: TextStyle(
                color: Colors.white70,
                fontSize: AdaptiveLayout.getResponsiveFontSize(
                  context,
                  fontSize: 11,
                ),
              ),
            ),
          ],
        ),

        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.white),
            onPressed: () => controller.logout(),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(
            AdaptiveLayout.getResponsiveFontSize(context, fontSize: 56),
          ),
          child: Obx(
            () => Container(
              margin: EdgeInsets.all(
                AdaptiveLayout.getResponsiveFontSize(context, fontSize: 8),
              ),
              padding: EdgeInsets.all(
                AdaptiveLayout.getResponsiveFontSize(context, fontSize: 4),
              ),
              decoration: BoxDecoration(
                color: Colors.white24,
                borderRadius: BorderRadius.circular(
                  AdaptiveLayout.getResponsiveFontSize(context, fontSize: 12),
                ),
              ),
              child: Row(
                children: [
                  NavButton(
                    title: "Dashboard",
                    index: 0,
                    icon: Icons.dashboard_outlined,
                    isSelected: controller.selectedIndex.value == 0,
                  ),
                  NavButton(
                    title: "Appointments",
                    index: 1,
                    icon: Icons.calendar_today_outlined,
                    isSelected: controller.selectedIndex.value == 1,
                  ),
                  NavButton(
                    title: "Profile",
                    index: 2,
                    icon: Icons.person_outline,
                    isSelected: controller.selectedIndex.value == 2,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Obx(() {
          switch (controller.selectedIndex.value) {
            case 0:
              return const DoctorDashboardView();
            case 1:
              return const DoctorAppointmentsView();
            case 2:
              return const DoctorProfileView();
            default:
              return const DoctorDashboardView();
          }
        }),
      ),
    );
  }
}
