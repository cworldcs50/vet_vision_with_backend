import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../../../../../core/classes/adaptive_layout.dart';
import '../../../../../../core/network/request_status.dart';
import '../../../../../../core/routes/app_routes_name.dart';
import '../../../../../../core/constants/images_constants.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../controller/doctor_sign_in_controller.dart';
import '../widgets/custom_text_form_field.dart';
import '../../../custom_auth_button.dart';

class DoctorLoginView extends StatefulWidget {
  const DoctorLoginView({super.key});

  @override
  State<DoctorLoginView> createState() => _DoctorLoginViewState();
}

class _DoctorLoginViewState extends State<DoctorLoginView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>(
    debugLabel: 'doctorSignInFormKey',
  );

  @override
  void dispose() {
    if (Get.isRegistered<DoctorSignInController>()) {
      final controller = Get.find<DoctorSignInController>();
      if (controller.signInFormKey == _formKey) {
        controller.signInFormKey = null;
      }
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Initialize SignInController if not already initialized
    // We use Get.put here but since it's a view that might be reused,
    // it's better to handle binding in AppPages.
    return Scaffold(
      backgroundColor: AppColors.accent, // Doctor theme color
      body: GetBuilder<DoctorSignInController>(
        init: DoctorSignInController(),
        builder: (DoctorSignInController controller) {
          controller.signInFormKey = _formKey;
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
                        borderRadius: BorderRadius.circular(
                          AdaptiveLayout.getResponsiveFontSize(
                            context,
                            fontSize: 20,
                          ),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.1),
                            blurRadius: AdaptiveLayout.getResponsiveFontSize(
                              context,
                              fontSize: 10,
                            ),
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
                        borderRadius: BorderRadius.circular(
                          AdaptiveLayout.getResponsiveFontSize(
                            context,
                            fontSize: 30,
                          ),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.05),
                            blurRadius: AdaptiveLayout.getResponsiveFontSize(
                              context,
                              fontSize: 20,
                            ),
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
                                color: AppColors.accent,
                                fontWeight: FontWeight.bold,
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
                            GetBuilder<DoctorSignInController>(
                              builder: (DoctorSignInController c) =>
                                  CustomTextFormField(
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
                                onPressed: controller.forgetPassword,
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
                              onPressed: controller.signIn,
                              backgroundColor: AppColors.accent,
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
                                  padding: EdgeInsets.symmetric(
                                    horizontal:
                                        AdaptiveLayout.getResponsiveFontSize(
                                          context,
                                          fontSize: 10,
                                        ),
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
                                  onPressed: controller.authWithGoogle,
                                ),
                                SizedBox(
                                  width: AdaptiveLayout.getResponsiveFontSize(
                                    context,
                                    fontSize: 20,
                                  ),
                                ),
                                _SocialButton(
                                  icon: Icons.facebook,
                                  onPressed: controller.authWithFacebook,
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
                              onTap: () async => await Get.offNamed(
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
        padding: EdgeInsets.all(
          AdaptiveLayout.getResponsiveFontSize(context, fontSize: 12),
        ),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(
            AdaptiveLayout.getResponsiveFontSize(context, fontSize: 15),
          ),
        ),
        child: Icon(
          icon,
          size: AdaptiveLayout.getResponsiveFontSize(context, fontSize: 30),
          color: Colors.black87,
        ),
      ),
    );
  }
}
