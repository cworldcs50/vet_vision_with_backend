import '../doctor_portal_controller.dart';
import 'nav_button.dart';
import 'package:get/get.dart';
import 'header_icon_button.dart';
import 'package:flutter/material.dart';
import '../../../core/classes/adaptive_layout.dart';

class PortalHeader extends GetView<DoctorPortalController> {
  const PortalHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        vertical: AdaptiveLayout.getResponsiveFontSize(context, fontSize: 20),
        horizontal: AdaptiveLayout.getResponsiveFontSize(context, fontSize: 20),
      ),
      decoration: const BoxDecoration(color: Color(0xFF009689)),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              HeaderIconButton(
                icon: Icons.arrow_back,
                onPressed: () => Get.back(),
              ),
              Column(
                children: [
                  Text(
                    "Doctor Portal",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: AdaptiveLayout.getResponsiveFontSize(
                        context,
                        fontSize: 18,
                      ),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Dr. Ahmed Hassan",
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: AdaptiveLayout.getResponsiveFontSize(
                        context,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
              HeaderIconButton(
                icon: Icons.logout,
                onPressed: () => controller.logout(),
              ),
            ],
          ),
          SizedBox(
            height: AdaptiveLayout.getResponsiveFontSize(context, fontSize: 20),
          ),
          Container(
            padding: EdgeInsets.all(
              AdaptiveLayout.getResponsiveFontSize(context, fontSize: 4),
            ),
            decoration: BoxDecoration(
              color: Colors.white12,
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
        ],
      ),
    );
  }
}
