import 'package:flutter/material.dart';

import '../../../../../core/classes/adaptive_layout.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({super.key, required this.label, required this.hint});

  final String label, hint;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.grey.shade700,
            fontSize: AdaptiveLayout.getResponsiveFontSize(
              context,
              fontSize: 13,
            ),
          ),
        ),
        SizedBox(height: AdaptiveLayout.getResponsiveFontSize(context, fontSize: 8)),
        TextField(
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(color: Colors.grey.shade400),
            filled: true,
            fillColor: Colors.white,
            contentPadding: EdgeInsets.symmetric(
              horizontal: AdaptiveLayout.getResponsiveFontSize(context, fontSize: 16),
              vertical: AdaptiveLayout.getResponsiveFontSize(context, fontSize: 14),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AdaptiveLayout.getResponsiveFontSize(context, fontSize: 12)),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AdaptiveLayout.getResponsiveFontSize(context, fontSize: 12)),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AdaptiveLayout.getResponsiveFontSize(context, fontSize: 12)),
              borderSide: const BorderSide(color: Color(0xFF009689)),
            ),
          ),
        ),
      ],
    );
  }
}

