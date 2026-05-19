import '../doctor_portal_controller.dart';
import 'nav_button.dart';
import 'package:get/get.dart';
import 'header_icon_button.dart';
import 'package:flutter/material.dart';
import '../../../core/classes/adaptive_layout.dart';

class PortalHeader extends StatelessWidget {
  const PortalHeader({super.key});

  //GetView<DoctorPortalController>

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<DoctorPortalController>();

    return Obx(
      () => Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          vertical: AdaptiveLayout.getResponsiveFontSize(context, fontSize: 20),
          horizontal: AdaptiveLayout.getResponsiveFontSize(
            context,
            fontSize: 20,
          ),
        ),
        decoration: const BoxDecoration(color: Color(0xFF009689)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Spacer(flex: 2),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Doctor Portal",
                      textAlign: TextAlign.center,
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
                      controller.fullNameController.text.isNotEmpty
                          ? (controller.fullNameController.text.startsWith(
                                  "Dr.",
                                )
                                ? controller.fullNameController.text
                                : "Dr. ${controller.fullNameController.text}")
                          : "Dr. Doctor",
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
                Spacer(),
                HeaderIconButton(
                  icon: Icons.logout,
                  onPressed: () => controller.logout(),
                ),
              ],
            ),
            SizedBox(
              height: AdaptiveLayout.getResponsiveFontSize(
                context,
                fontSize: 20,
              ),
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
      ),
    );
  }
}
