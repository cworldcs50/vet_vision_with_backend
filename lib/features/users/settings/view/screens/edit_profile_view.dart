import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../core/classes/adaptive_layout.dart';
import '../../../../../core/network/request_status.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../controller/profile_controller.dart';

class EditProfileView extends GetView<ProfileController> {
  const EditProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        title: const Text(
          'Edit Profile',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
        centerTitle: true,
      ),
      body: Form(
        key: controller.formKey,
        child: ListView(
          padding: EdgeInsets.all(
            AdaptiveLayout.getResponsiveFontSize(context, fontSize: 16),
          ),
          children: [
            // ── Image picker ──────────────────────────────────────────
            _ProfileImagePicker(),
            SizedBox(
              height: AdaptiveLayout.getResponsiveFontSize(
                context,
                fontSize: 20,
              ),
            ),

            // ── Card: Basic Info ──────────────────────────────────────
            _FormCard(
              title: 'Personal Information',
              icon: Icons.person_outline,
              children: [
                CustomUserEditProfileTextFormField(
                  controller: controller.nameCtrl,
                  label: 'Full Name',
                  icon: Icons.person,
                  hint: 'Enter your full name',
                  validator: (v) =>
                      v!.trim().isEmpty ? 'Name is required' : null,
                ),
                SizedBox(
                  height: AdaptiveLayout.getResponsiveFontSize(
                    context,
                    fontSize: 14,
                  ),
                ),
                CustomUserEditProfileTextFormField(
                  controller: controller.emailCtrl,
                  isEnabled: false,
                  label: 'Email',
                  icon: Icons.email_outlined,
                  hint: 'Enter your email',
                  keyboardType: TextInputType.emailAddress,
                  validator: (v) {
                    if (v!.trim().isEmpty) return 'Email is required';
                    if (!GetUtils.isEmail(v.trim())) {
                      return 'Enter a valid email';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: AdaptiveLayout.getResponsiveFontSize(
                    context,
                    fontSize: 14,
                  ),
                ),
                CustomUserEditProfileTextFormField(
                  controller: controller.phoneCtrl,
                  label: 'Phone Number',
                  icon: Icons.phone,
                  hint: 'Enter your phone number',
                  keyboardType: TextInputType.phone,
                  validator: (v) => null,
                ),
                SizedBox(
                  height: AdaptiveLayout.getResponsiveFontSize(
                    context,
                    fontSize: 14,
                  ),
                ),
                CustomUserEditProfileTextFormField(
                  controller: controller.addressCtrl,
                  label: 'Address',
                  icon: Icons.location_on_outlined,
                  hint: 'Enter your address',
                  validator: (v) => null,
                ),
                SizedBox(
                  height: AdaptiveLayout.getResponsiveFontSize(
                    context,
                    fontSize: 14,
                  ),
                ),
                CustomUserEditProfileTextFormField(
                  controller: controller.dobCtrl,
                  label: 'Date of Birth',
                  icon: Icons.calendar_today,
                  hint: 'YYYY-MM-DD',
                  validator: (v) => null,
                ),
              ],
            ),
            SizedBox(
              height: AdaptiveLayout.getResponsiveFontSize(
                context,
                fontSize: 20,
              ),
            ),

            // ── Card: Change Password ─────────────────────────────────
            _FormCard(
              title: 'Change Password (Optional)',
              icon: Icons.lock_outline,
              children: [
                CustomUserEditProfileTextFormField(
                  controller: controller.oldPasswordCtrl,
                  label: 'Current Password',
                  icon: Icons.lock,
                  hint: 'Enter current password',
                  obscureText: true,
                  validator: (v) => null,
                ),
                SizedBox(
                  height: AdaptiveLayout.getResponsiveFontSize(
                    context,
                    fontSize: 14,
                  ),
                ),
                CustomUserEditProfileTextFormField(
                  controller: controller.newPasswordCtrl,
                  label: 'New Password',
                  icon: Icons.lock_reset,
                  hint: 'Enter new password',
                  obscureText: true,
                  validator: (v) => null,
                ),
                SizedBox(
                  height: AdaptiveLayout.getResponsiveFontSize(
                    context,
                    fontSize: 14,
                  ),
                ),
                CustomUserEditProfileTextFormField(
                  obscureText: true,
                  label: 'Confirm Password',
                  hint: 'Confirm new password',
                  icon: Icons.check_circle_outline,
                  controller: controller.confirmPasswordCtrl,
                  validator: (v) {
                    if (controller.newPasswordCtrl.text.isNotEmpty &&
                        v != controller.newPasswordCtrl.text) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                ),
              ],
            ),

            SizedBox(
              height: AdaptiveLayout.getResponsiveFontSize(
                context,
                fontSize: 28,
              ),
            ),

            // ── Submit button ─────────────────────────────────────────
            Obx(() {
              final loading =
                  controller.updateStatus.value == RequestStatus.loading;
              return SizedBox(
                width: double.infinity,
                height: AdaptiveLayout.getResponsiveFontSize(
                  context,
                  fontSize: 52,
                ),
                child: ElevatedButton(
                  onPressed: loading ? null : controller.submitProfileUpdate,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    disabledBackgroundColor: AppColors.primaryColor.withValues(
                      alpha: 0.5,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        AdaptiveLayout.getResponsiveFontSize(
                          context,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    elevation: 0,
                  ),
                  child: loading
                      ? SizedBox(
                          width: AdaptiveLayout.getResponsiveFontSize(
                            context,
                            fontSize: 22,
                          ),
                          height: AdaptiveLayout.getResponsiveFontSize(
                            context,
                            fontSize: 22,
                          ),
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2.5,
                          ),
                        )
                      : Text(
                          'Save Changes',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: AdaptiveLayout.getResponsiveFontSize(
                              context,
                              fontSize: 16,
                            ),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ),
              );
            }),
            SizedBox(
              height: AdaptiveLayout.getResponsiveFontSize(
                context,
                fontSize: 24,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomUserEditProfileTextFormField extends StatelessWidget {
  const CustomUserEditProfileTextFormField({
    super.key,
    required this.controller,
    required this.label,
    required this.hint,
    required this.icon,
    this.isEnabled = true,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    required this.validator,
  });

  final bool isEnabled;
  final bool obscureText;
  final IconData icon;
  final String label, hint;
  final TextInputType keyboardType;
  final TextEditingController controller;
  final String? Function(String?) validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      validator: validator,
      enabled: isEnabled,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: Icon(
          icon,
          color: AppColors.primaryColor,
          size: AdaptiveLayout.getResponsiveFontSize(context, fontSize: 20),
        ),
        filled: true,
        fillColor: Colors.white,
        contentPadding: EdgeInsets.symmetric(
          horizontal: AdaptiveLayout.getResponsiveFontSize(
            context,
            fontSize: 16,
          ),
          vertical: AdaptiveLayout.getResponsiveFontSize(context, fontSize: 14),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            AdaptiveLayout.getResponsiveFontSize(context, fontSize: 12),
          ),
          borderSide: BorderSide(color: Colors.grey.shade200),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            AdaptiveLayout.getResponsiveFontSize(context, fontSize: 12),
          ),
          borderSide: BorderSide(color: Colors.grey.shade200),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            AdaptiveLayout.getResponsiveFontSize(context, fontSize: 12),
          ),
          borderSide: const BorderSide(
            color: AppColors.primaryColor,
            width: 1.5,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            AdaptiveLayout.getResponsiveFontSize(context, fontSize: 12),
          ),
          borderSide: const BorderSide(color: Colors.red),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            AdaptiveLayout.getResponsiveFontSize(context, fontSize: 12),
          ),
          borderSide: const BorderSide(color: Colors.red, width: 1.5),
        ),
      ),
    );
  }
}

// ── Image Picker Widget ────────────────────────────────────────────────────────
class _ProfileImagePicker extends GetView<ProfileController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
      builder: (ctrl) {
        final hasLocalImage = ctrl.pickedImage != null;
        final hasNetworkImage = ctrl.avatarUrl.isNotEmpty;

        return Center(
          child: GestureDetector(
            onTap: ctrl.pickImage,
            child: Stack(
              children: [
                Container(
                  width: AdaptiveLayout.getResponsiveFontSize(
                    context,
                    fontSize: 110,
                  ),
                  height: AdaptiveLayout.getResponsiveFontSize(
                    context,
                    fontSize: 110,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppColors.primaryColor.withValues(alpha: 0.3),
                      width: AdaptiveLayout.getResponsiveFontSize(
                        context,
                        fontSize: 2,
                      ),
                      style: BorderStyle.solid,
                    ),
                  ),
                  child: hasLocalImage
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(
                            AdaptiveLayout.getResponsiveFontSize(
                              context,
                              fontSize: 55,
                            ),
                          ),
                          child: Image.file(
                            ctrl.pickedImage!,
                            fit: BoxFit.cover,
                          ),
                        )
                      : hasNetworkImage
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(
                            AdaptiveLayout.getResponsiveFontSize(
                              context,
                              fontSize: 55,
                            ),
                          ),
                          child: Image.network(
                            ctrl.avatarUrl,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) => Icon(
                              Icons.person,
                              size: AdaptiveLayout.getResponsiveFontSize(
                                context,
                                fontSize: 50,
                              ),
                              color: AppColors.primaryColor,
                            ),
                          ),
                        )
                      : Icon(
                          Icons.person,
                          size: AdaptiveLayout.getResponsiveFontSize(
                            context,
                            fontSize: 50,
                          ),
                          color: AppColors.primaryColor,
                        ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    padding: EdgeInsets.all(
                      AdaptiveLayout.getResponsiveFontSize(
                        context,
                        fontSize: 6,
                      ),
                    ),
                    decoration: const BoxDecoration(
                      color: AppColors.primaryColor,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.camera_alt,
                      size: AdaptiveLayout.getResponsiveFontSize(
                        context,
                        fontSize: 16,
                      ),
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

// ── Reusable card wrapper ──────────────────────────────────────────────────────
class _FormCard extends StatelessWidget {
  const _FormCard({
    required this.title,
    required this.icon,
    required this.children,
  });
  final String title;
  final IconData icon;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(
          AdaptiveLayout.getResponsiveFontSize(context, fontSize: 18),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: AdaptiveLayout.getResponsiveFontSize(
              context,
              fontSize: 10,
            ),
            offset: Offset(
              0,
              AdaptiveLayout.getResponsiveFontSize(context, fontSize: 3),
            ),
          ),
        ],
      ),
      padding: EdgeInsets.all(
        AdaptiveLayout.getResponsiveFontSize(context, fontSize: 18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                icon,
                color: AppColors.primaryColor,
                size: AdaptiveLayout.getResponsiveFontSize(
                  context,
                  fontSize: 18,
                ),
              ),
              SizedBox(
                width: AdaptiveLayout.getResponsiveFontSize(
                  context,
                  fontSize: 8,
                ),
              ),
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: AdaptiveLayout.getResponsiveFontSize(
                    context,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
          Divider(
            height: AdaptiveLayout.getResponsiveFontSize(context, fontSize: 20),
          ),
          ...children,
        ],
      ),
    );
  }
}
