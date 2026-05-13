import 'package:flutter/material.dart';

import '../../../controller/role_selection_controller.dart';
import '../../../../../../core/classes/adaptive_layout.dart';
import '../role_card.dart';

class DesktopRoleSelection extends StatelessWidget {
  const DesktopRoleSelection({super.key, required this.controller});

  final RoleSelectionController controller;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        children: [
          Expanded(
            child: RoleCard(
              title: "I'm a Doctor",
              icon: Icons.medical_services_outlined,
              onTap: () => controller.selectRole(true),
              subtitle: "Manage your appointments & patients",
            ),
          ),
          SizedBox(
            width: AdaptiveLayout.getResponsiveFontSize(context, fontSize: 16),
          ),
          Expanded(
            child: RoleCard(
              icon: Icons.person_outline,
              title: "I'm a Client",
              subtitle: "Find & book a vet for your pet",
              onTap: () => controller.selectRole(false),
            ),
          ),
        ],
      ),
    );
  }
}
