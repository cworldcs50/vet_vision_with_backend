import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../../core/classes/adaptive_layout.dart';
import '../doctor_portal_controller.dart';

class WelcomeBox extends GetView<DoctorPortalController> {
  const WelcomeBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(
        AdaptiveLayout.getResponsiveFontSize(context, fontSize: 20),
      ),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF009689), Color(0xFF00BFA5)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(
          AdaptiveLayout.getResponsiveFontSize(context, fontSize: 20),
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF009689).withValues(alpha: 0.3),
            blurRadius: AdaptiveLayout.getResponsiveFontSize(
              context,
              fontSize: 10,
            ),
            offset: Offset(
              0,
              AdaptiveLayout.getResponsiveFontSize(context, fontSize: 4),
            ),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                "Welcome back, ${controller.fullNameController.text}! 🩺",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: AdaptiveLayout.getResponsiveFontSize(
                    context,
                    fontSize: 13,
                  ),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(
            height: AdaptiveLayout.getResponsiveFontSize(context, fontSize: 8),
          ),
          Obx(
            () => Text(
              "You have ${controller.todayAppointmentsCount.value} appointments scheduled for today",
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.9),
                fontSize: AdaptiveLayout.getResponsiveFontSize(
                  context,
                  fontSize: 13,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
