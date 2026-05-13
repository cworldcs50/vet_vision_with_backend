import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../../../core/classes/base_request_controller.dart';
import '../../../../core/classes/validators.dart';
import '../../../../core/network/request_status.dart';
import '../../../../core/routes/app_routes_name.dart';
import '../../../../core/services/authentication_service.dart';

class ForgetPasswordController extends BaseRequestController {
  final AuthenticationService _authService = AuthenticationService();
  final GlobalKey<FormState> forgetPasswordFormKey = GlobalKey<FormState>(
    debugLabel: "forgetPasswordFormKey",
  );
  final TextEditingController emailController = TextEditingController();

  String? emailValidator(String? email) => Validators.emailValidator(email);

  Future<void> sendResetCode() async {
    if (!await checkOnline()) return;
    if (!forgetPasswordFormKey.currentState!.validate()) return;

    setStatus(RequestStatus.loading);

    final result = await _authService.forgetPassword(
      emailController.text.trim(),
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
      showMsg(
        "Code Sent",
        result['message'] ?? "Reset code sent to your email",
      );
      await Get.toNamed(
        AppRoutesName.rVerifyCodeForgetPassword,
        arguments: {"email": emailController.text.trim()},
      );
    } else {
      showError("Error", result['message'] ?? "Failed to send reset code");
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    super.onClose();
  }
}
