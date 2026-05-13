import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/classes/adaptive_layout.dart';
import '../../../../../core/network/request_status.dart';
import '../../controller/forget_password_controller.dart';

class ForgetPasswordView extends StatelessWidget {
  const ForgetPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ForgetPasswordController());

    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        title: const Text(
          "Forgot Password",
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
                    Icons.lock_reset_rounded,
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
                    "Enter your email address and we'll send you a verification code to reset your password.",
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
                    key: controller.forgetPasswordFormKey,
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
                          TextFormField(
                            controller: controller.emailController,
                            validator: controller.emailValidator,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              labelText: "Email Address",
                              hintText: "you@example.com",
                              prefixIcon: const Icon(Icons.email_outlined),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                  AdaptiveLayout.getResponsiveFontSize(
                                    context,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: AdaptiveLayout.getResponsiveFontSize(
                              context,
                              fontSize: 20,
                            ),
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: controller.sendResetCode,
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
                                "Send Reset Code",
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
