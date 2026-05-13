import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../../core/classes/adaptive_layout.dart';
import '../doctor_portal_controller.dart';

class TodayScheduleHeader extends StatelessWidget {
  const TodayScheduleHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Today's Schedule",
          style: TextStyle(
            fontSize: AdaptiveLayout.getResponsiveFontSize(
              context,
              fontSize: 16,
            ),
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        TextButton(
          onPressed:
              () => Get.find<DoctorPortalController>().selectedIndex.value = 1,
          child: Text(
            "7 appointments",
            style: TextStyle(
              fontSize: AdaptiveLayout.getResponsiveFontSize(
                context,
                fontSize: 12,
              ),
              color: const Color(0xFF009689),
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ],
    );
  }
}
