import '../role_card.dart';
import 'package:flutter/material.dart';
import '../../../../../../core/classes/adaptive_layout.dart';
import '../../../controller/role_selection_controller.dart';

class TabletRoleSelection extends StatelessWidget {
  const TabletRoleSelection({super.key, required this.controller});

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
              title: "I'm a Client",
              icon: Icons.person_outline,
              onTap: () => controller.selectRole(false),
              subtitle: "Find & book a vet for your pet",
            ),
          ),
        ],
      ),
    );
  }
}
