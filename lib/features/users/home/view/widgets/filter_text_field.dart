import 'package:flutter/material.dart';

import '../../../../../core/classes/adaptive_layout.dart';

class FilterTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final String? prefixText;
  final IconData? icon;

  const FilterTextField({
    super.key,
    required this.controller,
    required this.hint,
    this.prefixText,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        hintText: hint,
        prefixText: prefixText,
        prefixIcon: icon != null
            ? Icon(
                icon,
                size: AdaptiveLayout.getResponsiveFontSize(
                  context,
                  fontSize: 20,
                ),
              )
            : null,
        filled: true,
        fillColor: Colors.grey.shade100,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            AdaptiveLayout.getResponsiveFontSize(context, fontSize: 12),
          ),
          borderSide: BorderSide.none,
        ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: AdaptiveLayout.getResponsiveFontSize(
            context,
            fontSize: 15,
          ),
          vertical: AdaptiveLayout.getResponsiveFontSize(context, fontSize: 15),
        ),
      ),
    );
  }
}
