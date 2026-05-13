import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../../core/classes/adaptive_layout.dart';
import '../doctor_portal_controller.dart';

class FilterPill extends GetView<DoctorPortalController> {
  final String title;
  const FilterPill({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final bool isSelected = controller.selectedFilter.value == title;
      return GestureDetector(
        onTap: () => controller.selectedFilter.value = title,
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: AdaptiveLayout.getResponsiveFontSize(
              context,
              fontSize: 16,
            ),
            vertical: AdaptiveLayout.getResponsiveFontSize(
              context,
              fontSize: 8,
            ),
          ),
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFF009689) : Colors.grey.shade50,
            borderRadius: BorderRadius.circular(
              AdaptiveLayout.getResponsiveFontSize(context, fontSize: 20),
            ),
          ),
          child: Text(
            title,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.black54,
              fontSize: AdaptiveLayout.getResponsiveFontSize(
                context,
                fontSize: 12,
              ),
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
      );
    });
  }
}

