import 'package:get/get.dart';
import '../doctor_portal_controller.dart';
import 'appointment_card_mini.dart';
import 'package:flutter/material.dart';
import '../../../core/classes/adaptive_layout.dart';

class TodayScheduleList extends GetView<DoctorPortalController> {
  const TodayScheduleList({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final schedule = controller.todaySchedule;
      if (schedule.isEmpty) {
        return Center(
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: AdaptiveLayout.getResponsiveFontSize(
                context,
                fontSize: 20,
              ),
            ),
            child: Text(
              "No appointments for today",
              style: TextStyle(
                color: Colors.grey,
                fontSize: AdaptiveLayout.getResponsiveFontSize(
                  context,
                  fontSize: 14,
                ),
              ),
            ),
          ),
        );
      }
      return ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: schedule.length,
        separatorBuilder:
            (context, index) => SizedBox(
              height: AdaptiveLayout.getResponsiveFontSize(
                context,
                fontSize: 12,
              ),
            ),
        itemBuilder:
            (context, index) =>
                AppointmentCardMini(appointment: schedule[index]),
      );
    });
  }
}
