import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../data/models/user_model.dart';
import '../../../../modules/auth/auth_role.dart';
import '../../../../core/classes/validators.dart';
import '../../../../core/services/app_service.dart';
import '../../../../core/network/request_status.dart';
import '../../../../core/routes/app_routes_name.dart';
import '../../../../modules/auth/auth_module_router.dart';
import '../../../../core/classes/base_request_controller.dart';
import '../../../../core/constants/caching_keys_constants.dart';
import '../../../../core/services/authentication_service.dart';

class SignUpController extends BaseRequestController {
  late AuthRole selectedRole;
  void retry() => setStatus(RequestStatus.noData);

  final TextEditingController emailController = TextEditingController();
  final GlobalKey<FormState> signUpFormKey = GlobalKey<FormState>(
    debugLabel: "signUpFormKey",
  );

  final TextEditingController passwordController = TextEditingController();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController confirmedPasswordController =
      TextEditingController();

  bool showPassword = true;
  bool showConfirmedPassword = true;
  IconData showPasswordSuffixIcon = Icons.visibility_outlined;
  IconData showConfirmedPasswordSuffixIcon = Icons.visibility_outlined;
  final AuthenticationService _authService = AuthenticationService();

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

  // Validators
  String? emailValidator(String? email) => Validators.emailValidator(email);
  String? passwordValidator(String? password) =>
      Validators.passwordValidator(password);
  String? fullNameValidator(String? fullName) =>
      Validators.fullNameValidator(fullName);
  String? confirmedPasswordValidator(String? confirmedPassword) =>
      Validators.confirmedPasswordValidator(
        passwordController.text,
        confirmedPassword,
      );

  /// Extracts the first human-readable error message from a Laravel
  /// validation error response. Example input:
  /// {"email": ["This email is already registered."]}
  String _extractErrorMessage(Map result) {
    if (result['message'] != null) {
      // Check if 'data' contains field-level validation errors
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

  Future<void> signUp() async {
    if (!await checkOnline()) return;

    if (!signUpFormKey.currentState!.validate()) return;

    setStatus(RequestStatus.loading);

    final result = await _authService.signUpWithEmailAndPassword(
      role: selectedRole.value,
      email: emailController.text.trim(),
      name: fullNameController.text.trim(),
      password: confirmedPasswordController.text.trim(),
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
      UserModel user = UserModel.fromApiData(
        result['data'],
        confirmedPasswordController.text.trim(),
      );

      (await user.cacheUser(user)).fold(
        (errorMessage) {
          showError("Error", errorMessage);
        },
        (_) async {
          final sharedPrefs = Get.find<AppServices>().appSharedPrefs;
          await sharedPrefs.setBool(CachingKeysConstants.kIsAuthedUser, true);

          showMsg("Success", result['message'] ?? "Account created!");
          await Get.offAllNamed(
            AppRoutesName.rVerifyCodeSignUp,
            arguments: {"email": emailController.text.trim()},
          );
        },
      );
    } else {
      final errorMsg = _extractErrorMessage(result);
      showError("Registration Failed", errorMsg);
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
      UserModel user = UserModel.fromApiData(result['data'], "");

      (await user.cacheUser(user)).fold(
        (errorMessage) {
          showError("Error", errorMessage);
        },
        (_) async {
          final sharedPrefs = Get.find<AppServices>().appSharedPrefs;
          await sharedPrefs.setBool(CachingKeysConstants.kIsAuthedUser, true);
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

  void goToSignIn() async => await Get.offNamed(
    AuthModuleRouter.signInRoute(selectedRole),
    arguments: {'role': selectedRole.value},
  );

  @override
  void onInit() {
    selectedRole = AuthRole.fromValue(Get.arguments?['role']?.toString());
    super.onInit();
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    fullNameController.dispose();
    confirmedPasswordController.dispose();
    super.onClose();
  }
}
