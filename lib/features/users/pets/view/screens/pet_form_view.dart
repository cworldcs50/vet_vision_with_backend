import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../core/classes/adaptive_layout.dart';
import '../../../../../core/network/request_status.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../controller/my_pets_controller.dart';

class PetFormView extends GetView<MyPetsController> {
  const PetFormView({super.key});

  @override
  Widget build(BuildContext context) {
    final isEditing = controller.editingPet != null;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        title: Text(
          isEditing ? 'Edit Pet' : 'Add New Pet',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
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
            _ImagePicker(),
            SizedBox(
              height: AdaptiveLayout.getResponsiveFontSize(
                context,
                fontSize: 20,
              ),
            ),

            // ── Card: Basic Info ──────────────────────────────────────
            _FormCard(
              title: 'Basic Information',
              icon: Icons.info_outline_rounded,
              children: [
                _buildField(
                  controller: controller.nameCtrl,
                  label: 'Pet Name',
                  icon: Icons.pets,
                  hint: 'e.g. Fluffy',
                  validator: (v) =>
                      v!.trim().isEmpty ? 'Name is required' : null,
                ),
                const SizedBox(height: 14),
                _buildField(
                  controller: controller.speciesCtrl,
                  label: 'Species',
                  icon: Icons.category_outlined,
                  hint: 'e.g. Dog, Cat, Bird',
                  validator: (v) =>
                      v!.trim().isEmpty ? 'Species is required' : null,
                ),
                const SizedBox(height: 14),
                _buildField(
                  controller: controller.breedCtrl,
                  label: 'Breed',
                  icon: Icons.blur_circular_outlined,
                  hint: 'e.g. Golden Retriever',
                  validator: (v) =>
                      v!.trim().isEmpty ? 'Breed is required' : null,
                ),
              ],
            ),

            const SizedBox(height: 16),

            // ── Card: Details ─────────────────────────────────────────
            _FormCard(
              title: 'Health Details',
              icon: Icons.monitor_heart_outlined,
              children: [
                // Gender
                _GenderSelector(),
                const SizedBox(height: 14),
                Row(
                  children: [
                    Expanded(
                      child: _buildField(
                        controller: controller.ageCtrl,
                        label: 'Age (years)',
                        icon: Icons.cake_outlined,
                        hint: 'e.g. 3',
                        keyboardType: TextInputType.number,
                        validator: (v) {
                          if (v!.trim().isEmpty) return 'Required';
                          if (int.tryParse(v.trim()) == null) {
                            return 'Must be a number';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildField(
                        controller: controller.weightCtrl,
                        label: 'Weight (kg)',
                        icon: Icons.monitor_weight_outlined,
                        hint: 'e.g. 5.5',
                        keyboardType: const TextInputType.numberWithOptions(
                          decimal: true,
                        ),
                        validator: (v) {
                          if (v!.trim().isEmpty) return 'Required';
                          if (double.tryParse(v.trim()) == null) {
                            return 'Must be a number';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 28),

            // ── Submit button ─────────────────────────────────────────
            Obx(() {
              final loading =
                  controller.formStatus.value == RequestStatus.loading;
              return SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: loading ? null : controller.submitForm,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    disabledBackgroundColor: AppColors.primaryColor.withValues(
                      alpha: 0.5,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    elevation: 0,
                  ),
                  child: loading
                      ? const SizedBox(
                          width: 22,
                          height: 22,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2.5,
                          ),
                        )
                      : Text(
                          isEditing ? 'Save Changes' : 'Add Pet',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ),
              );
            }),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: Icon(icon, color: AppColors.primaryColor, size: 20),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade200),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade200),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: AppColors.primaryColor,
            width: 1.5,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.red),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.red, width: 1.5),
        ),
      ),
    );
  }
}

// ── Image Picker Widget ────────────────────────────────────────────────────────
class _ImagePicker extends GetView<MyPetsController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<MyPetsController>(
      builder: (ctrl) {
        final hasImage = ctrl.pickedImage != null;
        final hasNetworkImage =
            ctrl.editingPet?.imageUrl != null &&
            ctrl.editingPet!.imageUrl!.isNotEmpty;

        return GestureDetector(
          onTap: ctrl.pickImage,
          child: Container(
            height: AdaptiveLayout.getResponsiveFontSize(
              context,
              fontSize: 150,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(
                AdaptiveLayout.getResponsiveFontSize(context, fontSize: 18),
              ),
              border: Border.all(
                color: AppColors.primaryColor.withValues(alpha: 0.3),
                width: 1.5,
                style: BorderStyle.solid,
              ),
            ),
            child: hasImage
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(
                      AdaptiveLayout.getResponsiveFontSize(
                        context,
                        fontSize: 16,
                      ),
                    ),
                    child: Image.file(
                      ctrl.pickedImage!,
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                  )
                : hasNetworkImage
                ? Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(
                          AdaptiveLayout.getResponsiveFontSize(
                            context,
                            fontSize: 16,
                          ),
                        ),
                        child: Image.network(
                          ctrl.editingPet!.imageUrl!,
                          fit: BoxFit.cover,
                          width: double.infinity,
                          errorBuilder: (context, error, stackTrace) => Center(
                            child: Icon(
                              Icons.pets,
                              color: AppColors.primaryColor,
                              size: AdaptiveLayout.getResponsiveFontSize(
                                context,
                                fontSize: 40,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: AdaptiveLayout.getResponsiveFontSize(
                          context,
                          fontSize: 8,
                        ),
                        right: AdaptiveLayout.getResponsiveFontSize(
                          context,
                          fontSize: 8,
                        ),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: AdaptiveLayout.getResponsiveFontSize(
                              context,
                              fontSize: 10,
                            ),
                            vertical: AdaptiveLayout.getResponsiveFontSize(
                              context,
                              fontSize: 4,
                            ),
                          ),
                          decoration: BoxDecoration(
                            color: Colors.black54,
                            borderRadius: BorderRadius.circular(
                              AdaptiveLayout.getResponsiveFontSize(
                                context,
                                fontSize: 20,
                              ),
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.edit,
                                size: AdaptiveLayout.getResponsiveFontSize(
                                  context,
                                  fontSize: 12,
                                ),
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: AdaptiveLayout.getResponsiveFontSize(
                                  context,
                                  fontSize: 4,
                                ),
                              ),
                              Text(
                                'Change',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize:
                                      AdaptiveLayout.getResponsiveFontSize(
                                        context,
                                        fontSize: 11,
                                      ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: AdaptiveLayout.getResponsiveFontSize(
                          context,
                          fontSize: 52,
                        ),
                        height: AdaptiveLayout.getResponsiveFontSize(
                          context,
                          fontSize: 52,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor.withValues(alpha: 0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.add_photo_alternate_outlined,
                          size: AdaptiveLayout.getResponsiveFontSize(
                            context,
                            fontSize: 26,
                          ),
                          color: AppColors.primaryColor,
                        ),
                      ),
                      SizedBox(
                        height: AdaptiveLayout.getResponsiveFontSize(
                          context,
                          fontSize: 10,
                        ),
                      ),
                      const Text(
                        'Tap to add pet photo',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                      SizedBox(
                        height: AdaptiveLayout.getResponsiveFontSize(
                          context,
                          fontSize: 4,
                        ),
                      ),
                      Text(
                        'Optional – JPG or PNG',
                        style: TextStyle(
                          fontSize: AdaptiveLayout.getResponsiveFontSize(
                            context,
                            fontSize: 12,
                          ),
                          color: Colors.grey[500],
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

// ── Gender Selector Widget ─────────────────────────────────────────────────────
class _GenderSelector extends GetView<MyPetsController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<MyPetsController>(
      builder: (ctrl) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.wc_outlined,
                  color: AppColors.primaryColor,
                  size: AdaptiveLayout.getResponsiveFontSize(
                    context,
                    fontSize: 20,
                  ),
                ),
                SizedBox(
                  width: AdaptiveLayout.getResponsiveFontSize(
                    context,
                    fontSize: 8,
                  ),
                ),
                Text(
                  'Gender',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: AdaptiveLayout.getResponsiveFontSize(
                      context,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: AdaptiveLayout.getResponsiveFontSize(
                context,
                fontSize: 10,
              ),
            ),
            Row(
              children: [
                _GenderOption(
                  label: 'Male',
                  icon: Icons.male,
                  color: Colors.blue,
                  isSelected: ctrl.selectedGender == 'male',
                  onTap: () => ctrl.setGender('male'),
                ),
                SizedBox(
                  width: AdaptiveLayout.getResponsiveFontSize(
                    context,
                    fontSize: 12,
                  ),
                ),
                _GenderOption(
                  label: 'Female',
                  icon: Icons.female,
                  color: Colors.pink,
                  isSelected: ctrl.selectedGender == 'female',
                  onTap: () => ctrl.setGender('female'),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}

class _GenderOption extends StatelessWidget {
  const _GenderOption({
    required this.label,
    required this.icon,
    required this.color,
    required this.isSelected,
    required this.onTap,
  });
  final String label;
  final IconData icon;
  final Color color;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: EdgeInsets.symmetric(
            vertical: AdaptiveLayout.getResponsiveFontSize(
              context,
              fontSize: 12,
            ),
          ),
          decoration: BoxDecoration(
            color: isSelected ? color.withValues(alpha: 0.12) : Colors.white,
            borderRadius: BorderRadius.circular(
              AdaptiveLayout.getResponsiveFontSize(context, fontSize: 12),
            ),
            border: Border.all(
              color: isSelected ? color : Colors.grey.shade200,
              width: isSelected ? 1.5 : 1,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: AdaptiveLayout.getResponsiveFontSize(
                  context,
                  fontSize: 18,
                ),
                color: isSelected ? color : Colors.grey,
              ),
              SizedBox(
                width: AdaptiveLayout.getResponsiveFontSize(
                  context,
                  fontSize: 6,
                ),
              ),
              Text(
                label,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: isSelected ? color : Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
      ),
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
