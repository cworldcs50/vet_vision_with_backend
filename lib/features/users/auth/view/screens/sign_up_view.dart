import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_spacing.dart';
import '../../../../../core/classes/adaptive_layout.dart';
import '../../../../../core/network/request_status.dart';
import '../../../../../core/constants/images_constants.dart';
import '../../controller/sign_up_controller.dart';
import '../widgets/responsive_and_adaptive_sign_up/desktop_sign_up_layout.dart';
import '../widgets/responsive_and_adaptive_sign_up/mobile_sign_up_layout.dart';
import '../widgets/responsive_and_adaptive_sign_up/tablet_sign_up_layout.dart';

class SignUpView extends GetView<SignUpController> {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isDoctor = controller.selectedRole.isDoctor;

    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: AdaptiveLayout.getResponsiveFontSize(
                    context,
                    fontSize: AppSpacing.xxxl,
                  ),
                ),
                // Logo Section
                Container(
                  width: AdaptiveLayout.getResponsiveFontSize(
                    context,
                    fontSize: 100,
                  ),
                  height: AdaptiveLayout.getResponsiveFontSize(
                    context,
                    fontSize: 100,
                  ),
                  padding: EdgeInsets.all(
                    AdaptiveLayout.getResponsiveFontSize(
                      context,
                      fontSize: AppSpacing.s,
                    ),
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.background,
                    borderRadius: BorderRadius.circular(
                      AdaptiveLayout.getResponsiveFontSize(
                        context,
                        fontSize: AppSpacing.radiusL,
                      ),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Image.asset(
                    ImagesConstants.kLogo,
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(
                  height: AdaptiveLayout.getResponsiveFontSize(
                    context,
                    fontSize: AppSpacing.l,
                  ),
                ),
                Text(
                  "Vet Vision",
                  style: Theme.of(context).textTheme.displayMedium?.copyWith(
                    color: AppColors.textLight,
                    fontSize: AdaptiveLayout.getResponsiveFontSize(
                      context,
                      fontSize: 32,
                    ),
                  ),
                ),
                SizedBox(
                  height: AdaptiveLayout.getResponsiveFontSize(
                    context,
                    fontSize: AppSpacing.xs,
                  ),
                ),
                Text(
                  isDoctor
                      ? "Create your doctor account today."
                      : "Create your account today.",
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.textLight.withValues(alpha: 0.8),
                    fontSize: AdaptiveLayout.getResponsiveFontSize(
                      context,
                      fontSize: 14,
                    ),
                  ),
                ),
                SizedBox(
                  height: AdaptiveLayout.getResponsiveFontSize(
                    context,
                    fontSize: AppSpacing.xxl,
                  ),
                ),
                // Form Section
                Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: AdaptiveLayout.getResponsiveFontSize(
                      context,
                      fontSize: AppSpacing.l,
                    ),
                  ),
                  padding: EdgeInsets.all(
                    AdaptiveLayout.getResponsiveFontSize(
                      context,
                      fontSize: AppSpacing.l,
                    ),
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.background,
                    borderRadius: BorderRadius.circular(
                      AdaptiveLayout.getResponsiveFontSize(
                        context,
                        fontSize: AppSpacing.radiusXl,
                      ),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.05),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Form(
                    key: controller.signUpFormKey,
                    child: AdaptiveLayout(
                      mobileLayout: (context) => MobileSignUpView(),
                      tabletLayout: (context) => TabletSignUpView(),
                      desktopLayout: (context) => DesktopSignUpView(),
                    ),
                  ),
                ),
                SizedBox(
                  height: AdaptiveLayout.getResponsiveFontSize(
                    context,
                    fontSize: AppSpacing.xxl,
                  ),
                ),
              ],
            ),
          ),
          // Loading overlay
          Obx(() {
            if (controller.requestStatus.value == RequestStatus.loading) {
              return Container(
                color: Colors.black38,
                child: const Center(
                  child: CircularProgressIndicator(color: AppColors.textLight),
                ),
              );
            }
            return const SizedBox.shrink();
          }),
        ],
      ),
    );
  }
}
