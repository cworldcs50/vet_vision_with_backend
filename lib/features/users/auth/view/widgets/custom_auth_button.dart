import 'package:flutter/material.dart';
import '../../../../../../core/theme/app_spacing.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/classes/adaptive_layout.dart';

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
        backgroundColor: backgroundColor,
        foregroundColor: isOutlined
            ? AppColors.textPrimary
            : AppColors.textLight,
        elevation: isOutlined ? 0 : 4,
        side: isOutlined
            ? const BorderSide(color: AppColors.border)
            : BorderSide.none,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            AdaptiveLayout.getResponsiveFontSize(
              context,
              fontSize: AppSpacing.radiusM,
            ),
          ),
        ),
        padding: EdgeInsets.symmetric(
          vertical: AdaptiveLayout.getResponsiveFontSize(
            context,
            fontSize: AppSpacing.m,
          ),
        ),
      ),
      child: child,
    );
  }
}
