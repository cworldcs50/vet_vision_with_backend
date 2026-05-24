import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../../../core/routes/app_routes_name.dart';

class Step2ProfessionalDetailsController extends GetxController {
  // =========================
  // Form Key
  // =========================
  final GlobalKey<FormState> doctorStep2FormKey = GlobalKey<FormState>();

  // =========================
  // Navigation
  // =========================

  RxInt currentDoctorStep = 2.obs;

  // =========================
  // Controllers
  // =========================
  final TextEditingController specializationController =
      TextEditingController();

  final TextEditingController experienceController = TextEditingController();

  final TextEditingController licenseController = TextEditingController();

  final TextEditingController bioController = TextEditingController();

  // =========================
  // Image Picker
  // =========================
  final ImagePicker imagePicker = ImagePicker();

  XFile? profileImage;

  // =========================
  // Methods
  // =========================

  bool _isPicked = false;

  Future<void> pickImage() async {
    if (_isPicked) {
      return;
    }

    _isPicked = true;

    final XFile? image = await imagePicker.pickImage(
      source: ImageSource.gallery,
    );

    if (image != null) {
      profileImage = image;
      update();
    }

    _isPicked = false;
  }

  void nextStep() {
    if (doctorStep2FormKey.currentState!.validate()) {
      if (profileImage == null) {
        Get.snackbar(
          "Image Required",
          "Please upload a profile picture",
          snackPosition: SnackPosition.BOTTOM,
        );
        return;
      }

      currentDoctorStep.value = 3;
      Get.toNamed(AppRoutesName.rDoctorAuthStep3);
    }
  }

  void previousStep() {
    currentDoctorStep.value--;
    Get.back();
  }

  @override
  void onClose() {
    specializationController.dispose();
    experienceController.dispose();
    licenseController.dispose();
    bioController.dispose();

    super.onClose();
  }
}
