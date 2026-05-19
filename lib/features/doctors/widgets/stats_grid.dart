import 'package:get/get.dart';
import '../doctor_portal_controller.dart';
import 'stat_card_doctor.dart';
import 'package:flutter/material.dart';
import '../../../core/classes/adaptive_layout.dart';

class StatsGrid extends GetView<DoctorPortalController> {
  const StatsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      crossAxisSpacing: AdaptiveLayout.getResponsiveFontSize(
        context,
        fontSize: 16,
      ),
      mainAxisSpacing: AdaptiveLayout.getResponsiveFontSize(
        context,
        fontSize: 16,
      ),
      childAspectRatio: 1.6,
      children: [
        Obx(
          () => StatCardDoctor(
            title: "Today's Appointments",
            value: "${controller.todayAppointmentsCount.value}",
            icon: Icons.calendar_today,
            iconColor: const Color(0xFF009689),
          ),
        ),
        Obx(
          () => StatCardDoctor(
            title: "Total Patients",
            value: "${controller.totalPatientsCount.value}",
            icon: Icons.people_outline,
            iconColor: Colors.blue,
          ),
        ),
        Obx(
          () => StatCardDoctor(
            title: "This Month",
            value: "\$${controller.monthlyEarnings.value.toStringAsFixed(0)}",
            icon: Icons.attach_money,
            iconColor: Colors.green,
          ),
        ),
        Obx(
          () => StatCardDoctor(
            title: "Growth",
            value: controller.growthPercentage.value,
            icon: Icons.trending_up,
            iconColor: Colors.purple,
          ),
        ),
      ],
    );
  }
}
