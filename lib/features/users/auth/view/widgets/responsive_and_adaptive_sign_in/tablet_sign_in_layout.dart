import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controller/sign_in_controller.dart';
import '../../../../../../core/classes/adaptive_layout.dart';
import '../../../../../../core/constants/images_constants.dart';
import '../custom_auth_button.dart';
import '../custom_text_form_field.dart';

class TabletSignInView extends GetView<SignInController> {
  const TabletSignInView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Flexible(
              child: CustomTextFormField(
                label: "Email Address",
                hint: "you@example.com",
                prefixIcon: Icons.email_outlined,
                validator: controller.emailValidator,
                controller: controller.emailController,
              ),
            ),
            SizedBox(
              width: AdaptiveLayout.getResponsiveFontSize(
                context,
                fontSize: 16,
              ),
            ),
            Flexible(
              child: GetBuilder<SignInController>(
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
          ],
        ),
        Align(
          alignment: Alignment.centerRight,
          child: TextButton(
            onPressed: controller.forgetPassword,
            child: const Text(
              "Forgot Password?",
              style: TextStyle(
                color: Color(0xFF009689),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        CustomAuthButton(
          onPressed: controller.signIn,
          backgroundColor: const Color(0xFF009689),
          child: const Text(
            "Sign In",
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
            onTap: controller.goToSignUp,
            child: RichText(
              text: TextSpan(
                text: "Don't have an account? ",
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: AdaptiveLayout.getResponsiveFontSize(
                    context,
                    fontSize: 13,
                  ),
                ),
                children: [
                  TextSpan(
                    text: "Sign Up",
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
