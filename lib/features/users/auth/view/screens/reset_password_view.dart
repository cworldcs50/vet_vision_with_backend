import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../core/classes/adaptive_layout.dart';
import '../../../../../core/network/request_status.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../controller/reset_password_controller.dart';
import '../widgets/custom_text_form_field.dart';

class ResetPasswordView extends StatelessWidget {
  const ResetPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ResetPasswordController());

    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        title: const Text(
          "Reset Password",
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Stack(
        children: [
          Center(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: AdaptiveLayout.getResponsiveFontSize(
                  context,
                  fontSize: 24,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.password_rounded,
                    size: AdaptiveLayout.getResponsiveFontSize(
                      context,
                      fontSize: 60,
                    ),
                    color: Colors.white,
                  ),
                  SizedBox(
                    height: AdaptiveLayout.getResponsiveFontSize(
                      context,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    "We sent a 6-digit code to\n${controller.email}",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: AdaptiveLayout.getResponsiveFontSize(
                        context,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: AdaptiveLayout.getResponsiveFontSize(
                      context,
                      fontSize: 30,
                    ),
                  ),
                  Form(
                    key: controller.resetPasswordFormKey,
                    child: Container(
                      padding: EdgeInsets.all(
                        AdaptiveLayout.getResponsiveFontSize(
                          context,
                          fontSize: 16,
                        ),
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(
                          AdaptiveLayout.getResponsiveFontSize(
                            context,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      child: Column(
                        children: [
                          GetBuilder<ResetPasswordController>(
                            builder: (c) => CustomTextFormField(
                              hint: "••••••••",
                              label: "New Password",
                              obscureText: c.showPassword,
                              onPressed: c.visiblePassword,
                              validator: c.passwordValidator,
                              controller: c.passwordController,
                              suffixIcon: c.showPasswordSuffixIcon,
                              prefixIcon: Icons.lock_outline_rounded,
                            ),
                          ),
                          SizedBox(
                            height: AdaptiveLayout.getResponsiveFontSize(
                              context,
                              fontSize: 16,
                            ),
                          ),
                          GetBuilder<ResetPasswordController>(
                            builder: (c) => CustomTextFormField(
                              hint: "••••••••",
                              label: "Confirm New Password",
                              obscureText: c.showConfirmedPassword,
                              onPressed: c.visibleConfirmedPassword,
                              prefixIcon: Icons.lock_outline_rounded,
                              validator: c.confirmedPasswordValidator,
                              controller: c.confirmedPasswordController,
                              suffixIcon: c.showConfirmedPasswordSuffixIcon,
                            ),
                          ),
                          SizedBox(
                            height: AdaptiveLayout.getResponsiveFontSize(
                              context,
                              fontSize: 24,
                            ),
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                // Close keyboard
                                FocusScope.of(context).unfocus();
                                controller.resetPassword();
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primaryColor,
                                padding: EdgeInsets.symmetric(
                                  vertical:
                                      AdaptiveLayout.getResponsiveFontSize(
                                        context,
                                        fontSize: 12,
                                      ),
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                    AdaptiveLayout.getResponsiveFontSize(
                                      context,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ),
                              child: Text(
                                "Reset Password",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize:
                                      AdaptiveLayout.getResponsiveFontSize(
                                        context,
                                        fontSize: 14,
                                      ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Loading overlay
          Obx(() {
            if (controller.requestStatus.value == RequestStatus.loading) {
              return Container(
                color: Colors.black38,
                child: const Center(
                  child: CircularProgressIndicator(color: Colors.white),
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
