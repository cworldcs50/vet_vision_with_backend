import 'package:get/get.dart';
import '../doctor_portal_controller.dart';
import '../widgets/portal_header.dart';
import 'package:flutter/material.dart';
import 'profile/doctor_profile_view.dart';
import 'dashboard/doctor_dashboard_view.dart';
import 'appointments/view/doctor_appointments_view.dart';

class DoctorPortalMainView extends GetView<DoctorPortalController> {
  const DoctorPortalMainView({super.key});

  @override
  Widget build(BuildContext context) {
    if (!Get.isRegistered<DoctorPortalController>()) {
      Get.put(DoctorPortalController());
    }

    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(onPressed: () {}),
      body: SafeArea(
        child: Column(
          children: [
            const PortalHeader(),
            Expanded(
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
          ],
        ),
      ),
    );
  }
}
