import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../../core/classes/adaptive_layout.dart';
import '../doctor_portal_controller.dart';

class ProfileField extends GetView<DoctorPortalController> {
  final String label;
  final TextEditingController textController;
  final TextInputType? keyboardType;
  final int maxLines;

  const ProfileField({
    required this.label,
    required this.textController,
    this.keyboardType,
    this.maxLines = 1,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: AdaptiveLayout.getResponsiveFontSize(context, fontSize: 16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: AdaptiveLayout.getResponsiveFontSize(
                context,
                fontSize: 12,
              ),
              color: Colors.black54,
            ),
          ),
          SizedBox(
            height: AdaptiveLayout.getResponsiveFontSize(context, fontSize: 8),
          ),
          TextField(
            controller: textController,
            keyboardType: keyboardType,
            maxLines: maxLines,
            decoration: InputDecoration(
              isDense: true,
              filled: true,
              fillColor: Colors.grey.shade50,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                  AdaptiveLayout.getResponsiveFontSize(context, fontSize: 10),
                ),
                borderSide: BorderSide.none,
              ),
              contentPadding: EdgeInsets.symmetric(
                horizontal: AdaptiveLayout.getResponsiveFontSize(
                  context,
                  fontSize: 12,
                ),
                vertical: AdaptiveLayout.getResponsiveFontSize(
                  context,
                  fontSize: 12,
                ),
              ),
            ),
            style: TextStyle(
              fontSize: AdaptiveLayout.getResponsiveFontSize(
                context,
                fontSize: 14,
              ),
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}

