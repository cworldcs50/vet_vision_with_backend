import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../data/models/user_model.dart';
import '../../../../modules/auth/auth_role.dart';
import '../../../../core/classes/validators.dart';
import '../../../../core/services/app_service.dart';
import '../../../../core/routes/app_routes_name.dart';
import '../../../../core/network/request_status.dart';
import '../../../../modules/auth/auth_module_router.dart';
import '../../../../core/classes/base_request_controller.dart';
import '../../../../core/constants/caching_keys_constants.dart';
import '../../../../core/services/authentication_service.dart';

class SignInController extends BaseRequestController {
  final AuthenticationService _authService = AuthenticationService();
  final _sharedPrefs = Get.find<AppServices>().appSharedPrefs;
  late AuthRole selectedRole;

  final GlobalKey<FormState> signInFormKey = GlobalKey<FormState>(
    debugLabel: "signInFormKey",
  );

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool showPassword = true;
  IconData showPasswordSuffixIcon = Icons.visibility_outlined;

  void visiblePassword() {
    showPassword = !showPassword;
    showPasswordSuffixIcon = showPassword
        ? Icons.visibility_outlined
        : Icons.visibility_off_outlined;
    update();
  }

  String? emailValidator(String? email) => Validators.emailValidator(email);

  String? passwordValidator(String? password) =>
      Validators.commonValidator(password, "password");

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

  String _resolveRoleRoute(Map result) {
    final role = AuthRole.fromValue(
      result['data']?['user']?['role']?.toString(),
    );
    return AuthModuleRouter.homeRoute(role);
  }

  bool _isRoleCompatible(Map result) {
    final apiRole = AuthRole.fromValue(
      result['data']?['user']?['role']?.toString(),
    );
    return apiRole == selectedRole;
  }

  Future<void> signIn() async {
    if (!await checkOnline()) return;

    if (!signInFormKey.currentState!.validate()) return;

    setStatus(RequestStatus.loading);

    final result = await _authService.signInWithEmailAndPassword(
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
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
      if (!_isRoleCompatible(result)) {
        showError(
          "Role Mismatch",
          "This account is not registered as ${selectedRole.value}.",
        );
        return;
      }

      UserModel user = UserModel.fromApiData(
        result['data'],
        passwordController.text.trim(),
      );

      (await user.cacheUser(user)).fold(
        (errorMessage) {
          showError("Error", errorMessage);
        },
        (_) async {
          await _sharedPrefs.setBool(CachingKeysConstants.kIsAuthedUser, true);
          showMsg("Success", result['message'] ?? "Logged in!");
          await Get.offAllNamed(_resolveRoleRoute(result));
        },
      );
    } else if (result['status'] == false &&
        result["data"] != null &&
        result["data"]["needs_verification"] == true) {
      showMsg(
        "Verification Required",
        result['message'] ?? "Please verify your email",
      );
      await Get.toNamed(
        selectedRole == AuthRole.doctor
            ? AppRoutesName.rDoctorVerifyCode
            : AppRoutesName.rVerifyCodeSignUp,
        arguments: {
          "email": result["data"]["email"] ?? emailController.text.trim(),
        },
      );
    } else {
      final errorMsg = _extractErrorMessage(result);
      showError("Login Failed", errorMsg);
    }
  }

  Future<void> _handleSocialAuthResponse(dynamic result) async {
    if (result == null || result is! Map) {
      showError("Error", "Unexpected response from authentication provider");
      return;
    }

    final RequestStatus networkStatus =
        result['request_status'] ?? RequestStatus.success;

    if (networkStatus == RequestStatus.offlineFailure) {
      showError("No Connection", "Please check your internet connection");
      return;
    }
    if (networkStatus == RequestStatus.failure) {
      showError("Error", "Connection failed. Please try again.");
      return;
    }

    if (result['status'] == true) {
      if (!_isRoleCompatible(result)) {
        showError(
          "Role Mismatch",
          "This account is not registered as ${selectedRole.value}.",
        );
        return;
      }

      UserModel user = UserModel.fromApiData(result['data'], "");

      (await user.cacheUser(user)).fold(
        (errorMessage) {
          showError("Error", errorMessage);
        },
        (_) async {
          await _sharedPrefs.setBool(CachingKeysConstants.kIsAuthedUser, true);
          showMsg("Success", result['message'] ?? "Logged in successfully!");
          await Get.offAllNamed(_resolveRoleRoute(result));
        },
      );
    } else {
      final errorMsg = _extractErrorMessage(result);
      showError("Login Failed", errorMsg);
    }
  }

  Future<void> authWithGoogle() async {
    if (!await checkOnline()) return;
    setStatus(RequestStatus.loading);
    final result = await _authService.authWithGoogle();
    if (result['status'] == false && result['request_status'] == null) {
      setStatus(RequestStatus.noData);
      showError("Failed", result['message'] ?? "Google Sign-In failed");
      return;
    }
    await _handleSocialAuthResponse(result);
  }

  Future<void> authWithFacebook() async {
    if (!await checkOnline()) return;
    setStatus(RequestStatus.loading);
    final result = await _authService.authWithFacebook();
    if (result['status'] == false && result['request_status'] == null) {
      setStatus(RequestStatus.noData);
      showError("Failed", result['message'] ?? "Facebook Sign-In failed");
      return;
    }
    await _handleSocialAuthResponse(result);
  }

  void goToSignUp() async => await Get.offNamed(
    AuthModuleRouter.signUpRoute(selectedRole),
    arguments: {'role': selectedRole.value},
  );

  void forgetPassword() async =>
      await Get.toNamed(AppRoutesName.rForgetPassword);

  void retry() => setStatus(RequestStatus.noData);

  @override
  void onInit() {
    selectedRole = AuthRole.fromValue(Get.arguments?['role']?.toString());
    super.onInit();
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
