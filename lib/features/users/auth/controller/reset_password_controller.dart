import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/classes/base_request_controller.dart';
import '../../../../core/classes/validators.dart';
import '../../../../core/network/request_status.dart';
import '../../../../core/routes/app_routes_name.dart';
import '../../../../core/services/authentication_service.dart';

class ResetPasswordController extends BaseRequestController {
  final AuthenticationService _authService = AuthenticationService();
  final GlobalKey<FormState> resetPasswordFormKey = GlobalKey<FormState>(
    debugLabel: "resetPasswordFormKey",
  );

  late final String email;
  late final String code;
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmedPasswordController =
      TextEditingController();

  bool showPassword = true;
  bool showConfirmedPassword = true;
  IconData showPasswordSuffixIcon = Icons.visibility_outlined;
  IconData showConfirmedPasswordSuffixIcon = Icons.visibility_outlined;

  @override
  void onInit() {
    email = Get.arguments['email'] ?? '';
    code = Get.arguments['code'] ?? '';
    super.onInit();
  }

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

  String? passwordValidator(String? password) =>
      Validators.passwordValidator(password);
  String? confirmedPasswordValidator(String? confirmedPassword) =>
      Validators.confirmedPasswordValidator(
        passwordController.text,
        confirmedPassword,
      );

  /// Extracts the first human-readable error message from a Laravel
  /// validation error response. Example input:
  /// {"password": ["The password must be at least 8 characters."]}
  String _extractErrorMessage(Map result) {
    if (result['message'] != null) {
      if (result['data'] is Map) {
        final data = result['data'] as Map;
        for (final value in data.values) {
          if (value is List && value.isNotEmpty) {
            return value.first.toString();
          }
        }
      }
      return result['message'].toString();
    }
    return "An unexpected error occurred";
  }

  Future<void> resetPassword() async {
    // Prevent multiple requests (e.g., from double-tapping the button)
    // Multiple Get.offAllNamed calls cause Duplicate GlobalKey exceptions.
    if (requestStatus.value == RequestStatus.loading) return;

    if (!await checkOnline()) return;

    if (!resetPasswordFormKey.currentState!.validate()) return;

    if (code.length < 6) {
      showError("Validation Error", "Invalid code passed.");
      return;
    }

    setStatus(RequestStatus.loading);

    final result = await _authService.resetPassword(
      email: email,
      code: code,
      password: passwordController.text.trim(),
      passwordConfirmation: confirmedPasswordController.text.trim(),
    );

    final RequestStatus networkStatus = result['request_status'];

    if (networkStatus == RequestStatus.offlineFailure) {
      showError("No Connection", "Please check your internet connection");
      return;
    }
    if (networkStatus == RequestStatus.failure) {
      showError("Error", "Connection failed. Please try again.");
      return;
    }

    if (result['status'] == true) {
      showMsg("Success", result['message'] ?? "Password reset successfully!");
      // Send user back to sign in screen
      await Get.offAllNamed(AppRoutesName.rDoctorSignIn);
    } else {
      final errorMsg = _extractErrorMessage(result);
      showError("Reset Failed", errorMsg);
    }
  }

  @override
  void onClose() {
    passwordController.dispose();
    confirmedPasswordController.dispose();
    super.onClose();
  }
}
