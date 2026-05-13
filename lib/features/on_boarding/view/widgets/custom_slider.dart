import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/classes/adaptive_layout.dart';
import '../../data/static/on_boarding_data.dart';
import '../../controller/on_boarding_controller.dart';

class CustomSlider extends StatelessWidget {
  const CustomSlider({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OnBoardingController>(
      builder: (controller) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(kOnBoardingData.length, (index) {
            final isSelected = controller.currentPageIndex == index;
            return AnimatedContainer(
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeInOut,
              height: AdaptiveLayout.getResponsiveFontSize(
                context,
                fontSize: AppSpacing.xs,
              ),
              width: isSelected
                  ? AdaptiveLayout.getResponsiveFontSize(
                      context,
                      fontSize: AppSpacing.xl,
                    )
                  : AdaptiveLayout.getResponsiveFontSize(
                      context,
                      fontSize: AppSpacing.xs,
                    ),
              margin: EdgeInsets.only(
                right: AdaptiveLayout.getResponsiveFontSize(
                  context,
                  fontSize: AppSpacing.xxs,
                ),
              ),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.primary : AppColors.border,
                borderRadius: BorderRadius.circular(
                  AdaptiveLayout.getResponsiveFontSize(
                    context,
                    fontSize: AppSpacing.radiusFull,
                  ),
                ),
              ),
            );
          }),
        );
      },
    );
  }
}
