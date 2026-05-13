import 'package:get/get.dart';
import '../../../../../../core/classes/adaptive_layout.dart';
import '../custom_auth_button.dart';
import '../custom_text_form_field.dart';
import 'package:flutter/material.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/theme/app_spacing.dart';
import '../../../../../../core/constants/images_constants.dart';
import '../../../controller/sign_up_controller.dart';

class MobileSignUpView extends GetView<SignUpController> {
  const MobileSignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        CustomTextFormField(
          hint: "John Doe",
          label: "Full Name",
          prefixIcon: Icons.person_outline,
          validator: controller.fullNameValidator,
          controller: controller.fullNameController,
        ),
        SizedBox(
          height: AdaptiveLayout.getResponsiveFontSize(
            context,
            fontSize: AppSpacing.m,
          ),
        ),
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
        GetBuilder<SignUpController>(
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
        SizedBox(
          height: AdaptiveLayout.getResponsiveFontSize(
            context,
            fontSize: AppSpacing.m,
          ),
        ),
        GetBuilder<SignUpController>(
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
        SizedBox(
          height: AdaptiveLayout.getResponsiveFontSize(
            context,
            fontSize: AppSpacing.l,
          ),
        ),
        CustomAuthButton(
          onPressed: controller.signUp,
          backgroundColor: AppColors.primary,
          child: Text(
            "Create Account",
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
            onTap: controller.goToSignIn,
            child: RichText(
              text: TextSpan(
                text: "Already have an account? ",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontSize: AdaptiveLayout.getResponsiveFontSize(
                    context,
                    fontSize: 14,
                  ),
                ),
                children: [
                  TextSpan(
                    text: "Sign In",
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
