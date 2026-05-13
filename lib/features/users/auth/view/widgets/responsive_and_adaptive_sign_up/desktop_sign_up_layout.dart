import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controller/sign_up_controller.dart';
import '../../../../../../core/classes/adaptive_layout.dart';
import '../../../../../../core/constants/images_constants.dart';
import '../custom_auth_button.dart';
import '../custom_text_form_field.dart';

class DesktopSignUpView extends GetView<SignUpController> {
  const DesktopSignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Flexible(
              child: CustomTextFormField(
                hint: "John Doe",
                label: "Full Name",
                prefixIcon: Icons.person_outline,
                validator: controller.fullNameValidator,
                controller: controller.fullNameController,
              ),
            ),
            SizedBox(
              width: AdaptiveLayout.getResponsiveFontSize(
                context,
                fontSize: 16,
              ),
            ),
            Flexible(
              child: CustomTextFormField(
                label: "Email Address",
                hint: "you@example.com",
                prefixIcon: Icons.email_outlined,
                validator: controller.emailValidator,
                controller: controller.emailController,
              ),
            ),
          ],
        ),
        SizedBox(
          height: AdaptiveLayout.getResponsiveFontSize(context, fontSize: 16),
        ),
        Row(
          children: [
            Flexible(
              child: GetBuilder<SignUpController>(
                builder: (c) => CustomTextFormField(
                  hint: "••••••••",
                  label: "Password",
                  obscureText: c.showPassword,
                  onPressed: c.visiblePassword,
                  validator: c.passwordValidator,
                  controller: c.passwordController,
                  suffixIcon: c.showPasswordSuffixIcon,
                  prefixIcon: Icons.lock_outline_rounded,
                ),
              ),
            ),
            SizedBox(
              width: AdaptiveLayout.getResponsiveFontSize(
                context,
                fontSize: 16,
              ),
            ),
            Flexible(
              child: GetBuilder<SignUpController>(
                builder: (c) => CustomTextFormField(
                  hint: "••••••••",
                  label: "Confirm Password",
                  obscureText: c.showConfirmedPassword,
                  onPressed: c.visibleConfirmedPassword,
                  prefixIcon: Icons.lock_outline_rounded,
                  validator: c.confirmedPasswordValidator,
                  controller: c.confirmedPasswordController,
                  suffixIcon: c.showConfirmedPasswordSuffixIcon,
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: AdaptiveLayout.getResponsiveFontSize(context, fontSize: 24),
        ),
        CustomAuthButton(
          onPressed: controller.signUp,
          backgroundColor: const Color(0xFF009689),
          child: const Text(
            "Create Account",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          height: AdaptiveLayout.getResponsiveFontSize(context, fontSize: 24),
        ),
        Row(
          children: [
            Expanded(child: Divider(color: Colors.grey.shade300)),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: AdaptiveLayout.getResponsiveFontSize(
                  context,
                  fontSize: 10,
                ),
              ),
              child: const Text(
                "or continue with",
                style: TextStyle(color: Colors.grey),
              ),
            ),
            Expanded(child: Divider(color: Colors.grey.shade300)),
          ],
        ),
        SizedBox(
          height: AdaptiveLayout.getResponsiveFontSize(context, fontSize: 20),
        ),
        Row(
          children: [
            Expanded(
              child: CustomAuthButton(
                onPressed: controller.authWithGoogle,
                backgroundColor: Colors.white,
                isOutlined: true,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      ImagesConstants.googleIcon,
                      height: AdaptiveLayout.getResponsiveFontSize(
                        context,
                        fontSize: 20,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      "Google",
                      style: TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.w600,
                        fontSize: AdaptiveLayout.getResponsiveFontSize(
                          context,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              width: AdaptiveLayout.getResponsiveFontSize(
                context,
                fontSize: 16,
              ),
            ),
            Expanded(
              child: CustomAuthButton(
                onPressed: controller.authWithFacebook,
                backgroundColor: Colors.white,
                isOutlined: true,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.facebook, color: Color(0XFF1877F2)),
                    const Spacer(),
                    Text(
                      "Facebook",
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: AdaptiveLayout.getResponsiveFontSize(
                          context,
                          fontSize: 12,
                        ),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: AdaptiveLayout.getResponsiveFontSize(context, fontSize: 24),
        ),
        Center(
          child: GestureDetector(
            onTap: controller.goToSignIn,
            child: RichText(
              text: TextSpan(
                text: "Already have an account? ",
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: AdaptiveLayout.getResponsiveFontSize(
                    context,
                    fontSize: 13,
                  ),
                ),
                children: [
                  TextSpan(
                    text: "Sign In",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF009689),
                      fontSize: AdaptiveLayout.getResponsiveFontSize(
                        context,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
