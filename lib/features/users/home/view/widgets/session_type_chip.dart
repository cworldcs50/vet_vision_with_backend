import 'package:flutter/material.dart';
import '../../controller/home_controller.dart';
import '../../../../../core/theme/app_colors.dart';

class SessionTypeChip extends StatelessWidget {
  final HomeController controller;
  final String value;
  final String label;

  const SessionTypeChip({
    super.key,
    required this.controller,
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    final isSelected = controller.selectedSessionType == value;
    return Expanded(
      child: ChoiceChip(
        label: Center(
          child: Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.black,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
        selected: isSelected,
        onSelected: (selected) {
          if (selected) controller.updateSessionType(value);
        },
        selectedColor: AppColors.accent,
        backgroundColor: Colors.grey.shade100,
      ),
    );
  }
}
