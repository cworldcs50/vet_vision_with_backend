import 'package:get/get.dart';
import '../../../../../../core/classes/adaptive_layout.dart';
import '../custom_auth_button.dart';
import '../custom_text_form_field.dart';
import 'package:flutter/material.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/theme/app_spacing.dart';
import '../../../../../../core/constants/images_constants.dart';
import '../../../controller/sign_in_controller.dart';

class MobileSignInView extends GetView<SignInController> {
  const MobileSignInView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        CustomTextFormField(
          label: "Email Address",
          hint: "you@example.com",
          prefixIcon: Icons.email_outlined,
          validator: controller.emailValidator,
          controller: controller.emailController,
        ),
        SizedBox(
          height: AdaptiveLayout.getResponsiveFontSize(
            context,
            fontSize: AppSpacing.m,
          ),
        ),
        GetBuilder<SignInController>(
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
        Align(
          alignment: Alignment.centerRight,
          child: TextButton(
            onPressed: controller.forgetPassword,
            child: Text(
              "Forgot Password?",
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.w600,
                fontSize: AdaptiveLayout.getResponsiveFontSize(
                  context,
                  fontSize: 14,
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: AdaptiveLayout.getResponsiveFontSize(
            context,
            fontSize: AppSpacing.m,
          ),
        ),
        CustomAuthButton(
          onPressed: controller.signIn,
          backgroundColor: AppColors.primary,
          child: Text(
            "Sign In",
            style: TextStyle(
              fontSize: AdaptiveLayout.getResponsiveFontSize(
                context,
                fontSize: 16,
              ),
            ),
          ),
        ),
        SizedBox(
          height: AdaptiveLayout.getResponsiveFontSize(
            context,
            fontSize: AppSpacing.l,
          ),
        ),
        Row(
          children: [
            const Expanded(child: Divider()),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: AdaptiveLayout.getResponsiveFontSize(
                  context,
                  fontSize: AppSpacing.m,
                ),
              ),
              child: Text(
                "or continue with",
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontSize: AdaptiveLayout.getResponsiveFontSize(
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
            fontSize: AppSpacing.l,
          ),
        ),
        Row(
          children: [
            Expanded(
              child: CustomAuthButton(
                isOutlined: true,
                backgroundColor: AppColors.background,
                onPressed: controller.authWithGoogle,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      ImagesConstants.googleIcon,
                      height: AdaptiveLayout.getResponsiveFontSize(
                        context,
                        fontSize: 24,
                      ),
                    ),
                    SizedBox(
                      width: AdaptiveLayout.getResponsiveFontSize(
                        context,
                        fontSize: AppSpacing.s,
                      ),
                    ),
                    Text(
                      "Google",
                      style: TextStyle(
                        fontSize: AdaptiveLayout.getResponsiveFontSize(
                          context,
                          fontSize: 14,
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
                fontSize: AppSpacing.m,
              ),
            ),
            Expanded(
              child: CustomAuthButton(
                onPressed: controller.authWithFacebook,
                backgroundColor: AppColors.background,
                isOutlined: true,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.facebook,
                      color: const Color(0XFF1877F2),
                      size: AdaptiveLayout.getResponsiveFontSize(
                        context,
                        fontSize: 24,
                      ),
                    ),
                    SizedBox(
                      width: AdaptiveLayout.getResponsiveFontSize(
                        context,
                        fontSize: AppSpacing.s,
                      ),
                    ),
                    Text(
                      "Facebook",
                      style: TextStyle(
                        fontSize: AdaptiveLayout.getResponsiveFontSize(
                          context,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: AdaptiveLayout.getResponsiveFontSize(
            context,
            fontSize: AppSpacing.xl,
          ),
        ),
        Center(
          child: GestureDetector(
            onTap: controller.goToSignUp,
            child: RichText(
              text: TextSpan(
                text: "Don't have an account? ",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontSize: AdaptiveLayout.getResponsiveFontSize(
                    context,
                    fontSize: 14,
                  ),
                ),
                children: [
                  TextSpan(
                    text: "Sign Up",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                      fontSize: AdaptiveLayout.getResponsiveFontSize(
                        context,
                        fontSize: 14,
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
