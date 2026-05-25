import 'package:get/get.dart';
import '../custom_auth_button.dart';
import 'package:flutter/material.dart';
import '../../widgets/profile_field.dart';
import '../../widgets/profile_section.dart';
import '../../doctor_portal_controller.dart';
import '../../widgets/time_slot_picker.dart';
import 'view/clinic_location_picker_view.dart';
import '../../../../core/theme/app_colors.dart';
import '../../widgets/profile_image_header.dart';
import '../../../../core/classes/adaptive_layout.dart';
import '../../widgets/consultation_toggle_section.dart';

class DoctorProfileView extends GetView<DoctorPortalController> {
  const DoctorProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(
        AdaptiveLayout.getResponsiveFontSize(context, fontSize: 20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ProfileImageHeader(),
          SizedBox(
            height: AdaptiveLayout.getResponsiveFontSize(context, fontSize: 24),
          ),
          ProfileSection(
            title: "Basic Information",
            children: [
              ProfileField(
                label: "Full Name",
                textController: controller.fullNameController,
              ),
              ProfileField(
                label: "Email Address",
                keyboardType: TextInputType.emailAddress,
                textController: controller.emailController,
              ),
              ProfileField(
                label: "Phone Number",
                keyboardType: TextInputType.phone,
                textController: controller.phoneController,
              ),
              ProfileField(
                label: "Specialization",
                textController: controller.specializationController,
              ),
              ProfileField(
                label: "Years of Experience",
                keyboardType: TextInputType.number,
                textController: controller.experienceController,
              ),
              ProfileField(
                label: "License Number",
                textController: controller.licenseController,
              ),
              ProfileField(
                maxLines: 3,
                label: "Bio",
                textController: controller.bioController,
              ),
            ],
          ),
          SizedBox(
            height: AdaptiveLayout.getResponsiveFontSize(context, fontSize: 24),
          ),
          ProfileSection(
            title: "Clinic Information",
            children: [
              ProfileField(
                label: "Clinic Address",
                textController: controller.clinicAddressController,
              ),
              SizedBox(
                height: AdaptiveLayout.getResponsiveFontSize(
                  context,
                  fontSize: 8,
                ),
              ),
              InkWell(
                onTap: () async =>
                    await Get.to(() => const ClinicLocationPickerView()),
                child: Container(
                  padding: EdgeInsets.symmetric(
                    vertical: AdaptiveLayout.getResponsiveFontSize(
                      context,
                      fontSize: 12,
                    ),
                    horizontal: AdaptiveLayout.getResponsiveFontSize(
                      context,
                      fontSize: 16,
                    ),
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.accent.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: AppColors.accent),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.map, color: AppColors.accent),
                      SizedBox(
                        width: AdaptiveLayout.getResponsiveFontSize(
                          context,
                          fontSize: 8,
                        ),
                      ),
                      Obx(
                        () => Text(
                          "Pick on Google Maps (${controller.latitude.value.toStringAsFixed(4)}, ${controller.longitude.value.toStringAsFixed(4)})",
                          style: const TextStyle(
                            color: AppColors.accent,
                            fontWeight: FontWeight.bold,
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
            height: AdaptiveLayout.getResponsiveFontSize(context, fontSize: 24),
          ),
          ProfileSection(
            title: "Session Settings",
            children: [
              ProfileField(
                label: "Session Cost Online (USD)",
                textController: controller.sessionCostOnlineController,
                keyboardType: TextInputType.number,
              ),
              ProfileField(
                label: "Session Cost In-Person (USD)",
                textController: controller.sessionCostOfflineController,
                keyboardType: TextInputType.number,
              ),
              const ConsultationToggleSection(),
            ],
          ),
          SizedBox(
            height: AdaptiveLayout.getResponsiveFontSize(context, fontSize: 24),
          ),
          const ProfileSection(
            title: "Available Time Slots",
            children: [TimeSlotPicker()],
          ),
          SizedBox(
            height: AdaptiveLayout.getResponsiveFontSize(context, fontSize: 32),
          ),
          CustomAuthButton(
            onPressed: () async => await controller.updateProfile(),
            backgroundColor: AppColors.accent,
            child: Text(
              "Save Changes",
              style: TextStyle(
                fontSize: AdaptiveLayout.getResponsiveFontSize(
                  context,
                  fontSize: 14,
                ),
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
            height: AdaptiveLayout.getResponsiveFontSize(context, fontSize: 40),
          ),
        ],
      ),
    );
  }
}
