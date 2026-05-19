import 'package:get/get.dart';
import 'widgets/custom_slider.dart';
import 'widgets/custom_page_view.dart';
import 'package:flutter/material.dart';
import 'widgets/custom_text_button.dart';
import '../../../core/theme/app_colors.dart';
import 'widgets/custom_elevated_button.dart';
import '../../../core/theme/app_spacing.dart';
import '../data/static/on_boarding_data.dart';
import '../controller/on_boarding_controller.dart';
import '../../../core/classes/adaptive_layout.dart';

class OnboardingView extends GetView<OnBoardingController> {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        actions: [
          Padding(
            padding: EdgeInsets.only(
              right: AdaptiveLayout.getResponsiveFontSize(
                context,
                fontSize: AppSpacing.m,
              ),
            ),
            child: CustomTextButton(
              btnTitle: "Skip",
              onPressed: controller.skip,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: CustomPageView(
                next: controller.next,
                onPageChanged: controller.onPageChanged,
                pageController: controller.pageController,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(
                AdaptiveLayout.getResponsiveFontSize(
                  context,
                  fontSize: AppSpacing.l,
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const CustomSlider(),
                  SizedBox(
                    height: AdaptiveLayout.getResponsiveFontSize(
                      context,
                      fontSize: AppSpacing.xl,
                    ),
                  ),
                  GetBuilder<OnBoardingController>(
                    builder: (controller) {
                      return CustomElevatedButton(
                        buttonTitle:
                            controller.currentPageIndex ==
                                kOnBoardingData.length - 1
                            ? "Get Started"
                            : "Next",
                        onPressed: controller.next,
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
