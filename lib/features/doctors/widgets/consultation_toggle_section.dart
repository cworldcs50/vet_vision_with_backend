import '../doctor_portal_controller.dart';
import 'toggle_row.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../../core/classes/adaptive_layout.dart';

class ConsultationToggleSection extends GetView<DoctorPortalController> {
  const ConsultationToggleSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Obx(
          () => ToggleRow(
            title: "Online Consultation",
            value: controller.isOnlineConsultation.value,
            onChanged: (v) => controller.isOnlineConsultation.value = v,
          ),
        ),
        SizedBox(
          height: AdaptiveLayout.getResponsiveFontSize(context, fontSize: 12),
        ),
        Obx(
          () => ToggleRow(
            title: "In-Person Consultation",
            value: controller.isInPersonConsultation.value,
            onChanged: (v) => controller.isInPersonConsultation.value = v,
          ),
        ),
      ],
    );
  }
}
