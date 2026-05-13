import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../doctor_portal_controller.dart';
import '../../widgets/profile_field.dart';
import '../../widgets/profile_section.dart';
import '../../widgets/profile_image_header.dart';
import '../../widgets/time_slot_picker_mock.dart';
import '../../widgets/consultation_toggle_section.dart';
import '../../../../core/classes/adaptive_layout.dart';
import '../custom_auth_button.dart';

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
                textController: controller.emailController,
                keyboardType: TextInputType.emailAddress,
              ),
              ProfileField(
                label: "Phone Number",
                textController: controller.phoneController,
                keyboardType: TextInputType.phone,
              ),
              ProfileField(
                label: "Specialization",
                textController: controller.specializationController,
              ),
              ProfileField(
                label: "Years of Experience",
                textController: controller.experienceController,
                keyboardType: TextInputType.number,
              ),
              ProfileField(
                label: "License Number",
                textController: controller.licenseController,
              ),
              ProfileField(
                label: "Bio",
                textController: controller.bioController,
                maxLines: 3,
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
                label: "Session Cost (USD)",
                textController: controller.sessionCostController,
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
            children: [TimeSlotPickerMock()],
          ),
          SizedBox(
            height: AdaptiveLayout.getResponsiveFontSize(context, fontSize: 32),
          ),
          CustomAuthButton(
            onPressed: () {
              Get.snackbar(
                "Success",
                "Profile updated successfully",
                backgroundColor: Colors.green,
                colorText: Colors.white,
              );
            },
            backgroundColor: const Color(0xFF009689),
            child: const Text(
              "Save Changes",
              style: TextStyle(
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
