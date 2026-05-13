import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../../core/classes/adaptive_layout.dart';
import '../doctor_portal_controller.dart';

class NavButton extends GetView<DoctorPortalController> {
  final String title;
  final int index;
  final IconData icon;
  final bool isSelected;

  const NavButton({
    required this.title,
    required this.index,
    required this.icon,
    required this.isSelected,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Obx(() {
        final bool selected = controller.selectedIndex.value == index;
        return GestureDetector(
          onTap: () => controller.updateIndex(index),
          child: Container(
            padding: EdgeInsets.symmetric(
              vertical: AdaptiveLayout.getResponsiveFontSize(
                context,
                fontSize: 10,
              ),
            ),
            decoration: BoxDecoration(
              color: selected ? Colors.white : Colors.transparent,
              borderRadius: BorderRadius.circular(
                AdaptiveLayout.getResponsiveFontSize(context, fontSize: 8),
              ),
              boxShadow:
                  selected
                      ? [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: AdaptiveLayout.getResponsiveFontSize(
                            context,
                            fontSize: 4,
                          ),
                          offset: Offset(
                            0,
                            AdaptiveLayout.getResponsiveFontSize(
                              context,
                              fontSize: 2,
                            ),
                          ),
                        ),
                      ]
                      : null,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  size: AdaptiveLayout.getResponsiveFontSize(
                    context,
                    fontSize: 16,
                  ),
                  color: selected ? const Color(0xFF009689) : Colors.white,
                ),
                SizedBox(
                  width: AdaptiveLayout.getResponsiveFontSize(
                    context,
                    fontSize: 4,
                  ),
                ),
                Text(
                  title,
                  style: TextStyle(
                    color: selected ? const Color(0xFF009689) : Colors.white,
                    fontWeight: selected ? FontWeight.bold : FontWeight.normal,
                    fontSize: AdaptiveLayout.getResponsiveFontSize(
                      context,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
