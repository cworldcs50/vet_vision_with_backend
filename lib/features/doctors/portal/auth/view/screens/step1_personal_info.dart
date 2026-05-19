import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../../../../../core/classes/validators.dart';
import '../../../../../../core/routes/app_routes_name.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../widgets/step_title.dart';
import '../../../../../../core/classes/adaptive_layout.dart';
import '../../../custom_auth_button.dart';
import '../../controller/step1_personal_info_controller.dart';
import '../widgets/custom_logo.dart';
import '../widgets/custom_text_form_field.dart';

class Step1PersonalInfo extends GetView<Step1PersonalInfoController> {
  const Step1PersonalInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.accent,
      body: Center(
        child: Form(
          key: controller.doctorStep1FormKey,
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: AdaptiveLayout.getResponsiveFontSize(
                context,
                fontSize: 15,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomLogo(),
                SizedBox(
                  height: AdaptiveLayout.getResponsiveFontSize(
                    context,
                    fontSize: 30,
                  ),
                ),
                const StepTitle(
                  title: "Personal Information",
                  subtitle: "Let's start with your basic details",
                ),
                SizedBox(
                  height: AdaptiveLayout.getResponsiveFontSize(
                    context,
                    fontSize: 20,
                  ),
                ),
                CustomTextFormField(
                  hint: "Dr. John Smith",
                  label: "Full Name",
                  prefixIcon: Icons.person_outline,
                  controller: controller.fullNameController,
                  validator: Validators.fullNameValidator,
                ),
                SizedBox(
                  height: AdaptiveLayout.getResponsiveFontSize(
                    context,
                    fontSize: 16,
                  ),
                ),
                CustomTextFormField(
                  hint: "doctor@example.com",
                  label: "Email Address",
                  prefixIcon: Icons.email_outlined,
                  controller: controller.emailController,
                  validator: Validators.emailValidator,
                ),
                SizedBox(
                  height: AdaptiveLayout.getResponsiveFontSize(
                    context,
                    fontSize: 16,
                  ),
                ),
                CustomTextFormField(
                  hint: "+1 (555) 123-4567",
                  label: "Phone Number",
                  prefixIcon: Icons.phone_outlined,
                  controller: controller.phoneController,
                  validator: Validators.phoneValidator,
                ),
                SizedBox(
                  height: AdaptiveLayout.getResponsiveFontSize(
                    context,
                    fontSize: 16,
                  ),
                ),
                GetBuilder<Step1PersonalInfoController>(
                  builder: (c) => CustomTextFormField(
                    hint: "********",
                    label: "Password",
                    prefixIcon: Icons.lock_outline,
                    obscureText: c.showPassword,
                    onPressed: c.visiblePassword,
                    suffixIcon: c.showPasswordSuffixIcon,
                    controller: controller.passwordController,
                    validator: Validators.passwordValidator,
                  ),
                ),
                SizedBox(
                  height: AdaptiveLayout.getResponsiveFontSize(
                    context,
                    fontSize: 16,
                  ),
                ),
                GetBuilder<Step1PersonalInfoController>(
                  builder: (c) => CustomTextFormField(
                    hint: "********",
                    label: "Confirm Password",
                    prefixIcon: Icons.lock_outline,
                    obscureText: c.showConfirmedPassword,
                    onPressed: c.visibleConfirmedPassword,
                    suffixIcon: c.showConfirmedPasswordSuffixIcon,
                    controller: controller.confirmedPasswordController,
                    validator: Validators.passwordValidator,
                  ),
                ),
                SizedBox(
                  height: AdaptiveLayout.getResponsiveFontSize(
                    context,
                    fontSize: 30,
                  ),
                ),
                CustomAuthButton(
                  onPressed: () => controller.nextStep(),
                  backgroundColor: AppColors.accent,
                  child: const Text(
                    "Next",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  height: AdaptiveLayout.getResponsiveFontSize(
                    context,
                    fontSize: 16,
                  ),
                ),
                Center(
                  child: GestureDetector(
                    onTap: () => Get.offNamed(
                      AppRoutesName.rDoctorSignIn,
                      arguments: {'role': 'doctor'},
                    ),
                    child: RichText(
                      text: TextSpan(
                        text: "Already have an account? ",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: AdaptiveLayout.getResponsiveFontSize(
                            context,
                            fontSize: 14,
                          ),
                        ),
                        children: const [
                          TextSpan(
                            text: "Sign In",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
