import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../../../../../core/routes/app_routes_name.dart';

class Step3PracticeDetailsController extends GetxController {
  // final DoctorAuthRepository _repository = DoctorAuthRepository();

  // =========================
  // Form Key
  // =========================
  final GlobalKey<FormState> doctorStep3FormKey = GlobalKey<FormState>();

  // =========================
  // Navigation
  // =========================

  RxInt currentDoctorStep = 3.obs;

  // =========================
  // Controllers
  // =========================
  final TextEditingController sessionCostOnlineController = TextEditingController();
  final TextEditingController sessionCostOfflineController = TextEditingController();

  final TextEditingController clinicAddressController = TextEditingController();

  // =========================
  // Consultation Types
  // =========================
  RxBool isOnlineConsultation = false.obs;

  RxBool isInPersonConsultation = false.obs;

  RxBool termsAccepted = false.obs;

  // =========================
  // Methods
  // =========================

  String? commonValidator(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return "Enter $fieldName";
    }

    return null;
  }

  void previousStep() {
    currentDoctorStep.value--;
    Get.back();
  }

  void nextStep() {
    if (doctorStep3FormKey.currentState!.validate()) {
      if (!termsAccepted.value) {
        Get.snackbar(
          "Terms Required",
          "Please accept terms and conditions",
          snackPosition: SnackPosition.BOTTOM,
        );
        return;
      }

      if (!isOnlineConsultation.value && !isInPersonConsultation.value) {
        Get.snackbar(
          "Consultation Type",
          "Please select at least one type",
          snackPosition: SnackPosition.BOTTOM,
        );
        return;
      }

      Get.toNamed(AppRoutesName.rDoctorAuthStep4);
    }
  }

  @override
  void onClose() {
    sessionCostOnlineController.dispose();
    sessionCostOfflineController.dispose();
    clinicAddressController.dispose();

    super.onClose();
  }
}
