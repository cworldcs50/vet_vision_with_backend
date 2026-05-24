import 'dart:developer';

import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import '../data/repository/doctor_auth_repository.dart';
import '../../../../../../core/services/app_service.dart';
import '../../../../../../core/routes/app_routes_name.dart';
import '../../../../../../core/constants/caching_keys_constants.dart';

abstract class IStep1PersonalInfo {
  const IStep1PersonalInfo();
}

class Step1PersonalInfoController extends GetxController
    implements IStep1PersonalInfo {
  final DoctorAuthRepository _repository = DoctorAuthRepository();

  // =========================
  // Form Key
  // =========================
  final GlobalKey<FormState> doctorStep1FormKey = GlobalKey<FormState>();

  // =========================
  // Navigation
  // =========================

  RxInt currentDoctorStep = 1.obs;

  // =========================
  // Controllers
  // =========================
  final TextEditingController fullNameController = TextEditingController();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController phoneController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final TextEditingController confirmedPasswordController =
      TextEditingController();

  // =========================
  // Password Visibility
  // =========================
  bool showPassword = true;
  bool showConfirmedPassword = true;

  IconData showPasswordSuffixIcon = Icons.visibility_outlined;

  IconData showConfirmedPasswordSuffixIcon = Icons.visibility_outlined;

  // =========================
  // Methods
  // =========================

  void visiblePassword() {
    showPassword = !showPassword;

    showPasswordSuffixIcon = showPassword
        ? Icons.visibility_outlined
        : Icons.visibility_off_outlined;

    update();
  }

  void visibleConfirmedPassword() {
    showConfirmedPassword = !showConfirmedPassword;

    showConfirmedPasswordSuffixIcon = showConfirmedPassword
        ? Icons.visibility_outlined
        : Icons.visibility_off_outlined;

    update();
  }

  void nextStep() async {
    if (doctorStep1FormKey.currentState!.validate()) {
      try {
        Get.dialog(
          const Center(
            child: CircularProgressIndicator(color: Color(0xFF009689)),
          ),
          barrierDismissible: false,
        );

        final userData = {
          'role': 'doctor',
          'email': emailController.text,
          'name': fullNameController.text,
          'password': passwordController.text,
        };

        final response = await _repository.registerStep1(userData);
        Get.back(); // close loading

        if (response.statusCode == 201 || response.statusCode == 200) {
          final data = response.data['data'] ?? response.data;
          final token = data['access_token'];

          if (token != null) {
            final prefs = Get.find<AppServices>().appSharedPrefs;
            await prefs.setString(CachingKeysConstants.kUserToken, token);
          }

          currentDoctorStep.value = 2;
          Get.toNamed(
            AppRoutesName.rDoctorVerifyCode,
            arguments: {'email': emailController.text},
          );
        }
      } on dio.DioException catch (e) {
        Get.back(); // close loading
        final responseData = e.response?.data;
        String errorMsg = "Registration failed";

        if (responseData != null) {
          final errors = responseData['data'] ?? responseData['errors'];
          if (errors is Map) {
            errorMsg = errors.values
                .map((v) {
                  if (v is List) return v.join("\n");
                  return v.toString();
                })
                .join("\n");
          } else {
            errorMsg = responseData['message'] ?? errorMsg;
          }
        }
        Get.snackbar(
          "Error from backend",
          errorMsg,
          snackPosition: SnackPosition.BOTTOM,
        );
        log(errorMsg);
      } catch (e) {
        Get.back();
        Get.snackbar(
          "Error unexcepted exception",
          e.toString(),
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    phoneController.dispose();
    fullNameController.dispose();
    passwordController.dispose();
    confirmedPasswordController.dispose();
    super.onClose();
  }
}
