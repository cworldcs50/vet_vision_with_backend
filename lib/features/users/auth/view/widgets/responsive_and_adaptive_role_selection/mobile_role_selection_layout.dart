import '../role_card.dart';
import 'package:flutter/material.dart';
import '../../../../../../core/classes/adaptive_layout.dart';
import '../../../controller/role_selection_controller.dart';

class MobileRoleSelection extends StatelessWidget {
  const MobileRoleSelection({super.key, required this.controller});

  final RoleSelectionController controller;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          RoleCard(
            title: "I'm a Doctor",
            icon: Icons.medical_services_outlined,
            onTap: () => controller.selectRole(true),
            subtitle: "Manage your appointments & patients",
          ),
          SizedBox(
            height: AdaptiveLayout.getResponsiveFontSize(context, fontSize: 16),
          ),
          RoleCard(
            title: "I'm a Client",
            icon: Icons.person_outline,
            onTap: () => controller.selectRole(false),
            subtitle: "Find & book a vet for your pet",
          ),
        ],
      ),
    );
  }
}
