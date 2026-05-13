import 'package:flutter/material.dart';

import '../../../core/classes/adaptive_layout.dart';

class SocialLoginButton extends StatelessWidget {
  final String? iconPath;
  final IconData? icon;
  final Color? iconColor;
  final String text;
  final VoidCallback onPressed;

  const SocialLoginButton({
    this.iconPath,
    this.icon,
    this.iconColor,
    required this.text,
    required this.onPressed,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        padding: EdgeInsets.symmetric(
          vertical: AdaptiveLayout.getResponsiveFontSize(context, fontSize: 12),
        ),
        side: BorderSide(color: Colors.grey.shade300),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            AdaptiveLayout.getResponsiveFontSize(context, fontSize: 12),
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (iconPath != null)
            Image.asset(
              iconPath!,
              height: AdaptiveLayout.getResponsiveFontSize(
                context,
                fontSize: 20,
              ),
            )
          else if (icon != null)
            Icon(
              icon,
              color: iconColor,
              size: AdaptiveLayout.getResponsiveFontSize(context, fontSize: 20),
            ),
          SizedBox(
            width: AdaptiveLayout.getResponsiveFontSize(context, fontSize: 12),
          ),
          Text(
            text,
            style: TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.w600,
              fontSize: AdaptiveLayout.getResponsiveFontSize(
                context,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
