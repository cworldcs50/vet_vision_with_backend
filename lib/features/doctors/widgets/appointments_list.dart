import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../doctor_portal_controller.dart';
import 'appointment_card_detailed.dart';
import '../../../core/classes/adaptive_layout.dart';

class AppointmentsList extends GetView<DoctorPortalController> {
  const AppointmentsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final filtered = controller.filteredAppointments;
      if (filtered.isEmpty) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.calendar_today_outlined,
                size: AdaptiveLayout.getResponsiveFontSize(
                  context,
                  fontSize: 60,
                ),
                color: Colors.grey.shade200,
              ),
              SizedBox(
                height: AdaptiveLayout.getResponsiveFontSize(
                  context,
                  fontSize: 16,
                ),
              ),
              Text(
                "No appointments found",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: AdaptiveLayout.getResponsiveFontSize(
                    context,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
        );
      }
      return ListView.separated(
        padding: EdgeInsets.all(
          AdaptiveLayout.getResponsiveFontSize(context, fontSize: 20),
        ),
        itemCount: filtered.length,
        separatorBuilder:
            (context, index) => SizedBox(
              height: AdaptiveLayout.getResponsiveFontSize(
                context,
                fontSize: 16,
              ),
            ),
        itemBuilder:
            (context, index) =>
                AppointmentCardDetailed(appointment: filtered[index]),
      );
    });
  }
}
