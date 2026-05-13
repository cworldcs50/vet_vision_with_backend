import 'package:flutter/material.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/classes/adaptive_layout.dart';

class CustomAdditionalNotes extends StatelessWidget {
  const CustomAdditionalNotes({super.key, required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.edit_note_rounded,
              size: AdaptiveLayout.getResponsiveFontSize(context, fontSize: 18),
              color: AppColors.primaryColor,
            ),
            SizedBox(
              width: AdaptiveLayout.getResponsiveFontSize(context, fontSize: 6),
            ),
            Text(
              "Additional Notes (Optional)",
              style: TextStyle(
                fontSize: AdaptiveLayout.getResponsiveFontSize(
                  context,
                  fontSize: 16,
                ),
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ],
        ),
        SizedBox(
          height: AdaptiveLayout.getResponsiveFontSize(context, fontSize: 12),
        ),
        TextField(
          controller: controller,
          maxLines: 3,
          style: TextStyle(
            fontSize: AdaptiveLayout.getResponsiveFontSize(
              context,
              fontSize: 13,
            ),
            color: Colors.black87,
          ),
          decoration: InputDecoration(
            hintText:
                "Share any specific concerns or information with the doctor...",
            hintStyle: TextStyle(
              fontSize: AdaptiveLayout.getResponsiveFontSize(
                context,
                fontSize: 12,
              ),
              color: Colors.grey.shade400,
            ),
            filled: true,
            fillColor: Colors.grey.shade50,
            contentPadding: EdgeInsets.symmetric(
              horizontal: AdaptiveLayout.getResponsiveFontSize(
                context,
                fontSize: 14,
              ),
              vertical: AdaptiveLayout.getResponsiveFontSize(
                context,
                fontSize: 12,
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                AdaptiveLayout.getResponsiveFontSize(context, fontSize: 12),
              ),
              borderSide: BorderSide(color: Colors.grey.shade200),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                AdaptiveLayout.getResponsiveFontSize(context, fontSize: 12),
              ),
              borderSide: BorderSide(color: Colors.grey.shade200),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                AdaptiveLayout.getResponsiveFontSize(context, fontSize: 12),
              ),
              borderSide: const BorderSide(
                color: AppColors.primaryColor,
                width: 1.5,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
