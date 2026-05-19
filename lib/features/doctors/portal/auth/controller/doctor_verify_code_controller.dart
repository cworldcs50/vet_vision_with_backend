import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart' as dio;
import '../../../../../../core/services/app_service.dart';
import '../../../../../../core/constants/caching_keys_constants.dart';
import '../../../../../../core/routes/app_routes_name.dart';
import '../data/repository/doctor_auth_repository.dart';

class DoctorVerifyCodeController extends GetxController {
  final DoctorAuthRepository _repository = DoctorAuthRepository();
  late String email;
  String verificationCode = "";

  @override
  void onInit() {
    email = Get.arguments['email'] ?? "";
    super.onInit();
  }

  Future<void> verifyCode() async {
    if (verificationCode.length < 6) {
      Get.snackbar(
        "Error",
        "Please enter the full 6-digit code",
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    try {
      Get.dialog(
        const Center(child: CircularProgressIndicator(color: Color(0xFF009689))),
        barrierDismissible: false,
      );

      final response = await _repository.verifyEmail(email, verificationCode);
      Get.back(); // close loading

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = response.data['data'] ?? response.data;
        final token = data['access_token'];

        if (token != null) {
          final prefs = Get.find<AppServices>().appSharedPrefs;
          await prefs.setString(CachingKeysConstants.kUserToken, token);
        }

        Get.snackbar(
          "Success",
          "Email verified successfully!",
          snackPosition: SnackPosition.BOTTOM,
        );
        Get.offNamed(AppRoutesName.rDoctorAuthStep2);
      }
    } on dio.DioException catch (e) {
      Get.back(); // close loading
      final responseData = e.response?.data;
      String errorMsg = "Verification failed";

      if (responseData != null) {
        errorMsg = responseData['message'] ?? errorMsg;
      }
      Get.snackbar("Error", errorMsg, snackPosition: SnackPosition.BOTTOM);
    } catch (e) {
      Get.back();
      Get.snackbar("Error", e.toString(), snackPosition: SnackPosition.BOTTOM);
    }
  }

  Future<void> resendCode() async {
    try {
      Get.dialog(
        const Center(child: CircularProgressIndicator(color: Color(0xFF009689))),
        barrierDismissible: false,
      );
      await _repository.resendVerificationCode(email);
      Get.back();
      Get.snackbar(
        "Success",
        "Verification code resent!",
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      Get.back();
      Get.snackbar("Error", "Failed to resend code", snackPosition: SnackPosition.BOTTOM);
    }
  }
}
