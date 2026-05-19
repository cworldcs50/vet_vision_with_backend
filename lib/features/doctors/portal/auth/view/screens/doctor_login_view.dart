import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../../../../../core/classes/adaptive_layout.dart';
import '../../../../../../core/network/request_status.dart';
import '../../../../../../core/routes/app_routes_name.dart';
import '../../../../../../core/constants/images_constants.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../users/auth/controller/sign_in_controller.dart';
import '../widgets/custom_text_form_field.dart';
import '../../../custom_auth_button.dart';

class DoctorLoginView extends StatelessWidget {
  const DoctorLoginView({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize SignInController if not already initialized
    // We use Get.put here but since it's a view that might be reused,
    // it's better to handle binding in AppPages.
    return Scaffold(
      backgroundColor: AppColors.accent, // Doctor theme color
      body: GetBuilder<SignInController>(
        init: SignInController(),
        builder: (controller) {
          return Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: AdaptiveLayout.getResponsiveFontSize(
                        context,
                        fontSize: 60,
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
                          fontSize: 15,
                        ),
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
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
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      "Vet Vision",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: AdaptiveLayout.getResponsiveFontSize(
                          context,
                          fontSize: 32,
                        ),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Doctor Portal",
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: AdaptiveLayout.getResponsiveFontSize(
                          context,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: AdaptiveLayout.getResponsiveFontSize(
                        context,
                        fontSize: 40,
                      ),
                    ),
                    // Form Section
                    Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: AdaptiveLayout.getResponsiveFontSize(
                          context,
                          fontSize: 20,
                        ),
                      ),
                      padding: EdgeInsets.all(
                        AdaptiveLayout.getResponsiveFontSize(
                          context,
                          fontSize: 25,
                        ),
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.05),
                            blurRadius: 20,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: Form(
                        key: controller.signInFormKey,
                        child: Column(
                          children: [
                            Text(
                              "Sign In",
                              style: TextStyle(
                                fontSize: AdaptiveLayout.getResponsiveFontSize(
                                  context,
                                  fontSize: 24,
                                ),
                                fontWeight: FontWeight.bold,
                                color: AppColors.accent,
                              ),
                            ),
                            SizedBox(
                              height: AdaptiveLayout.getResponsiveFontSize(
                                context,
                                fontSize: 30,
                              ),
                            ),
                            CustomTextFormField(
                              hint: "doctor@example.com",
                              label: "Email Address",
                              prefixIcon: Icons.email_outlined,
                              controller: controller.emailController,
                              validator: controller.emailValidator,
                            ),
                            SizedBox(
                              height: AdaptiveLayout.getResponsiveFontSize(
                                context,
                                fontSize: 20,
                              ),
                            ),
                            GetBuilder<SignInController>(
                              builder: (c) => CustomTextFormField(
                                hint: "********",
                                label: "Password",
                                prefixIcon: Icons.lock_outline,
                                obscureText: c.showPassword,
                                onPressed: c.visiblePassword,
                                suffixIcon: c.showPasswordSuffixIcon,
                                controller: controller.passwordController,
                                validator: controller.passwordValidator,
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: TextButton(
                                onPressed: () => controller.forgetPassword(),
                                child: Text(
                                  "Forgot Password?",
                                  style: TextStyle(
                                    color: AppColors.accent,
                                    fontSize:
                                        AdaptiveLayout.getResponsiveFontSize(
                                          context,
                                          fontSize: 13,
                                        ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: AdaptiveLayout.getResponsiveFontSize(
                                context,
                                fontSize: 10,
                              ),
                            ),
                            CustomAuthButton(
                              onPressed: () => controller.signIn(),
                              backgroundColor: const Color(0xFF009689),
                              child: const Text(
                                "Sign In",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: AdaptiveLayout.getResponsiveFontSize(
                                context,
                                fontSize: 25,
                              ),
                            ),
                            // Social Login
                            Row(
                              children: [
                                const Expanded(child: Divider()),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                  ),
                                  child: Text(
                                    "Or sign in with",
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize:
                                          AdaptiveLayout.getResponsiveFontSize(
                                            context,
                                            fontSize: 12,
                                          ),
                                    ),
                                  ),
                                ),
                                const Expanded(child: Divider()),
                              ],
                            ),
                            SizedBox(
                              height: AdaptiveLayout.getResponsiveFontSize(
                                context,
                                fontSize: 20,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                _SocialButton(
                                  icon: Icons.g_mobiledata,
                                  onPressed: () => controller.authWithGoogle(),
                                ),
                                const SizedBox(width: 20),
                                _SocialButton(
                                  icon: Icons.facebook,
                                  onPressed: () =>
                                      controller.authWithFacebook(),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: AdaptiveLayout.getResponsiveFontSize(
                                context,
                                fontSize: 25,
                              ),
                            ),
                            GestureDetector(
                              onTap: () => Get.offNamed(
                                AppRoutesName.rDoctorAuthStep1,
                                arguments: {'role': 'doctor'},
                              ),
                              child: RichText(
                                text: TextSpan(
                                  text: "Don't have an account? ",
                                  style: TextStyle(
                                    color: Colors.black54,
                                    fontSize:
                                        AdaptiveLayout.getResponsiveFontSize(
                                          context,
                                          fontSize: 14,
                                        ),
                                  ),
                                  children: const [
                                    TextSpan(
                                      text: "Sign Up",
                                      style: TextStyle(
                                        color: AppColors.accent,
                                        fontWeight: FontWeight.bold,
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
                    SizedBox(
                      height: AdaptiveLayout.getResponsiveFontSize(
                        context,
                        fontSize: 40,
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
                      child: CircularProgressIndicator(color: Colors.white),
                    ),
                  );
                }
                return const SizedBox.shrink();
              }),
            ],
          );
        },
      ),
    );
  }
}

class _SocialButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;

  const _SocialButton({required this.icon, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Icon(icon, size: 30, color: Colors.black87),
      ),
    );
  }
}
