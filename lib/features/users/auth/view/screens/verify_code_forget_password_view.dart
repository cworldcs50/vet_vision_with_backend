import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import '../../../../../core/classes/adaptive_layout.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../controller/verify_code_forget_password_controller.dart';
import '../../../../../core/theme/app_typography.dart';

class VerifyCodeForgetPasswordView extends StatelessWidget {
  const VerifyCodeForgetPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(VerifyCodeForgetPasswordController());

    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        title: const Text("Verify Code", style: TextStyle(color: Colors.white)),
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
                    Icons.security_rounded,
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
                      color: Colors.white,
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
                  Column(
                    children: [
                      Text(
                        "Enter the 6-digit code:",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: AdaptiveLayout.getResponsiveFontSize(
                            context,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: AdaptiveLayout.getResponsiveFontSize(
                          context,
                          fontSize: 16,
                        ),
                      ),
                      OtpTextField(
                        fieldWidth: AdaptiveLayout.getResponsiveFontSize(
                          context,
                          fontSize: 40,
                        ),
                        numberOfFields: 6,
                        showFieldAsBox: true,
                        textStyle: AppTypography.otpInput,
                        cursorColor: AppTypography.otpInput.color,
                        borderColor: AppColors.primaryColor,
                        borderRadius: BorderRadius.circular(
                          AdaptiveLayout.getResponsiveFontSize(
                            context,
                            fontSize: 8,
                          ),
                        ),
                        onSubmit: (String code) {
                          controller.verificationCode = code;
                          controller.goToResetPassword();
                        },
                        onCodeChanged: (String code) {
                          controller.verificationCode = code;
                        },
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
                            FocusScope.of(context).unfocus();
                            controller.goToResetPassword();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primaryColor,
                            padding: EdgeInsets.symmetric(
                              vertical: AdaptiveLayout.getResponsiveFontSize(
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
                            "Next",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: AdaptiveLayout.getResponsiveFontSize(
                                context,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
