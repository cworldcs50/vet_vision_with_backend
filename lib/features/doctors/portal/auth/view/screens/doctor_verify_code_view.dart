import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../../../../../core/classes/adaptive_layout.dart';
import '../../../../../../core/theme/app_colors.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import '../../controller/doctor_verify_code_controller.dart';

class DoctorVerifyCodeView extends StatelessWidget {
  const DoctorVerifyCodeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          "Verification Code",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.transparent,
      ),
      backgroundColor: AppColors.accent,
      body: GetBuilder<DoctorVerifyCodeController>(
        init: DoctorVerifyCodeController(),
        builder: (controller) {
          return Padding(
            padding: EdgeInsets.symmetric(
              horizontal: AdaptiveLayout.getResponsiveFontSize(
                context,
                fontSize: 30.0,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Enter Verification Code",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: AdaptiveLayout.getResponsiveFontSize(
                      context,
                      fontSize: 18,
                    ),
                  ),
                ),
                SizedBox(
                  height: AdaptiveLayout.getResponsiveFontSize(
                    context,
                    fontSize: 10,
                  ),
                ),
                Text(
                  "We sent a 6-digit code to\n${controller.email}",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: AdaptiveLayout.getResponsiveFontSize(
                      context,
                      fontSize: 13,
                    ),
                  ),
                ),
                SizedBox(
                  height: AdaptiveLayout.getResponsiveFontSize(
                    context,
                    fontSize: 30,
                  ),
                ),
                OtpTextField(
                  fieldWidth: AdaptiveLayout.getResponsiveFontSize(
                    context,
                    fontSize: 45,
                  ),
                  numberOfFields: 6,
                  showFieldAsBox: true,
                  cursorColor: Colors.white70,
                  focusedBorderColor: Colors.white,
                  enabledBorderColor: Colors.white70,
                  borderRadius: BorderRadius.circular(
                    AdaptiveLayout.getResponsiveFontSize(context, fontSize: 10),
                  ),
                  textStyle: TextStyle(
                    color: Colors.white,
                    fontSize: AdaptiveLayout.getResponsiveFontSize(
                      context,
                      fontSize: 25,
                    ),
                    fontWeight: FontWeight.bold,
                  ),
                  fillColor: Colors.amber,
                  // showCursor: true,
                  onSubmit: (String verificationCode) async {
                    controller.verificationCode = verificationCode;
                    await controller.verifyCode();
                  },
                ),
                SizedBox(
                  height: AdaptiveLayout.getResponsiveFontSize(
                    context,
                    fontSize: 40,
                  ),
                ),
                TextButton(
                  style: TextButton.styleFrom(alignment: Alignment.center),
                  onPressed: () async => await controller.resendCode(),
                  child: Text(
                    "Didn't receive a code? Resend",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                      decoration: TextDecoration.underline,
                      decorationColor: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
