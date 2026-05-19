import 'package:flutter/material.dart';

import '../../../core/classes/adaptive_layout.dart';
import '../../../core/theme/app_colors.dart';

class CustomAuthButton extends StatelessWidget {
  const CustomAuthButton({
    super.key,
    required this.child,
    required this.onPressed,
    required this.backgroundColor,
    this.isOutlined = false,
  });

  final Widget child;
  final bool isOutlined;
  final Color backgroundColor;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.accent,
        padding: EdgeInsets.symmetric(
          vertical: AdaptiveLayout.getResponsiveFontSize(context, fontSize: 14),
          horizontal: AdaptiveLayout.getResponsiveFontSize(
            context,
            fontSize: 12,
          ),
        ),
        side: const BorderSide(color: AppColors.accent),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            AdaptiveLayout.getResponsiveFontSize(context, fontSize: 12),
          ),
        ),
      ),
      child: child,
    );
  }
}
