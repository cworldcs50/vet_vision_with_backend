import 'dart:developer';
import 'package:get/get.dart';
import '../../../../core/network/request_status.dart';
import '../../../../core/services/app_service.dart';
import '../../../../core/classes/base_request_controller.dart';
import '../../../../core/constants/caching_keys_constants.dart';
import '../../../../core/services/authentication_service.dart';
import '../../../../modules/auth/auth_module_router.dart';
import '../../../../modules/auth/auth_role.dart';
import '../data/models/user_model.dart';
import '../data/datasource/remote/verification_code_data.dart';

abstract class VerifyCodeSignUp extends BaseRequestController {
  Future<void> checkCode();
  Future<void> resendVerificationCode();
}

class VerifyCodeSignUpImp extends VerifyCodeSignUp {
  late final String userGmail;
  late String verificationCode;
  late final VerificationCodeData verificationCodeData;
  final AuthenticationService _authService = AuthenticationService();

  String _homeAfterVerify(Map result) {
    final role = AuthRole.fromValue(
      result['data']?['user']?['role']?.toString(),
    );
    return AuthModuleRouter.homeRoute(role);
  }

  @override
  void onInit() {
    verificationCode = "";
    userGmail = Get.arguments['email'];
    verificationCodeData = VerificationCodeData(
      api: Get.find<AppServices>().crud,
    );
    super.onInit();
  }

  @override
  Future<void> checkCode() async {
    if (verificationCode.length < 6) {
      showError("Error", "Please enter the full 6-digit code");
      return;
    }

    if (!await checkOnline()) return;

    setStatus(RequestStatus.loading);

    final result = await verificationCodeData.verifyEmail(
      userGmail,
      verificationCode,
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
      log("Sign up success data: $result");
      UserModel user = UserModel.fromApiData(result['data'], "");

      (await user.cacheUser(user)).fold(
        (errorMessage) {
          showError("Error", errorMessage);
        },
        (_) async {
          final sharedPrefs = Get.find<AppServices>().appSharedPrefs;
          await sharedPrefs.setBool(CachingKeysConstants.kIsAuthedUser, true);

          showMsg("Success", result['message'] ?? "Email verified!");
          await Get.offAllNamed(_homeAfterVerify(result));
        },
      );
    } else {
      final message = result['message'] ?? "Verification failed";
      showError("Verification Failed", message.toString());
    }
  }

  @override
  Future<void> resendVerificationCode() async {
    if (!await checkOnline()) return;

    setStatus(RequestStatus.loading);

    final result = await _authService.forgetPassword(userGmail);

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
        result['message'] ?? "A new code has been sent to your email",
      );
    } else {
      showError("Error", result['message'] ?? "Failed to resend code");
    }
  }
}
