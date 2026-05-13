


import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/classes/adaptive_layout.dart';
import '../../../../../core/constants/images_constants.dart';
import '../../controller/role_selection_controller.dart';
import '../widgets/responsive_and_adaptive_role_selection/desktop_role_selection_layout.dart';
import '../widgets/responsive_and_adaptive_role_selection/mobile_role_selection_layout.dart';
import '../widgets/responsive_and_adaptive_role_selection/tablet_role_selection_layout.dart';

class RoleSelection extends StatelessWidget {
  const RoleSelection({super.key});

  @override
  Widget build(BuildContext context) {
    final RoleSelectionController controller = Get.put(
      RoleSelectionController(),
    );

    return Scaffold(
      backgroundColor: const Color(0xFF009689),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(flex: 2),
          Container(
            width: AdaptiveLayout.getResponsiveFontSize(context, fontSize: 70),
            height: AdaptiveLayout.getResponsiveFontSize(context, fontSize: 70),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(
                AdaptiveLayout.getResponsiveFontSize(context, fontSize: 20),
              ),
            ),
            padding: EdgeInsets.all(
              AdaptiveLayout.getResponsiveFontSize(context, fontSize: 12),
            ),

            child: Image.asset(
              ImagesConstants.kLogo,
              width: AdaptiveLayout.getResponsiveFontSize(
                context,
                fontSize: 60,
              ),
              height: AdaptiveLayout.getResponsiveFontSize(
                context,
                fontSize: 60,
              ),
            ),
          ),
          SizedBox(
            height: AdaptiveLayout.getResponsiveFontSize(context, fontSize: 10),
          ),
          Text(
            "Vet Vision",
            style: TextStyle(
              color: Colors.white,
              fontSize: AdaptiveLayout.getResponsiveFontSize(
                context,
                fontSize: 24,
              ),
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: AdaptiveLayout.getResponsiveFontSize(context, fontSize: 8),
          ),
          Text(
            "Your trusted veterinary care platform",
            style: TextStyle(
              color: Colors.white70,
              fontSize: AdaptiveLayout.getResponsiveFontSize(
                context,
                fontSize: 12,
              ),
            ),
          ),
          const Spacer(),
          Text(
            "WHO ARE YOU?",
            style: TextStyle(
              color: Colors.white,
              fontSize: AdaptiveLayout.getResponsiveFontSize(
                context,
                fontSize: 10,
              ),
              fontWeight: FontWeight.w600,
              letterSpacing: 1.2,
            ),
          ),
          SizedBox(
            height: AdaptiveLayout.getResponsiveFontSize(context, fontSize: 24),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: AdaptiveLayout.getResponsiveFontSize(
                context,
                fontSize: 16.0,
              ),
            ),
            child: AdaptiveLayout(
              mobileLayout: (context) =>
                  MobileRoleSelection(controller: controller),
              tabletLayout: (context) =>
                  TabletRoleSelection(controller: controller),
              desktopLayout: (context) =>
                  DesktopRoleSelection(controller: controller),
            ),
          ),
          const Spacer(flex: 2),
          Text(
            "© 2026 Vet Vision. All rights reserved.",
            style: TextStyle(
              color: Colors.white60,
              fontSize: AdaptiveLayout.getResponsiveFontSize(
                context,
                fontSize: 12,
              ),
            ),
          ),
          SizedBox(
            height: AdaptiveLayout.getResponsiveFontSize(context, fontSize: 16),
          ),
        ],
      ),
    );
  }
}
