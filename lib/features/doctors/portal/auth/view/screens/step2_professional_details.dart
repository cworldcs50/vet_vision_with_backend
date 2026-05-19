import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../core/classes/adaptive_layout.dart';
import '../../../../../../core/classes/validators.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../custom_auth_button.dart';
import '../../controller/step2_professional_details_controller.dart';
import '../widgets/custom_logo.dart';
import '../widgets/custom_text_form_field.dart';
import '../widgets/step_title.dart';

class Step2ProfessionalDetails
    extends GetView<Step2ProfessionalDetailsController> {
  const Step2ProfessionalDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.accent,
      body: Center(
        child: Form(
          key: controller.doctorStep2FormKey,
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: AdaptiveLayout.getResponsiveFontSize(
                context,
                fontSize: 16,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomLogo(),
                SizedBox(
                  height: AdaptiveLayout.getResponsiveFontSize(
                    context,
                    fontSize: 20,
                  ),
                ),
                const StepTitle(
                  title: "Professional Details",
                  subtitle: "Tell us about your veterinary expertise",
                ),
                SizedBox(
                  height: AdaptiveLayout.getResponsiveFontSize(
                    context,
                    fontSize: 20,
                  ),
                ),
                CustomTextFormField(
                  hint: "e.g., Small Animal Internist",
                  label: "Specialization",
                  prefixIcon: Icons.psychology_outlined,
                  controller: controller.specializationController,
                  validator: (v) =>
                      Validators.commonValidator(v, "Specialization"),
                ),
                SizedBox(
                  height: AdaptiveLayout.getResponsiveFontSize(
                    context,
                    fontSize: 16,
                  ),
                ),
                CustomTextFormField(
                  hint: "e.g., 10",
                  label: "Years of Experience",
                  prefixIcon: Icons.work_history_outlined,
                  keyboardType: TextInputType.number,
                  controller: controller.experienceController,
                  validator: (v) => Validators.commonValidator(v, "Experience"),
                ),
                SizedBox(
                  height: AdaptiveLayout.getResponsiveFontSize(
                    context,
                    fontSize: 16,
                  ),
                ),
                CustomTextFormField(
                  hint: "VET-123456",
                  label: "License Number",
                  prefixIcon: Icons.badge_outlined,
                  controller: controller.licenseController,
                  validator: (v) =>
                      Validators.commonValidator(v, "License Number"),
                ),
                SizedBox(
                  height: AdaptiveLayout.getResponsiveFontSize(
                    context,
                    fontSize: 16,
                  ),
                ),
                CustomTextFormField(
                  hint: "Tell us about your experience...",
                  label: "About You",
                  prefixIcon: Icons.description_outlined,
                  maxLines: 4,
                  controller: controller.bioController,
                  validator: (v) => Validators.commonValidator(v, "Bio"),
                ),
                SizedBox(
                  height: AdaptiveLayout.getResponsiveFontSize(
                    context,
                    fontSize: 20,
                  ),
                ),
                Text(
                  "Profile Picture",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: AdaptiveLayout.getResponsiveFontSize(
                      context,
                      fontSize: 14,
                    ),
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  height: AdaptiveLayout.getResponsiveFontSize(
                    context,
                    fontSize: 8,
                  ),
                ),
                GetBuilder<Step2ProfessionalDetailsController>(
                  builder: (controller) {
                    return GestureDetector(
                      onTap: () => controller.pickImage(),
                      child: Container(
                        height: AdaptiveLayout.getResponsiveFontSize(
                          context,
                          fontSize: 120,
                        ),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade300),
                          borderRadius: BorderRadius.circular(
                            AdaptiveLayout.getResponsiveFontSize(
                              context,
                              fontSize: 12,
                            ),
                          ),
                        ),
                        child: controller.profileImage != null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(
                                  AdaptiveLayout.getResponsiveFontSize(
                                    context,
                                    fontSize: 12,
                                  ),
                                ),
                                child: Image.file(
                                  File(controller.profileImage!.path),
                                  fit: BoxFit.cover,
                                ),
                              )
                            : Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.cloud_upload_outlined,
                                    size: AdaptiveLayout.getResponsiveFontSize(
                                      context,
                                      fontSize: 40,
                                    ),
                                    color: Colors.white,
                                  ),
                                  Text(
                                    "Upload profile picture",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize:
                                          AdaptiveLayout.getResponsiveFontSize(
                                            context,
                                            fontSize: 12,
                                          ),
                                    ),
                                  ),
                                  Text(
                                    "(PNG, JPG up to 5MB)",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize:
                                          AdaptiveLayout.getResponsiveFontSize(
                                            context,
                                            fontSize: 10,
                                          ),
                                    ),
                                  ),
                                ],
                              ),
                      ),
                    );
                  },
                ),
                SizedBox(
                  height: AdaptiveLayout.getResponsiveFontSize(
                    context,
                    fontSize: 30,
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => controller.previousStep(),
                        style: OutlinedButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                            vertical: AdaptiveLayout.getResponsiveFontSize(
                              context,
                              fontSize: 14,
                            ),
                          ),
                          side: const BorderSide(color: Colors.white),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              AdaptiveLayout.getResponsiveFontSize(
                                context,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ),
                        child: const Text(
                          "Back",
                          style: TextStyle(color: Colors.white),
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
                        onPressed: () => controller.nextStep(),
                        backgroundColor: const Color(0xFF009689),
                        child: const Text(
                          "Next",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
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
      ),
    );
  }
}
